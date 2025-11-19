FROM registry.cn-beijing.aliyuncs.com/yunionio/alpine-build:3.22.2-go-1.25.3-0 AS builder

# 安装依赖工具
RUN apk update && apk add --no-cache \
    git \
    make \
    gcc \
    musl-dev \
    && rm -rf /var/cache/apk/*

# 定义 VictoriaMetrics 版本（使用最新稳定版，可从 https://github.com/VictoriaMetrics/VictoriaMetrics/releases 获取）
ARG VM_VERSION=v1.129.1

# 克隆源码并检出版本
WORKDIR /victoriametrics
RUN git clone https://github.com/VictoriaMetrics/VictoriaMetrics.git . \
    && git checkout tags/${VM_VERSION} -b ${VM_VERSION}

RUN sed -i 's/CGO_ENABLED=1 go build/CGO_ENABLED=0 go build/g' Makefile

RUN make victoria-metrics && ./bin/victoria-metrics --version  # 验证编译结果

# 运行阶段：基于多架构 Alpine 镜像
FROM alpine:3.22.2

# 安装必要的运行时依赖
RUN apk update && apk add --no-cache \
    ca-certificates \
    tzdata \
    && rm -rf /var/cache/apk/*

# 从构建阶段复制二进制文件
COPY --from=builder /victoriametrics/bin/victoria-metrics /victoria-metrics-prod

ENTRYPOINT ["/victoria-metrics-prod"]
# 暴露 HTTP 端口（默认 8428）
EXPOSE 8428