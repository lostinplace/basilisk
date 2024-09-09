#!/bin/bash

set -e

# Install SWIG 4.2.0 or later
cd /tmp
wget https://github.com/swig/swig/archive/refs/tags/v4.2.0.tar.gz
tar -xzf v4.2.0.tar.gz
cd swig-4.2.0
./autogen.sh
./configure --with-pcre2
make
make install
cd /basilisk
rm -rf /tmp/swig-4.2.0 /tmp/v4.2.0.tar.gz

# Upgrade pip and install initial dependencies
pip install --upgrade pip setuptools wheel
pip install 'conan<2.0' cmake

# Install specific versions and additional packages
pip install conan==1.61.0 pytest datashader holoviews pytest-xdist parse matplotlib numpy pandas

# Install Basilisk Python dependencies
pip install -r requirements.txt

# Build Basilisk
yes s | python conanfile.py

# Build wheel
python setup.py bdist_wheel

echo "Basilisk setup and wheel building completed successfully."
