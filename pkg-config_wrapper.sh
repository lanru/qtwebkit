#!/bin/sh
PKG_CONFIG_SYSROOT_DIR=/opt/EmbedSky/linaro-5.3.1/usr/arm-buildroot-linux-gnueabihf/sysroot
export PKG_CONFIG_SYSROOT_DIR
PKG_CONFIG_LIBDIR=/opt/EmbedSky/linaro-5.3.1/usr/arm-buildroot-linux-gnueabihf/sysroot/usr/lib/pkgconfig:/opt/EmbedSky/linaro-5.3.1/usr/arm-buildroot-linux-gnueabihf/sysroot/usr/lib/arm-linux-gnueabihf/pkgconfig:
export PKG_CONFIG_LIBDIR
exec pkg-config "$@"
