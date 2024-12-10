#!/bin/bash

set -e

# SEE: https://github.com/alpinelinux/docker-alpine/tree/v3.21/loongarch64

TARGET_REG="registry.cn-beijing.aliyuncs.com/zexi"

wget https://github.com/alpinelinux/docker-alpine/raw/refs/heads/v3.21/loongarch64/alpine-minirootfs-3.21.0-loongarch64.tar.gz

IMG=$TARGET_REG/alpine:3.21.0-loong64

docker buildx build --push --platform linux/loong64 -t $IMG -f ./Dockerfile .
