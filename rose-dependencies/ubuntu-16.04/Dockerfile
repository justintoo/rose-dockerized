FROM ubuntu:16.04
MAINTAINER Justin Too <too1@llnl.gov>

#--------------------------------------------------------------------------
# Install general software development dependencies
#
# 1. Make sure the software packages that we'll install are up-to-date with the
#    Package Management System
# 2. Install general development tools
# 3. Install ROSE development system dependencies
#--------------------------------------------------------------------------
# Tip: Remove workspace caches in each layer, otherwise it'll still exist on each layer
# even if we remove it in the final layer. https://blog.codeship.com/reduce-docker-image-size/
#--------------------------------------------------------------------------

USER root
SHELL ["/bin/bash", "-c"]

ARG SPACK_ARGS="--verbose --insecure"
ARG SPACK_INSTALL_ARGS="--no-checksum"

ENV SPACK_DESTDIR="/usr/local"
ENV SPACK_HOME="${SPACK_DESTDIR}/spack"
ENV PATH="${SPACK_HOME}/bin:${PATH}"

# Installing tzdata hangs on interactive promot
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND=noninteractive

ENV AUTOCONF_VERSION 2.69
ENV AUTOMAKE_VERSION 1.14
ENV LIBTOOL_VERSION  2.4
ENV GMP_VERSION      5.1.2
ENV MPFR_VERSION     3.1.2
ENV MPC_VERSION      1.0
ENV GCC_VERSION      5.4.0
ENV BOOST_VERSION    1.69.0

#----------------------------------------------------------
# Install system dependencies, then remove unneeded bloat
#----------------------------------------------------------
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

#----------------------------------------------------------
# Boost
#----------------------------------------------------------
# Fails if not all optional dependencies are available =/
RUN mkdir -p ~/opt/boost && \
    cd ~/opt/boost && \
    curl -s https://gist.githubusercontent.com/rosecompiler/e2916fb206f42f736e07/raw/de476176d0e5540aa382781a9cadd3e45b407eb9/install-boost.sh | bash /dev/stdin 1.69.0 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

#----------------------------------------------------------
# Bison
#----------------------------------------------------------
RUN mkdir -p ~/opt/bison && \
    cd ~/opt/bison && \
    curl -s https://gist.githubusercontent.com/justintoo/4d43442f1970690f846d/raw/395224c39452f5980ba513390c55393261410fd5/install-bison.sh | bash /dev/stdin 3.0 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

#----------------------------------------------------------
# Autoconf
#----------------------------------------------------------
RUN mkdir -p ~/opt/autoconf && \
    cd ~/opt/autoconf && \
    curl -s https://gist.githubusercontent.com/rosecompiler/679d0aae205f687a7091/raw/1cd8b2e1843c6301b20b537770d0fe512aff24d5/install-autoconf.sh | bash /dev/stdin 2.69 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

#----------------------------------------------------------
# Automake
#----------------------------------------------------------
RUN source ~/opt/autoconf/2.69/setup.sh && \
    mkdir -p ~/opt/automake && \
    cd ~/opt/automake &&  \
    curl -s https://gist.githubusercontent.com/rosecompiler/0354522d809b5803f17a/raw/d5c091a53e8831279b1ce49385572f28176771e8/install-automake.sh | bash /dev/stdin 1.14 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

#----------------------------------------------------------
# Libtool
#----------------------------------------------------------
RUN source ~/opt/automake/1.16/autoconf/2.69/setup.sh && \
    mkdir -p ~/opt/libtool && \
    cd ~/opt/libtool && \
    curl -s https://gist.githubusercontent.com/rosecompiler/f13bf9725f9ac99f6639/raw/2e759064a70d6a136509339bf279929910da9277/install-libtool.sh | bash /dev/stdin 2.4 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

#----------------------------------------------------------
# Environment Setup
#----------------------------------------------------------
COPY setup.sh /root/opt/setup.sh

