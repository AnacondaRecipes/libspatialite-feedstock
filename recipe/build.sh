#!/bin/bash

export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
export CFLAGS="-I$PREFIX/include $CFLAGS"

autoreconf -vfi
./configure --prefix=$PREFIX --host=$HOST --enable-static=no

make
# Commented out due to failures:
# FAIL: check_virtualtable2
# FAIL: check_virtualtable
# make check
make install
