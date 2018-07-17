#!/bin/bash -ex

: ${ROSE_VERSION:=$1}
: ${ROSE_VERSION:=master}
: ${PARALLELISM:=$(cat /proc/cpuinfo | grep processor | wc -l)}

cd "~/rose/${ROSE_VERSION}"
source setup.sh
 
cd "${ROSE_SOURCE}"
./build || exit 1
 
