FROM centos:8

RUN dnf install centos-release-stream -y && \
         dnf install -y libguestfs-tools libvirt qemu-kvm-block-rbd && \
         dnf install -y epel-release && \
         dnf install -y ntfsprogs && \
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
