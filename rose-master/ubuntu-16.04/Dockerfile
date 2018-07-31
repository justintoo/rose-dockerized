FROM ubuntu:16.04
MAINTAINER Justin Too <too1@llnl.gov>

#--------------------------------------------------------------------------
# Install general software development dependencies
#
# 1. Make sure the software packages that we'll install are up-to-date with the
#    Package Management System
# 2. Install general development tools
# 3. Install ROSE development system dependencies
#
# Note: Remove workspace caches in each layer, otherwise it'll still exist on each layer
# even if we remove it in the final layer. https://blog.codeship.com/reduce-docker-image-size/
#--------------------------------------------------------------------------

USER root

#----------------------------------------------------------
# Install system dependencies, then remove unneeded bloat
#----------------------------------------------------------
RUN apt-get update -y && \
        apt-get install -y git wget g++-4.8 python curl make automake libtool flex bison ghostscript graphviz unzip && \
        update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 100 && \
        update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 100 && \
        update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-4.8 100 && \
        apt-get install -y gfortran-4.8 && \
        update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-4.8 100 && \
        ln -s /usr/include/x86_64-linux-gnu/sys /usr/include/sys && \
    apt-get clean && \
        rm -rf /tmp/*

#----------------------------------------------------------
# Install ROSE using spack
#
# Note: Fails on Macbook Pro for some reason; possible solution is to use `spack install -j 1`
#----------------------------------------------------------
RUN mkdir -p ~/opt/ && \
    cd ~/opt/ && \
    git clone --branch SYSADMIN-240-update-to-rose-0.9.9.0 https://github.com/justintoo/spack && \
    ./spack/bin/spack compiler add && \
    ./spack/bin/spack --verbose --insecure install --no-checksum rose %gcc@4.8

