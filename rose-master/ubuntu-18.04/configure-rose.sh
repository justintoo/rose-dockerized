#!/bin/bash -e

source "/home/rose/.bashrc"
 
mkdir "${ROSE_BUILD}"
cd "${ROSE_BUILD}"
 
"${ROSE_SOURCE}/configure"        \
    --prefix="${ROSE_HOME}"       \
    --with-boost="${BOOST_HOME}"  \
    --disable-boost-version-check \
    --enable-edg_version=4.12     \
    --enable-languages=c,c++,binaries \
    CXXFLAGS=-std=c++11 || (cat config.log && exit 1)
 
make -j${PARALLELISM} install-core || exit 1

cat >> ~/.bash_profile <<-EOF
source "${ROSE_HOME}/setup.sh" || false
EOF
 
cat <<-EOF
-------------------------------------------------------------------------------
[SUCCESS} ROSE was successfully installed here:
[SUCCESS} 
[SUCCESS}     ${ROSE_HOME}
[SUCCESS} 
[SUCCESS} Use this command to add ROSE to your shell environment:
[SUCCESS} 
[SUCCESS}     $ source "${ROSE_HOME}/setup.sh"
[SUCCESS} 
[SUCCESS} Note: This command was added to your ~/.bash_profile.
-------------------------------------------------------------------------------
EOF
