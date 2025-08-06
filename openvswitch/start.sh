#!/bin/sh

ovnctl() {
	/usr/share/openvswitch/scripts/ovn-ctl "$@"
}

log() {
	local n="$1"
	local f="/var/log/openvswitch/$1.log"

	while [ ! -s "$f" ]; do
		sleep 1
	done
	tail -f "$f"  | sed -e "s/^/$n: /"
}

north() {
	local cnt
	local ipv6_mode=false

	# check is ipv6 cluster
	if [ "$1" = "ipv6" ]; then
		ipv6_mode=true
		shift
	fi

	local start_cmd="ovnctl start_northd \
		--db-nb-create-insecure-remote \
		--db-sb-create-insecure-remote"

	# ipv6 mode set ipv6 listen addr
	if [ "$ipv6_mode" = true ]; then
		start_cmd="$start_cmd \
			--db-nb-addr=\"[::]\" \
			--db-sb-addr=\"[::]\""
	fi

	eval "$start_cmd"

	log ovn-northd &
	log ovsdb-server-nb &
	log ovsdb-server-sb &

	while true; do
		sleep 7

		cnt="$(ovnctl status_northd | tee | grep 'is running' | wc -l)"
		if [ "$cnt" -lt 1 ]; then
			ovnctl status_northd
			return 1
		fi

		cnt="$(ovnctl status_ovsdb | tee | grep 'is running' | wc -l)"
		if [ "$cnt" -lt 2 ]; then
			ovnctl status_ovsdb
			return 1
		fi
	done
}

controller_get_ovn_remote() {
	local remote
	local q='"'

	remote="$(ovs-vsctl --bare get Open_vSwitch . external_ids:ovn-remote)"
	remote="${remote#$q}"
	remote="${remote%$q}"
	echo "$remote"
}

controller_test_ovn_remote() {
	local remote="$1"

	if [ -z "$remote" ]; then
		ovn-sbctl --timeout=3 find Chassis >/dev/null
	else
		ovn-sbctl --db="$remote" --timeout=3 find Chassis >/dev/null
	fi
}

controller() {
	local cnt
	local remote0 remote
	local stime etime elapsed

	# wait working ovn remote
	while true; do
		remote0="$(controller_get_ovn_remote)"
		stime="$(date +%s)"
		if controller_test_ovn_remote "$remote0"; then
			break
		fi
		etime="$(date +%s)"
		elapsed="$((etime - stime))"
		if [ "$elapsed" -lt 3 ]; then
			sleep "$((3 - elapsed))"
		fi
	done

	ovnctl start_controller

	log ovn-controller &

	while true; do
		sleep 7

		cnt="$(ovnctl status_controller | tee | grep 'is running' | wc -l)"
		if [ "$cnt" -lt 1 ]; then
			ovnctl status_controller
			return 1
		fi

		remote="$(controller_get_ovn_remote)"
		if [ "$remote" != "$remote0" ]; then
			echo "ovn-controller: ovn-remote changed from $remote0 to $remote" >&2
			return 1
		fi
		if ! controller_test_ovn_remote "$remote"; then
			return 1
		fi
	done
}

if [ "$#" = 0 ]; then
	echo "usage: $0 [north|controller]" >&2
	exit 1
fi

mkdir -p /var/run/openvswitch
mkdir -p /var/log/openvswitch
"$@"
