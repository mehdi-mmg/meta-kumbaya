include recipes-core/images/core-image-base.bb
include recipes-core/images/kumbaya-image-timezone.inc

IMAGE_INSTALL += " \
    opkg \
    spawn-fcgi \
    nginx \
    init-ifupdown \
    zeroconf \
    watchdog \
    openssh \
    rsync \
    localedef \
    ntp \
    procps \
    swupdate \
    libubootenv \
    u-boot-fw-utils \
    ncurses-terminfo \
    e2fsprogs-resize2fs \
    e2fsprogs-tune2fs \
    e2fsprogs-e2fsck \
    e2fsprogs-mke2fs \
    busybox-udhcpc \
    avahi-autoipd \
    ethtool \
    canutils \
    usbutils \
    i2c-tools \
    "

inherit extrausers
EXTRA_USERS_PARAMS = "usermod -P root root;"

#inherit image-rootfs-preprocess
