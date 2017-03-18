#!/bin/sh

set -xe

mkdir -p $1
cd $1
git clone https://github.com/wwivbbs/wwiv/ wwiv
