#!/bin/bash

# yosys dependencies
sudo apt-get install build-essential clang lld bison flex \
     libreadline-dev gawk tcl-dev libffi-dev git \
     graphviz xdot pkg-config python3 libboost-system-dev \
     libboost-python-dev libboost-filesystem-dev zlib1g-dev

# ghdl dependencies
sudo apt install gnat


# nextpnr dependencies
sudo apt-get install libboost-thread-dev libboost-program-options-dev \
     libboost-iostreams-dev libboost-dev libeigen3-dev

# icestorm dependencies
sudo apt-get install build-essential clang bison flex libreadline-dev \
     gawk tcl-dev libffi-dev mercurial \
     libftdi-dev qt5-default python3-dev \
     libboost-all-dev cmake

## this is until they upstream my patch
# gtkwave dependencies
sudo apt install build-essential meson gperf flex desktop-file-utils libgtk-3-dev \
     libbz2-dev libjudy-dev libgirepository1.0-dev

# udev rules for uploading binaries
echo "ATTRS{idVendor}==\"0403\", ATTRS{idProduct}==\"6010\", MODE=\"0660\", GROUP=\"plugdev\", TAG+=\"uaccess\"" | sudo tee /etc/udev/rules.d/53-lattice-ftdi.rules > /dev/null

sudo udevadm control --reload-rules && sudo udevadm trigger
