#!/usr/env/bin bash

set -ex
echo $target_platform

if [[ "$target_platform" == "osx"* ]]; then
  TARGET_PLATFORM_CONFIGURE_FLAGS="--with-osx_cocoa"
  export wxUSE_MACOSX_VERSION_MIN=10.9
else
  TARGET_PLATFORM_CONFIGURE_FLAGS="--with-gtk=\"3\""
fi

./configure \
  --prefix=${PREFIX} \
  --with-opengl \
  ${TARGET_PLATFORM_CONFIGURE_FLAGS} || cat config.log

[[ "$target_platform" == "win-64" ]] && patch_libtool

make -j ${CPU_COUNT}
make install
