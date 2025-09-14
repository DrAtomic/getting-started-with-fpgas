#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TOOLS_DIR="$ROOT_DIR/tools"
JOBS=6

mkdir -p "$TOOLS_DIR"/sources

pushd "$TOOLS_DIR"/sources

if [ ! -d "yosys" ]; then
    git clone --branch=v0.57 --depth 1 https://github.com/YosysHQ/yosys.git
fi
pushd yosys
git submodule update --init
make -j $JOBS
make PREFIX="$TOOLS_DIR" install
popd

if [ ! -d "ghdl" ]; then
    git clone --branch=v5.1.1 --depth 1 https://github.com/ghdl/ghdl.git
fi
pushd ghdl
./configure --prefix="$TOOLS_DIR"
make -j $JOBS
make install
popd

## my fork so I can use the tag
if [ ! -d "ghdl-yosys-plugin" ]; then
    git clone --branch=v0.0.1 --depth 1 https://github.com/DrAtomic/ghdl-yosys-plugin.git
fi
pushd ghdl-yosys-plugin
make CFLAGS="-I/$TOOLS_DIR/share/yosys/include" YOSYS_CONFIG="$TOOLS_DIR"/bin/yosys-config GHDL="$TOOLS_DIR"/bin/ghdl
mkdir -p "$TOOLS_DIR"/share/yosys/plugins
cp ghdl.so "$TOOLS_DIR"/share/yosys/plugins
popd

## my fork so I can use the tag
if [ ! -d "icestorm" ]; then
    git clone --branch=v0.0.1 --depth 1 https://github.com/DrAtomic/icestorm
fi
pushd icestorm
make
make PREFIX="$TOOLS_DIR" install
popd

if [ ! -d "nextpnr" ]; then
    git clone --branch=nextpnr-0.9 --depth 1 https://github.com/YosysHQ/nextpnr.git
fi
pushd nextpnr
git submodule update --init --recursive
mkdir -p build && cd build
cmake .. -DARCH=ice40 -DICESTORM_INSTALL_PREFIX="$TOOLS_DIR" -DCMAKE_INSTALL_PREFIX="$TOOLS_DIR"
make -j $JOBS
make install
popd

# my own fork of gtkwave for automatic reloading
if [ ! -d "gtkwave" ]; then
    git clone --branch=v0.0.1 --depth 1 https://github.com/DrAtomic/gtkwave.git
fi
pushd gtkwave
meson setup build --prefix="$TOOLS_DIR"
cd build
meson compile -j $JOBS
meson install
popd

popd

echo ""
echo "All Done now run"
echo "source yosys_sdk"
