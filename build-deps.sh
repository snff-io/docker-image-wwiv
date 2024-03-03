#!/bin/sh

set -xe

# Navigate to the source directory
wwiv_source_root=$(find "$(pwd)" -name "WWIV_SOURCE_ROOT" 2>/dev/null | head -n 1) 
wwiv_source_root="$(dirname "$(readlink -f "$wwiv_source_root")")"
cd "$wwiv_source_root"

# Build dependencies if necessary (e.g., assuming cl345 needs to be built)
cd deps/cl345
make -j8

# Navigate to the source directory
cd "$wwiv_source_root"
