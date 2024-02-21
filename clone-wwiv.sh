#!/bin/sh

set -xe

srcdir=$1
branch=$2
refspec=$3

mkdir -p $srcdir
cd $srcdir
git clone -b $branch https://github.com/snff-io/wwiv/ wwiv

cd wwiv

git submodule update --init --recursive

git submodule update --recursive --remote

git checkout $refspec


