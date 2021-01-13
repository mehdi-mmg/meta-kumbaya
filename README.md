# meta-kumbaya
Yocto meta layers &amp; recipes for kumbaya project

# Dependency
This meta layer depends on the following layers:

1. Forced to use one of the following meta-layers because of 'core' conflicts:
    - poky --> branch=zeus
    - openembedded-core --> branch=zeus

2. meta-openembedded --> branch=zeus

3. meta-imx --> zeus-5.4.47-2.2.0
    - depends on the following meta-layers:

    1. meta-freescale --> branch=zeus
        - following changes applied:
        ```
        > file EULA ported from master branch (md5 mismatch)
        ```
    2. meta-freescale-distro   --> branch=zeus
    3. meta-freescale-3rdparty --> branch=zeus

4. meta-swupdate --> branch=master or dunfell
    - if `branch=dunfell` the following changes should be applied:
    ```
    diff --git a/conf/layer.conf b/conf/layer.conf
    index 8d3677a..93f412a 100644
    --- a/conf/layer.conf
    +++ b/conf/layer.conf
    @@ -9,6 +9,6 @@ BBFILE_COLLECTIONS += "swupdate"
     BBFILE_PATTERN_swupdate := "^${LAYERDIR}/"
     BBFILE_PRIORITY_swupdate = "6"
     
    -LAYERSERIES_COMPAT_swupdate = "dunfell gatesgarth hardknott"
    +LAYERSERIES_COMPAT_swupdate = "zeus dunfell gatesgarth hardknott"
     
     LAYERDEPENDS_swupdate = "openembedded-layer"
    ```

    - if `branch=master` the following changes should be applied:
    ```
    diff --git a/conf/layer.conf b/conf/layer.conf
    index 8d3677a..93f412a 100644
    --- a/conf/layer.conf
    +++ b/conf/layer.conf
    @@ -9,6 +9,6 @@ BBFILE_COLLECTIONS += "swupdate"
     BBFILE_PATTERN_swupdate := "^${LAYERDIR}/"
     BBFILE_PRIORITY_swupdate = "6"
     
    -LAYERSERIES_COMPAT_swupdate = "dunfell gatesgarth hardknott"
    +LAYERSERIES_COMPAT_swupdate = "zeus dunfell gatesgarth hardknott"
     
     LAYERDEPENDS_swupdate = "openembedded-layer"

    diff --git a/recipes-devtools/mtd/mtd-utils_%.bbappend b/recipes-devtools/mtd/mtd-utils_%.bbappend
    index 471c8ad..e88dc9f 100644
    --- a/recipes-devtools/mtd/mtd-utils_%.bbappend
    +++ b/recipes-devtools/mtd/mtd-utils_%.bbappend
    @@ -9,6 +9,7 @@ do_install_append () {
     	install -m 0644 ${S}/include/libmtd.h ${D}${includedir}
     	install -m 0644 ${S}/include/libscan.h ${D}${includedir}
     	install -m 0644 ${S}/include/libubigen.h ${D}${includedir}
    +	install -m 0644 ${S}/include/mtd/ubi-media.h ${D}${includedir}/mtd/
     	ln -s ../libubi.h ${D}${includedir}/mtd/libubi.h
     	ln -s ../libmtd.h ${D}${includedir}/mtd/libmtd.h
     	ln -s ../libscan.h ${D}${includedir}/mtd/libscan.h

    diff --git a/recipes-support/swupdate/swupdate.inc b/recipes-support/swupdate/swupdate.inc
    index 99041db..47e8d9b 100644
    --- a/recipes-support/swupdate/swupdate.inc
    +++ b/recipes-support/swupdate/swupdate.inc
    @@ -87,6 +87,10 @@ EXTRA_OEMAKE += " O=${B} HOSTCC="${BUILD_CC}" HOSTCXX="${BUILD_CXX}" LD="${CC}"
     
     DEPENDS += "kern-tools-native"
     
    +# returns all the elements from the src uri that are .cfg files
    +def find_cfgs(d):
    +    return [s for s in src_patches(d, True) if s.endswith('.cfg')]
    +
     python () {
         import re
     
    ```

5. meta-qt5 --> branch=zeus
