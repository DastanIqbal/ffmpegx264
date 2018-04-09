#!/bin/bash

. settings.sh

BASEDIR=$2

case $1 in
  armeabi-v7a)
    NDK_ARCH='arm'
    NDK_TOOLCHAIN_ABI='arm-linux-androideabi'
    NDK_CROSS_PREFIX="${NDK_TOOLCHAIN_ABI}"
  ;;
  arm64-v8a)
    NDK_ARCH='arm64'
    NDK_TOOLCHAIN_ABI='aarch64-linux-android'
    NDK_CROSS_PREFIX="${NDK_TOOLCHAIN_ABI}"
  ;;
  x86)
    NDK_ARCH='x86'
    NDK_TOOLCHAIN_ABI='x86'
    NDK_CROSS_PREFIX="i686-linux-android"
    CFLAGS="$CFLAGS -march=i686"
  ;;
  x86_64)
    NDK_ARCH='x86_64'
    NDK_TOOLCHAIN_ABI='x86_64'
    NDK_CROSS_PREFIX="x86_64-linux-android"
    CFLAGS="$CFLAGS -march=i686"
  ;;
esac

TOOLCHAIN_PREFIX=${BASEDIR}/toolchain-android
if [ ! -d "$TOOLCHAIN_PREFIX" ]; then
  ${ANDROID_NDK_ROOT_PATH}/build/tools/make_standalone_toolchain.py --arch ${NDK_ARCH} --api ${ANDROID_API_VERSION} --force --install-dir=${TOOLCHAIN_PREFIX}
fi

CROSS_PREFIX=${TOOLCHAIN_PREFIX}/bin/${NDK_CROSS_PREFIX}-
NDK_SYSROOT=${TOOLCHAIN_PREFIX}/sysroot

export PKG_CONFIG_LIBDIR="${TOOLCHAIN_PREFIX}/lib/pkgconfig"

if [ $3 == 1 ]; then
  export CC="${CROSS_PREFIX}clang"
  export LD="${CROSS_PREFIX}ld"
  export RANLIB="${CROSS_PREFIX}ranlib"
  export STRIP="${CROSS_PREFIX}strip"
  export READELF="${CROSS_PREFIX}readelf"
  export OBJDUMP="${CROSS_PREFIX}objdump"
  export ADDR2LINE="${CROSS_PREFIX}addr2line"
  export AR="${CROSS_PREFIX}ar"
  export AS="${CROSS_PREFIX}as"
  export CXX="${CROSS_PREFIX}clang++"
  export OBJCOPY="${CROSS_PREFIX}objcopy"
  export ELFEDIT="${CROSS_PREFIX}elfedit"
  export CPP="${CROSS_PREFIX}cpp"
  export DWP="${CROSS_PREFIX}dwp"
  export GCONV="${CROSS_PREFIX}gconv"
  export GDP="${CROSS_PREFIX}gdb"
  export GPROF="${CROSS_PREFIX}gprof"
  export NM="${CROSS_PREFIX}nm"
  export SIZE="${CROSS_PREFIX}size"
  export STRINGS="${CROSS_PREFIX}strings"
fi
