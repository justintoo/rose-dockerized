#!/bin/bash -ex

: ${ROSE_VERSION:=$1}
: ${ROSE_VERSION:=master}
: ${PARALLELISM:=$(cat /proc/cpuinfo | grep processor | wc -l)}

# Parallel build on mac dies with gcc segfault
PARALLELISM=1

cd "~/rose/${ROSE_VERSION}"
source setup.sh
 
cd "${ROSE_BUILD}"
 
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
