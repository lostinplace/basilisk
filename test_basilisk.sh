#!/bin/bash

set -e

# Activate virtual environment
source /basilisk/venv/bin/activate

# Build basilisk
python conanfile.py

# Python Simulation Tests
cd /basilisk/src/simulation
pytest -n auto -m "not ciSkip" || [ $? -eq 5 ]

# Python Architecture Tests
cd /basilisk/src/architecture
pytest -n auto -m "not ciSkip" || [ $? -eq 5 ]

# Python FswAlgorithms Tests
cd /basilisk/src/fswAlgorithms
pytest -n auto -m "not ciSkip" || [ $? -eq 5 ]

# Python Scenario Tests
cd /basilisk/src/tests
pytest -n auto -m "not ciSkip" || [ $? -eq 5 ]

# C/C++ Tests
cd /basilisk/dist3
ctest || [ $? -eq 5 ]
