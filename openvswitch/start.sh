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
	ovnctl start_northd \
		--db-nb-create-insecure-remote \
		--db-sb-create-insecure-remote \

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

controller() {
	ovnctl start_controller

	log ovn-controller &

	while true; do
		sleep 7

		cnt="$(ovnctl status_controller | tee | grep 'is running' | wc -l)"
		if [ "$cnt" -lt 1 ]; then
			ovnctl status_controller
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
