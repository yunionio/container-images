FROM registry.cn-beijing.aliyuncs.com/yunionio/onecloud-base:v0.2

MAINTAINER Yaoqi Wan <wanyaoqi@yunion.cn>

RUN apk add alpine-sdk

RUN set -x \
	&& adduser -D yunion \
	&& addgroup yunion abuild \
	&& sudo -u yunion abuild-keygen -n --quiet --append \
	&& cp /home/yunion/.abuild/yunion-*.pub /etc/apk/keys

ENV \
	NTFS_APORT=/home/yunion/ntfs-3g \
	NTFS_APORT_PKGS=/home/yunion/ntfs-3g/packages

RUN set -x \
	&& mkdir -p $NTFS_APORT \
	&& mkdir -p $NTFS_APORT_PKGS

ADD ./aport $NTFS_APORT

RUN set -x \
	&& chown -R yunion:yunion $NTFS_APORT \
	&& cd $NTFS_APORT \
	&& sudo -u yunion abuild -r -P $NTFS_APORT_PKGS

RUN set -x \
	&& echo @yunion file://$NTFS_APORT_PKGS/yunion >>/etc/apk/repositories \
	&& apk add ntfs-3g@yunion ntfs-3g-progs@yunion \
	&& cd $NTFS_APORT \
	&& sudo -u yunion abuild -P $NTFS_APORT_PKGS clean cleancache cleanpkg \
	&& apk del alpine-sdk

RUN apk add \
	blkid \
	coreutils \
	dmidecode \
	ethtool \
	iptables \
	kmod \
	pciutils \
	util-linux \
	xfsprogs \
	xfsprogs-extra \
	lvm2 \
	gptfdisk \
	e2fsprogs \
	e2fsprogs-extra \
	dosfstools \
	parted

# zerofree only exist at testing repository
RUN apk add zerofree --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

ADD usr/bin/chntpw.static /usr/bin/chntpw.static
ADD usr/bin/.chntpw.static.bin /usr/bin/.chntpw.static.bin
ADD usr/bin/bundles/chntpw.static /usr/bin/bundles/chntpw.static
ADD opt/vmware-vddk/bin /opt/vmware-vddk/bin
ADD usr/lib/vmware /usr/lib/vmware

RUN find /var/cache/ -type f | xargs rm -vf
