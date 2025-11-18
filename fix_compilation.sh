#!/usr/bin/bash
# fix_cross_compilation.sh
# 用于交叉编译环境（ARM等），确保正确链接到自定义 sysroot 下的 ICU 57 及相关库

cd /data/arm-bio/qtwebkit-A40

# 1. 设置交叉编译环境变量（请根据你的实际 sysroot 路径调整）
export SYSROOT="/opt/EmbedSky/linaro-5.3.1/usr/arm-buildroot-linux-gnueabihf/sysroot"
export LD_LIBRARY_PATH="$SYSROOT/usr/lib:$SYSROOT/usr/lib/arm-linux-gnueabihf:$LD_LIBRARY_PATH"
export LDFLAGS="-L$SYSROOT/usr/lib -L$SYSROOT/usr/lib/arm-linux-gnueabihf -licuuc -licui18n -licudata -lxcb -llzma -ldl"
export PKG_CONFIG_PATH="$SYSROOT/usr/lib/pkgconfig:$SYSROOT/usr/lib/arm-linux-gnueabihf/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_LIBDIR="$PKG_CONFIG_PATH"
export PKG_CONFIG_SYSROOT_DIR="$SYSROOT"

# 2. 指定交叉编译工具链（如有需要）
export CC=arm-linux-gnueabihf-gcc
export CXX=arm-linux-gnueabihf-g++

# 注意qmake需要已经编译ok
# 3. 重新配置 qmake（注意替换 Qt 路径与 Qt 版本为交叉编译用的）
/opt/EmbedSky/linaro-5.3.1/usr/Qt-5.9.0/bin/qmake -r CONFIG+=release CONFIG+=no-ssl QMAKE_SYSROOT=/opt/EmbedSky/linaro-5.3.1/usr/arm-buildroot-linux-gnueabihf/sysroot \
    "DEFINES+=ENABLE_WEBGL=0" \
    "DEFINES+=ENABLE_3D_RENDERING=0" \
    "DEFINES+=ENABLE_OPENGL=0" \
    "DEFINES+=WTF_USE_3D_GRAPHICS=0" \
    "DEFINES+=WTF_USE_GRAPHICS_SURFACE=0" \
    "DEFINES+=WTF_USE_GLX=0" \
    "QMAKE_LFLAGS+=-Wl,--allow-multiple-definition -L$SYSROOT/usr/lib -L$SYSROOT/usr/lib/arm-linux-gnueabihf -licuuc -licui18n -licudata -lxcb -llzma -ldl -Wl,--no-as-needed" \
    "LIBS+=-L$SYSROOT/usr/lib -L$SYSROOT/usr/lib/arm-linux-gnueabihf -licuuc -licui18n -licudata -lxcb -llzma -ldl"

/opt/EmbedSky/linaro-5.3.1/usr/Qt-5.9.0/bin/qmake \
    WEBKIT_CONFIG+=embedded \
    CONFIG+=release \
    CONFIG+=no-ssl \
    QMAKE_SYSROOT=/opt/EmbedSky/linaro-5.3.1/usr/arm-buildroot-linux-gnueabihf/sysroot
