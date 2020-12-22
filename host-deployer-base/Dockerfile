FROM fedora:33

RUN dnf install -y libguestfs-tools libvirt qemu-block-rbd && \
         rpm -e linux-firmware linux-firmware-whence geolite2-city geolite2-country && \
         rm -rf /var/cache/dnf

RUN echo 'user = "root"' > /etc/libvirt/qemu.conf && echo 'group = "root"' >> /etc/libvirt/qemu.conf

ADD usr/bin/chntpw.static /usr/bin/chntpw.static
ADD usr/bin/.chntpw.static.bin /usr/bin/.chntpw.static.bin
ADD usr/bin/bundles/chntpw.static /usr/bin/bundles/chntpw.static
ADD opt/vmware-vddk/bin /opt/vmware-vddk/bin
ADD usr/lib/vmware /usr/lib/vmware

