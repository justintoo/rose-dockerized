FROM ubuntu:18.04
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
# 1. Install Spack to /usr/local/spack
# 2. Add compilers from the environment to Spack
# 3. Add `spack` to ~/.bashrc
#----------------------------------------------------------
RUN cd "${SPACK_DESTDIR}" && \
    git clone --branch ROSE-1444-add-rose-0.9.10.0-cxx11 https://github.com/justintoo/spack && \
    echo 'export SPACK_HOME="${SPACK_HOME}"' >> ~/.bashrc && \
    echo 'export PATH="${SPACK_HOME}/bin:${PATH}"' >> ~/.bashrc && \
    echo '. ${SPACK_HOME}/share/spack/setup-env.sh' >> ~/.bashrc && \
    echo '. /usr/share/modules/init/bash' >> ~/.bashrc && \
    spack compiler add

#----------------------------------------------------------
# Install ROSE dependencies with Spack
#----------------------------------------------------------
RUN spack ${SPACK_ARGS} install ${SPACK_INSTALL_ARGS} --only dependencies rose boost@1.68.0 +cxx11 %gcc@6.3.0

