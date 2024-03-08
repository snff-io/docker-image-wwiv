#!/bin/sh

set -xe

cd "$1"

# Build dependencies if necessary (e.g., assuming cl345 needs to be built)
cd deps/cl345
make -j8

cd "$1"

if ["$2" == "build_cereal"]; then

    rm -rf cereal

    git clone https://github.com/USCiLab/cereal

    cd cereal
    cmake .
    make -j8

    # Navigate to the source directory
    cd "$1"

fi
