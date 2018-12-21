#!/bin/bash -e

source "/home/rose/.bashrc"

tail "/home/rose/.bashrc"

echo ${ROSE_PREFIX}

cd "${ROSE_SOURCE}"
pwd
ls -l
./build || exit 1
 
