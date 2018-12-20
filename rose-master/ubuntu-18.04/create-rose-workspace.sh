#!/bin/bash -ex

: ${ROSE_VERSION:=$1}
: ${ROSE_DESTDIR:=/home/rose/rose}
: ${ROSE_PREFIX:=${ROSE_DESTDIR}/${ROSE_VERSION}}
: ${ROSE_HOME:=${ROSE_PREFIX}}
: ${ROSE_WORKSPACE:=${ROSE_PREFIX}/workspace}
: ${ROSE_SOURCE:=${ROSE_WORKSPACE}/rose}
: ${ROSE_BUILD:=${ROSE_WORKSPACE}/compilation}

spack load     \
    boost      \
    libtool

mkdir -p "${ROSE_WORKSPACE}"
cd "${ROSE_WORKSPACE}"
 
cat > setup.sh <<-EOF
export ROSE_VERSION="${ROSE_VERSION}"
export ROSE_PREFIX="${ROSE_PREFIX}"
export ROSE_WORKSPACE="${ROSE_WORKSPACE}"
export ROSE_SOURCE="${ROSE_SOURCE}"
export ROSE_BUILD="${ROSE_BUILD}"
 
export ROSE_VERSION="${ROSE_VERSION}"
export ROSE_HOME="\${ROSE_HOME}"
export PATH="\${ROSE_HOME}/bin:\${PATH}"
export LD_LIBRARY_PATH="\${ROSE_HOME}/lib:\${LD_LIBRARY_PATH}"

. /usr/local/spack/share/spack/setup-env.sh

export BOOST_HOME="\$(spack location -i boost)"
export LD_LIBRARY_PATH="\${BOOST_HOME}/lib:\${LD_LIBRARY_PATH}"
EOF
 
cp setup.sh "${ROSE_HOME}"
echo "export \"${ROSE_HOME}/setup.sh\"" >> /home/rose/.bashrc

git clone https://github.com/rose-compiler/rose-develop.git "${ROSE_SOURCE}"
 
