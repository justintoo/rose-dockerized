#!/bin/bash -e

source "/home/rose/.bashrc"

env
ls
pwd
 
cd "${ROSE_SOURCE}"
./build || exit 1
 
