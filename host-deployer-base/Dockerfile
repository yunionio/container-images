FROM registry.cn-beijing.aliyuncs.com/yunionio/alpine-build:3.16.0-go-1.18.2-0 as telegraf_builder
RUN git clone --branch=yn-release-1.19  https://github.com/yunionio/telegraf.git && \
    cd telegraf && LDFLAGS='-extldflags "-static" -s' CGO_ENABLED=0 make && \
    ARCH=`uname -m` && \
    if [ "$ARCH" == "x86_64" ]; then \
        GOOS=windows LDFLAGS='-extldflags "-static" -s' CGO_ENABLED=0 make; \
    else \
        touch /telegraf/telegraf.exe; \
    fi

FROM registry.cn-beijing.aliyuncs.com/yunionio/centos-build:1.1-4 as supervise_builder

ADD ./supervise/daemontools-0.76.tar.gz /
RUN yum install -y glibc-static
RUN cd /admin/daemontools-0.76/ && sed -i '1{s/$/ -include errno.h/}' src/conf-cc && sed -i '1{s/$/ -static/}' src/conf-ld && ./package/compile

FROM centos:8

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN dnf install centos-release-stream -y && \
         dnf install -y libguestfs-tools libvirt qemu-kvm-block-rbd && \
         dnf install -y epel-release && \
         dnf install -y ntfsprogs && \
         dnf install -y ntfs-3g && \
         dnf install -y lvm2 && \
         rpm -e linux-firmware && \
         dnf clean all && \
         rm -rf /var/cache/dnf

RUN echo 'user = "root"' > /etc/libvirt/qemu.conf && echo 'group = "root"' >> /etc/libvirt/qemu.conf

ADD usr/bin/chntpw.static /usr/bin/chntpw.static
ADD usr/bin/.chntpw.static.bin /usr/bin/.chntpw.static.bin
ADD usr/bin/bundles/chntpw.static /usr/bin/bundles/chntpw.static
ADD opt/vmware-vddk/bin /opt/vmware-vddk/bin
ADD usr/lib/vmware /usr/lib/vmware
ADD etc/lvm/lvm.conf /etc/lvm/lvm.conf
COPY --from=telegraf_builder /telegraf/telegraf /opt/yunion/bin/
COPY --from=telegraf_builder /telegraf/telegraf.exe /opt/yunion/bin/
COPY --from=supervise_builder /admin/daemontools-0.76/command/supervise /opt/yunion/bin/
