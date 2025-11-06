FROM alpine:3.20.6

LABEL maintainer="Yousong Zhou <zhouyousong@yunion.cn>"

RUN sed -i 's!https://dl-cdn.alpinelinux.org/!https://mirrors.ustc.edu.cn/!g' /etc/apk/repositories

RUN apk add alpine-sdk
RUN apk add sudo
RUN apk add iptables ip6tables
RUN apk add iproute2

RUN set -x \
	&& adduser -D yunion \
	&& addgroup yunion abuild \
	&& sudo -u yunion abuild-keygen -n --quiet --append \
	&& cp /home/yunion/.abuild/yunion-*.pub /etc/apk/keys

ENV \
	OVS_APORT=/home/yunion/ovs \
	OVS_APORT_PKGS=/home/yunion/ovs/packages

RUN set -x \
	&& mkdir -p $OVS_APORT \
	&& mkdir -p $OVS_APORT_PKGS

ADD ./aport $OVS_APORT

RUN set -x \
	&& chown -R yunion:yunion $OVS_APORT \
	&& cd $OVS_APORT \
	&& sudo -u yunion abuild -r -P $OVS_APORT_PKGS

RUN set -x \
	&& echo @yunion file://$OVS_APORT_PKGS/yunion >>/etc/apk/repositories \
	&& apk add openvswitch@yunion openvswitch-ovn@yunion \
	&& cd $OVS_APORT \
	&& sudo -u yunion abuild -P $OVS_APORT_PKGS clean cleancache cleanpkg \
	&& apk del alpine-sdk \
	&& find /var/cache/ -type f | xargs rm -vf

ADD ./start.sh /
