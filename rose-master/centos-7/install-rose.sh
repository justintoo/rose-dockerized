#!/bin/bash -ex

: ${PARALLELISM:=$(cat /proc/cpuinfo | grep processor | wc -l)}
: ${ROSE_VERSION:=$(curl "https://raw.githubusercontent.com/rose-compiler/rose-develop/master/ROSE_VERSION")}
: ${ROSE_DESTDIR:=/root}
: ${ROSE_PREFIX:=${ROSE_DESTDIR}/${ROSE_VERSION}}
: ${ROSE_HOME:=${ROSE_PREFIX}}
: ${ROSE_WORKSPACE:=${ROSE_PREFIX}/workspace}
: ${ROSE_SOURCE:=${ROSE_WORKSPACE}/rose}
: ${ROSE_BUILD:=${ROSE_WORKSPACE}/compilation}

mkdir -p "${ROSE_WORKSPACE}"
cd "${ROSE_WORKSPACE}"
 
#-----------------------------------------------------------------
# Load Spack and ROSE Dependencies
#-----------------------------------------------------------------
cat > setup.sh <<-EOF
#!/bin/bash

source /root/opt/setup.sh

export ROSE_VERSION="${ROSE_VERSION}"
export ROSE_PREFIX="${ROSE_PREFIX}"
export ROSE_WORKSPACE="${ROSE_WORKSPACE}"
export ROSE_SOURCE="${ROSE_SOURCE}"
export ROSE_BUILD="${ROSE_BUILD}"
 
export ROSE_VERSION="${ROSE_VERSION}"
export ROSE_HOME="\${ROSE_HOME}"
export PATH="\${ROSE_HOME}/bin:\${PATH}"
export LD_LIBRARY_PATH="\${ROSE_HOME}/lib:\${LD_LIBRARY_PATH}"
EOF

source setup.sh

cp setup.sh "${ROSE_HOME}"
echo "source \"${ROSE_HOME}/setup.sh\"" >> ~/.bashrc

git clone --depth 1 https://github.com/rose-compiler/rose-develop.git "${ROSE_SOURCE}"
cd "${ROSE_SOURCE}"

./build || exit 1

mkdir "${ROSE_BUILD}"
cd "${ROSE_BUILD}"
 
"${ROSE_SOURCE}/configure"        \
    --prefix="${ROSE_HOME}"       \
    --with-boost="${BOOST_HOME}"  \
    --disable-boost-version-check \
    --enable-edg_version=4.12     \
    --enable-languages=c,c++,binaries \
    CXXFLAGS=-std=c++11 || (head config.log && exit 1)
 
make -j${PARALLELISM} install-core || exit 1
make install -C tools/ -j${PARALLELISM} || exit 1

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
[SUCCESS} Note: This command was added to your ~/.bashrc.
-------------------------------------------------------------------------------
EOF

# Cleanup build workspace to reduce bloat
rm -rf "${ROSE_WORKSPACE}"

