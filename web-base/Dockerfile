FROM registry.cn-beijing.aliyuncs.com/yunionio/alpine-build:3.22.2-go-1.24.9-0 AS baremetal
RUN wget -O /tmp/baremetal-pxerom.rpm https://iso.yunion.cn/vm-images/baremetal-pxerom-1.1.0-21060506.x86_64.rpm
RUN apk add rpm2cpio
RUN mkdir rom && cd rom && rpm2cpio /tmp/baremetal-pxerom.rpm | cpio -idmv && cp -a ./opt/* /opt

FROM nginx:1.29.3
RUN mkdir -p /opt/cloud/yunion/baremetal/baremetal-prepare
COPY --from=baremetal /opt/cloud/yunion/baremetal/baremetal-prepare/baremetal_prepare.tar.gz /opt/cloud/yunion/baremetal/baremetal-prepare
