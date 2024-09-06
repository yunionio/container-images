FROM registry.cn-beijing.aliyuncs.com/yunionio/telegraf:v20240905.0 as telegraf_builder
FROM registry.cn-beijing.aliyuncs.com/yunionio/supervise:v1.0 as supervise_builder
FROM registry.cn-beijing.aliyuncs.com/yunionio/yunionos:v3.10.12-20240905.0-vm as yunionos
FROM registry.cn-beijing.aliyuncs.com/yunionio/host-deployer-base:qga-v1.0 as qga
FROM registry.cn-beijing.aliyuncs.com/yunionio/host-deployer-base:base-v1.0

ADD usr/bin/chntpw.static /usr/bin/chntpw.static
ADD usr/bin/.chntpw.static.bin /usr/bin/.chntpw.static.bin
ADD usr/bin/bundles/chntpw.static /usr/bin/bundles/chntpw.static
ADD opt/vmware-vddk/bin /opt/vmware-vddk/bin
ADD usr/lib/vmware /usr/lib/vmware
ADD etc/lvm/lvm.conf /etc/lvm/lvm.conf
COPY --from=telegraf_builder /telegraf/telegraf /opt/yunion/bin/
COPY --from=telegraf_builder /telegraf/telegraf.exe /opt/yunion/bin/
COPY --from=supervise_builder /admin/daemontools-0.76/command/supervise /opt/yunion/bin/

RUN mkdir -p /yunionos/x86_64
RUN mkdir -p /yunionos/aarch64
COPY --from=yunionos /yunionos/x86_64/initramfs /yunionos/x86_64/initramfs
COPY --from=yunionos /yunionos/x86_64/kernel /yunionos/x86_64/kernel
COPY --from=yunionos /yunionos/aarch64/kernel /yunionos/aarch64/kernel
COPY --from=yunionos /yunionos/aarch64/initramfs /yunionos/aarch64/initramfs

COPY --from=qga /qemu-ga /qemu-ga
RUN mv /qemu-ga /yunionos/`uname -m`/qemu-ga

RUN ARCH=`uname -m` && \
    if [ "$ARCH" == "x86_64" ]; then \
        curl --insecure -o /yunionos/x86_64/qemu-ga-x86_64.msi https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-qemu-ga/qemu-ga-win-107.0.1-1.el9/qemu-ga-x86_64.msi; \
    fi
