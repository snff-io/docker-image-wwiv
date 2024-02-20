#!/bin/sh

BINARIES='
bbs/bbs
wwivd/wwivd
network/network
network1/network1
network2/network2
network3/network3
networkb/networkb
networkc/networkc
networkf/networkf
wwivutil/wwivutil
wwivconfig/wwivconfig
wwivfsed/wwivfsed
release/*
'

set -xe

cd $1

mkdir -p $2
install -m 755 $BINARIES $2
