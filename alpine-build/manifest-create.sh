#!/bin/bash

set -e

archs="amd64 arm64"

SRC_REG="registry.cn-beijing.aliyuncs.com/yunion"
TARGET_REG="registry.cn-beijing.aliyuncs.com/zexi"
VERSION="3.21.0"

TARGET_IMGS=""

for arch in $archs; do
    t_img=$TARGET_REG/alpine:$VERSION-$arch
    docker pull --platform linux/$arch $SRC_REG/alpine:$VERSION
    docker tag $SRC_REG/alpine:$VERSION $t_img
    docker push $t_img
    TARGET_IMGS="$TARGET_IMGS $t_img"
done

# docker pull $SRC_REG/alpine:3.19-loong64
# docker tag $SRC_REG/alpine:3.19-loong64 $TARGET_REG/alpine:3.19-loong64
#
# docker buildx imagetools create -t $TARGET_REG/alpine:$VERSION-archs \
#     $TARGET_REG/alpine:$VERSION-amd64 \
#     $TARGET_REG/alpine:$VERSION-arm64 \
#     $TARGET_REG/alpine:3.19-loong64 \
#
#
# # docker manifest create $TARGET_REG/alpine:$VERSION-archs \
# #     $TARGET_REG/alpine:$VERSION-amd64 \
# #     $TARGET_REG/alpine:$VERSION-arm64 \
# #     $TARGET_REG/alpine:$VERSION-loong64 \
#

docker buildx imagetools create -t $TARGET_REG/alpine:$VERSION \
    $TARGET_IMGS $TARGET_REG/alpine:3.21.0-loong64
