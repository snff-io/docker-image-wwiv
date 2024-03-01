#!/bin/sh

set -xe

cd $1

(
cd deps/cl345
make
)

rm -rf build
mkdir build
cd build

 cmake -S ../ -B ./ \
 	-DCMAKE_INSTALL_PREFIX:PATH=/opt/wwiv \
 	-DCMAKE_BUILD_TYPE:STRING=Debug 
# 	-DCMAKE_MAKE_PROGRAM=/usr/bin/make 
#cmake -S ../ -B ./ -DCMAKE_INSTALL_PREFIX:PATH=/opt/wwiv -DCMAKE_BUILD_TYPE:STRING=Debug 

make

cd ..