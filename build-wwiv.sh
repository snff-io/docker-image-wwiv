#!/bin/sh

BINARIES='
bbs/bbs
init/init
wwivd/wwivd
network/network
network1/network1
network2/network2
network3/network3
networkb/networkb
networkc/networkc
networkf/networkf
wwivutil/wwivutil
'

set -e

cd $1

(
cd deps/cl342
make
)

cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/wwiv
make

mkdir -p /opt/wwiv
install -m 755 $BINARIES /opt/wwiv
cp -a bbs/admin /opt/wwiv/admin
