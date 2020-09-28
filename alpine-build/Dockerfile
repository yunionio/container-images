FROM alpine:3.12.0

MAINTAINER Yousong Zhou <zhouyousong@yunion.cn>

RUN apk add alpine-sdk
RUN apk add go
RUN apk add ceph-dev
RUN apk add linux-headers

ENV GOPATH="/root/go"
ENV PATH="${GOPATH}/bin:${PATH}"

RUN set -x \
	&& mkdir -p "$GOPATH" \
	&& d="$GOPATH/src/golang.org/x/tools" \
	&& mkdir -p "$d" \
	&& git clone --branch yun --depth 4 https://github.com/yousong/tools "$d" \
	&& cd "$d" \
	&& go install ./cmd/goimports
