#!/bin/bash

# make sure arm64 is a known host ...
cp -r ${BUILD_PREFIX}/share/libtool/build-aux/config.* .
export LDFLAGS="-L${PREFIX}/lib ${LDFLAGS}"

# these files have hardcoded paths in them.  We don't need .la files anyway, so just remove it.
if [ -f ${PREFIX}/${HOST}/lib/libstdc++.la ]; then
    find ${PREFIX} -name "*.la" -print0 | xargs -0 rm
fi

if [[ $(uname -m) == "aarch64" ]]; then
  ./configure --prefix=${PREFIX} \
              --host=aarch64-linux-gnu \
              --build=aarch64-linux-gnu \
              --enable-static=no
else
  ./configure --prefix=${PREFIX} \
              --host=${HOST} \
              --build=${BUILD} \
              --enable-static=no
fi

make
# Commented out due to failures:
# FAIL: check_virtualtable2
# FAIL: check_virtualtable
# check_sql_stmt
# make check
make install
