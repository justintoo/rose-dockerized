#!/bin/bash -x

: ${SHARE_DIR:="$(cd "$(dirname "$0") && pwd)"}
: ${ROSE_VERSION:="$(identityTranslator --version | grep "ROSE (" | sed 's/^ROSE (version: \(.*\))/\1/')"}
: ${ROSE_FRONTENDS:="+c+cxx"}
: ${EDG_VERSION:=5.0}
: ${GCC_VERSION:="$(gcc -dumpversion)"}
: ${BOOST_VERSION:=1.54.0}

mkinstaller -v2 \
	-c rose@${ROSE_VERSION}-ubuntu@16.04-gcc@${GCC_VERSION}-boost@${BOOST_VERSION}-edg-@${EDG_VERSION}${ROSE_FRONTENDS} \
	CC=gcc \
	CXX=g++ \
	${BOOST_HOME}/{include,lib} \
	${ROSE_HOME}/{bin,include,lib,share} \
	--postinstall-perl="${SHARE_DIR}/rose-post-install"
