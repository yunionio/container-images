FROM registry.cn-beijing.aliyuncs.com/yunionio/openvswitch:2.9.6-1

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

ADD files/opt/yunion/bin /opt/yunion/bin
ADD files/opt/yunion/fetchclient/bin /opt/yunion/fetchclient/bin
