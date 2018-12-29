FROM ubuntu:16.04
MAINTAINER Justin Too <too1@llnl.gov>

USER root
SHELL ["/bin/bash", "-c"]

# Installing tzdata hangs on interactive promot
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND=noninteractive

ENV DEPS_DESTDIR          /root/opt

ENV ROSE_VERSION     master
ENV ROSE_REPO        release
ENV AUTOCONF_VERSION 2.69
ENV AUTOMAKE_VERSION 1.14
ENV LIBTOOL_VERSION  2.4
ENV GMP_VERSION      5.1.2
ENV MPFR_VERSION     3.1.2
ENV MPC_VERSION      1.0
ENV GCC_VERSION      4.8.1
ENV BOOST_VERSION    1.54.0

#--------------------------------------------------------------------------
# Install general software development dependencies
#
# 1. Make sure the software packages that we'll install are up-to-date with the
#    Package Management System; automatically runs `apt-get update`
# 2. Install general development tools
# 3. Install ROSE development system dependencies
#--------------------------------------------------------------------------
RUN apt-get update -y && \
        apt-get install -y \
            vim emacs git wget g++-4.8 python curl make automake \
            libtool flex bison ghostscript graphviz unzip tcl tcl-dev environment-modules  && \
        update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 100 && \
        update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 100 && \
        update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-4.8 100 && \
        apt-get install -y gfortran-4.8 && \
        update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-4.8 100 && \
        ln -s /usr/include/x86_64-linux-gnu/sys /usr/include/sys && \
    apt-get clean && \
        rm -rf /tmp/*

#--------------------------------------------------------------------------
# 4. Install custom ROSE development dependencies
#--------------------------------------------------------------------------
RUN mkdir -p ${DEPS_DESTDIR}
WORKDIR ${DEPS_DESTDIR}

RUN \ 
    #--------------------------------------------------------------------------
    # Autoconf
    #--------------------------------------------------------------------------
    mkdir autoconf && \
    pushd autoconf && \
        curl -s https://gist.githubusercontent.com/rosecompiler/679d0aae205f687a7091/raw/1cd8b2e1843c6301b20b537770d0fe512aff24d5/install-autoconf.sh | \
            bash /dev/stdin ${AUTOCONF_VERSION} && \
            source ${AUTOCONF_VERSION}/setup.sh && \ 
    popd && \
    #--------------------------------------------------------------------------
    # Automake
    #--------------------------------------------------------------------------
    mkdir automake && \
    pushd automake && \
        curl -s https://gist.githubusercontent.com/rosecompiler/0354522d809b5803f17a/raw/d5c091a53e8831279b1ce49385572f28176771e8/install-automake.sh | \
            bash /dev/stdin ${AUTOMAKE_VERSION} && \
            source ${AUTOMAKE_VERSION}/autoconf/${AUTOCONF_VERSION}/setup.sh && \
    popd && \
    #--------------------------------------------------------------------------
    # Libtool
    #--------------------------------------------------------------------------
    mkdir libtool && \
    pushd libtool && \
        curl -s https://gist.githubusercontent.com/rosecompiler/f13bf9725f9ac99f6639/raw/2e759064a70d6a136509339bf279929910da9277/install-libtool.sh | \
            bash /dev/stdin ${LIBTOOL_VERSION}

RUN \
    source libtool/${LIBTOOL_VERSION}/automake/${AUTOMAKE_VERSION}/autoconf/${AUTOCONF_VERSION}/setup.sh && \
    #--------------------------------------------------------------------------
    # GMP
    #--------------------------------------------------------------------------
    mkdir gmp && \
    pushd gmp && \
        curl -s https://gist.githubusercontent.com/rosecompiler/815bdf7fbe90ec2dfe8c/raw/048a81419e8e013a9352d31e76eeabd6b8e00fa9/install-gmp.sh | \
            bash /dev/stdin ${GMP_VERSION} && \
            source ${GMP_VERSION}/setup.sh && \
    popd && \
    #--------------------------------------------------------------------------
    # MPFR
    #--------------------------------------------------------------------------
    mkdir mpfr && \
    pushd mpfr && \
        curl -s https://gist.githubusercontent.com/rosecompiler/8f00ffbd5e13f8978c08/raw/eeaba5a779d7a8b5d05f00101c3d14689933b700/install-mpfr.sh | \
            bash /dev/stdin ${MPFR_VERSION} && \
            source ${MPFR_VERSION}/gmp/${GMP_VERSION}/setup.sh && \
    popd && \
    #--------------------------------------------------------------------------
    # MPC
    #--------------------------------------------------------------------------
    mkdir mpc && \
    pushd mpc && \
        curl -s https://gist.githubusercontent.com/rosecompiler/117e626a80d4865aaafb/raw/d907b0461ef3340a7359ef786fcac835efd84738/install-mpc.sh | \
            bash /dev/stdin ${MPC_VERSION} && \
            source ${MPC_VERSION}/mpfr/${MPFR_VERSION}/gmp/${GMP_VERSION}/setup.sh && \
    popd && \
    #--------------------------------------------------------------------------
    # GCC
    #--------------------------------------------------------------------------
    mkdir gcc && \
    pushd gcc && \
        curl -s https://gist.githubusercontent.com/rosecompiler/cfafc452a2fdc1446968/raw/86087252c73d07b7a326a9a5c77cdad0acbb5736/install-gcc.sh | \
            bash /dev/stdin ${GCC_VERSION} && \
    popd

RUN \
    source gcc/${GCC_VERSION}/setup.sh && \
    #--------------------------------------------------------------------------
    # Boost
    #--------------------------------------------------------------------------
    mkdir boost && \
    pushd boost && \
        curl -s https://gist.githubusercontent.com/rosecompiler/e2916fb206f42f736e07/raw/fba39f95e4eba2b0b83506e11c81eacbc44fb5ed/install-boost.sh | \
            bash /dev/stdin ${BOOST_VERSION}

#--------------------------------------------------------------------------
# Remove installation workspaces for dependencies
#--------------------------------------------------------------------------
RUN \
    find ${DEPS_DESTDIR} -maxdepth 7 -type d -name '*workspace*' | xargs rm -rf

#----------------------------------------------------------
# Environment Setup
#----------------------------------------------------------
COPY setup.sh /root/opt/setup.sh

