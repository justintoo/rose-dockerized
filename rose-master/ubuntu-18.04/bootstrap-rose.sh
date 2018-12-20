#!/bin/bash -ex

source "/home/rose/.bashrc"

env | grep ROSE
ls
 
cd "${ROSE_SOURCE}"
./build || exit 1
 
