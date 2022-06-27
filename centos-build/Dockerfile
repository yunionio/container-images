FROM centos:7

ARG TARGETPLATFORM
ARG BUILDPLATFORM

MAINTAINER Yousong Zhou <zhouyousong@yunion.cn>

RUN set -x \
	&& /usr/bin/yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
	&& /usr/bin/yum install -y git wget \
	&& /usr/bin/yum groupinstall -y "Development Tools" \
	&& rpm --import 'https://download.ceph.com/keys/release.asc' \
	&& /usr/bin/yum install -y https://download.ceph.com/rpm-luminous/el7/noarch/ceph-release-1-1.el7.noarch.rpm \
	&& /usr/bin/yum install -y libcephfs-devel librbd-devel librados-devel \
	&& /usr/bin/yum clean all

WORKDIR /opt
RUN set -x \
	&& curl https://dl.google.com/go/go1.16.5.linux-`echo $TARGETPLATFORM | cut -d / -f 2`.tar.gz -O \
	&& /usr/bin/tar xvf go1.16.5.linux-`echo $TARGETPLATFORM | cut -d / -f 2`.tar.gz \
	&& rm -vf  go1.16.5.linux-`echo $TARGETPLATFORM | cut -d / -f 2`.tar.gz

ENV GOROOT="/opt/go"
ENV GOBIN="/opt/go/bin"
ENV GOPATH="/root/godev"
ENV PATH="${GOPATH}/bin:${GOBIN}:${PATH}"

ENV GOPROXY=https://mirrors.aliyun.com/goproxy/,https://proxy.golang.org,direct

RUN set -x \
	&& mkdir -p "$GOPATH" \
	&& d="$GOPATH/src/golang.org/x/tools" \
	&& mkdir -p "$d" \
	&& git clone --branch yun --depth 4 https://github.com/yousong/tools "$d" \
	&& cd "$d" \
	&& go install ./cmd/goimports

RUN set -x \
	&& mkdir -p "$GOPATH" \
	&& d="$GOPATH/src/yunion.io/x/y18n" \
	&& mkdir -p "$d" \
	&& git clone --depth 4 https://github.com/yousong/y18n "$d" \
	&& cd "$d" \
	&& go install .
