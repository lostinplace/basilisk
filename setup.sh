#!/bin/bash

set -e

# Upgrade pip and install initial dependencies
pip install --upgrade pip
pip install wheel 'conan<2.0' cmake

# Install specific versions and additional packages
pip install wheel conan==1.61.0 pytest datashader holoviews pytest-xdist parse matplotlib numpy pandas setuptools dask dask[dataframe]

# Install Basilisk Python dependencies
pip install -r requirements.txt

# Build Basilisk
yes s | python conanfile.py

echo "Basilisk setup completed successfully."
