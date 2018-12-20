#!/bin/bash -ex

source "/home/rose/.bashrc"
 
cd "${ROSE_SOURCE}"
./build || exit 1
 
