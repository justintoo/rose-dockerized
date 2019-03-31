#!/bin/bash
#
# Ubuntu 16.04

mkinstaller -v2 -c rose@0.9.10.183-ubuntu@16.04-gcc@5.4.0-boost@1.58.0-edg-@5.0+c+cxx CC=gcc CXX=g++ ${BOOST_HOME}/include/boost ${BOOST_HOME}/lib/x86_64-linux-gnu ${ROSE_HOME}/{bin,include,lib,share} --postinstall-perl=/root/mkinstaller/share/rose-post-install
