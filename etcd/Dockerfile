FROM registry.cn-beijing.aliyuncs.com/yunionio/alpine-build:3.22.2-go-1.24.9-0 AS builder

# 定义 etcd 版本（使用最新稳定版，可从 https://github.com/etcd-io/etcd/releases 获取）
ARG ETCD_VERSION=v3.5.12

# 创建工作目录
WORKDIR /etcd

# 克隆 etcd 源码并检出指定版本
RUN git clone https://github.com/etcd-io/etcd.git . \
    && git checkout tags/${ETCD_VERSION} -b ${ETCD_VERSION}


RUN apk add bash

ARG TARGETARCH
ENV ETCD_UNSUPPORTED_ARCH=${TARGETARCH}

RUN make build && ./bin/etcd --version

FROM alpine:3.22.2

COPY --from=builder /etcd/bin/etcd /usr/local/bin/
COPY --from=builder /etcd/bin/etcdctl /usr/local/bin/
COPY --from=builder /etcd/bin/etcdutl /usr/local/bin/

WORKDIR /var/etcd/
WORKDIR /var/lib/etcd/

EXPOSE 2379 2380

ARG TARGETARCH
ENV ETCD_UNSUPPORTED_ARCH=${TARGETARCH}

CMD ["/usr/local/bin/etcd"]
