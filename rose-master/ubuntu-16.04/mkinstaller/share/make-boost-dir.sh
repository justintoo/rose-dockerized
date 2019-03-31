#!/bin/bash -e

BOOST_HOME="/root/opt/boost"

mkdir -p "${BOOST_HOME}/lib" "${BOOST_HOME}/include"
ln --symbolic --force /usr/include/boost "${BOOST_HOME}/include"
ln --symbolic --force /usr/lib/x86_64-linux-gnu/libboost_* "${BOOST_HOME}/lib"

echo > "${BOOST_HOME}/setup.sh" <<-EOF
export BOOST_HOME="$BOOST_HOME"
EOF

