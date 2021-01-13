FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://defconfig \
    file://deploy/ \
    "

do_install_append() {
    install -d ${D}${sysconfdir}
    install -d ${D}${sysconfdir}/swu_files

    install -m 644 ${WORKDIR}/deploy/etc/swu_files/aes_key_iv.txt ${D}${sysconfdir}/swu_files/
    install -m 644 ${WORKDIR}/deploy/etc/swu_files/rsa_public.pem ${D}${sysconfdir}/swu_files/

    if [ -f "${WORKDIR}/deploy/etc/${MACHINE}/hwrevision" ]; then
        install -m 0655 ${WORKDIR}/deploy/etc/${MACHINE}/hwrevision ${D}${sysconfdir}/
    else
        echo "WARNING: There isn't any hw compatibility file for machine '${MACHINE}'." >&2
    fi

    install -d ${D}${sysconfdir}/default
    install -m 644 ${WORKDIR}/deploy/etc/default/swupdate ${D}${sysconfdir}/default/
}
