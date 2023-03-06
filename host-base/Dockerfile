FROM registry.cn-beijing.aliyuncs.com/yunionio/openvswitch:2.12.4-2

MAINTAINER Yaoqi Wan <wanyaoqi@yunion.cn>

# coreutils: cp, uname
# util-linux: mount
# kmod: lsmod, modinfo, modprobe, rmmod
# pciutils: lspci
RUN apk add \
	blkid \
	coreutils \
	dmidecode \
	ethtool \
	iptables \
	kmod \
	pciutils \
	util-linux

RUN find /var/cache/ -type f | xargs rm -vf
