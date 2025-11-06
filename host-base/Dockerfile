FROM registry.cn-beijing.aliyuncs.com/yunionio/openvswitch:2.12.4-5

ARG TARGETPLATFORM
ARG BUILDPLATFORM

LABEL maintainer="Yaoqi Wan <wanyaoqi@yunion.cn>"

RUN sed -i 's!https://dl-cdn.alpinelinux.org/!https://mirrors.ustc.edu.cn/!g' /etc/apk/repositories

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
	util-linux \
	tzdata \
	xorriso

RUN find /var/cache/ -type f | xargs rm -vf

# install nerdctl for containerd management
RUN cd /tmp && \
	wget https://github.com/containerd/nerdctl/releases/download/v1.7.7/nerdctl-1.7.7-linux-`echo $TARGETPLATFORM | cut -d / -f 2`.tar.gz && \
	tar xf nerdctl-1.7.7-linux-`echo $TARGETPLATFORM | cut -d / -f 2`.tar.gz && \
	mv nerdctl /usr/sbin && rm *
