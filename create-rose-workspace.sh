#!/bin/bash -ex

: ${ROSE_VERSION:=$1}
: ${ROSE_VERSION:=master}

source ~/opt/bison/3.0/setup.sh 
source ~/opt/libtool/2.4/automake/1.14/autoconf/2.69/setup.sh 
source ~/opt/boost/1.66.0/gcc/4.8.5/setup.sh

mkdir -p "~/rose/${ROSE_VERSION}"
cd "~/rose/${ROSE_VERSION}"
 
cat > setup.sh <<-EOF
source "${BISON_HOME}/setup.sh"
source "${LIBTOOL_HOME}/setup.sh"
source "${BOOST_HOME}/setup.sh"
export ROSE_WORKSPACE="$(pwd)"
export ROSE_SOURCE="\${ROSE_WORKSPACE}/rose"
export ROSE_BUILD="\${ROSE_WORKSPACE}/build"
 
export ROSE_VERSION=${ROSE_VERSION}
export ROSE_HOME="\${ROSE_WORKSPACE}/installation"
export PATH="\${ROSE_HOME}/bin:\${PATH}"
export LD_LIBRARY_PATH="\${ROSE_HOME}/lib:\${LD_LIBRARY_PATH}"
EOF
 
source setup.sh

mkdir -p "${ROSE_HOME}"
cp setup.sh "${ROSE_HOME}"
 
git clone https://github.com/rose-compiler/rose-develop.git "${ROSE_SOURCE}"
 
