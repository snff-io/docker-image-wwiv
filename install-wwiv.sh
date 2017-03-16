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

mkdir -p $2
install -m 755 $BINARIES $2
cp -a bbs/admin $2/admin
