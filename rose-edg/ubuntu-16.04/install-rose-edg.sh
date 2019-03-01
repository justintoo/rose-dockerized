#!/bin/bash -ex
#
# Generate EDG binary tarball and save to /root/Downloads/ directory.
#

: ${WORKSPACE:="$(pwd)"}
: ${EDG_SOURCE:="/root/EDG"}
: ${EDG_DESTDIR:="/root/Downloads"}
: ${PARALLELISM:=$(cat /proc/cpuinfo | grep processor | wc -l)}
: ${ROSE_VERSION:=$(curl "https://raw.githubusercontent.com/rose-compiler/rose-develop/master/ROSE_VERSION")}
: ${ROSE_DESTDIR:=$HOME/opt/rose}
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

export ROSE_VERSION="${ROSE_VERSION}"
export ROSE_PREFIX="${ROSE_PREFIX}"
export ROSE_WORKSPACE="${ROSE_WORKSPACE}"
export ROSE_SOURCE="${ROSE_SOURCE}"
export ROSE_BUILD="${ROSE_BUILD}"

export ROSE_EDG_PREFIX="${ROSE_BUILD}/src/frontend/CxxFrontend"
 
export ROSE_VERSION="${ROSE_VERSION}"
export ROSE_HOME="\${ROSE_PREFIX}"
export PATH="\${ROSE_HOME}/bin:\${PATH}"
export LD_LIBRARY_PATH="\${ROSE_HOME}/lib:\${LD_LIBRARY_PATH}"

export BOOST_HOME="/usr"
export LD_LIBRARY_PATH="\${BOOST_HOME}/lib/x86_64-linux-gnu:\${LD_LIBRARY_PATH}"
EOF

source setup.sh

git clone --depth 1 https://github.com/rose-compiler/rose-develop.git "${ROSE_SOURCE}"
cd "${ROSE_SOURCE}"

cp -R "${EDG_SOURCE}" src/frontend/CxxFrontend/

# IMPORTANT: Remove all EDG source code
rm -rf "${EDG_SOURCE}"

git submodule update

./build || exit 1

mkdir "${ROSE_BUILD}"
cd "${ROSE_BUILD}"
 
"${ROSE_SOURCE}/configure"        \
    --prefix="${ROSE_HOME}"       \
    --with-boost="${BOOST_HOME}" \
    --with-boost-libdir=/usr/lib/x86_64-linux-gnu \
    --disable-boost-version-check \
    --enable-edg_version=5.0     \
    --enable-languages=c,c++ || (cat config.log && exit 1)
 
make -j${PARALLELISM} binary_edg_tarball || exit 1

mkdir -p "${EDG_DESTDIR}"
EDG_BINARY_FILE="$(find "${ROSE_BUILD}" -iname "*roseBinaryEDG-*")"
cp "${EDG_BINARY_FILE}" "${EDG_DESTDIR}"
 
cat <<-EOF
-------------------------------------------------------------------------------
[SUCCESS] ROSE EDG was successfully installed here:
[SUCCESS] 
[SUCCESS]     ${EDG_DESTDIR}
-------------------------------------------------------------------------------
EOF

: $HOME/opt/bin/aws s3 cp "${EDG_BINARY_FILE}" s3://edg-binaries.rosecompiler.org || true

# IMPORTANT: Cleanup build workspace to reduce bloat and EDG source code
rm -rf "${ROSE_WORKSPACE}"

