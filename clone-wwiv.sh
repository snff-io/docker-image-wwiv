#!/bin/sh

set -xe

srcdir=$1
branch=$2
refspec=$3

mkdir -p $srcdir
cd $srcdir
git clone -b $branch https://github.com/wwivbbs/wwiv/ wwiv
cd wwiv
git checkout $refspec
