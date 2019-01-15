FROM ubuntu:16.04
MAINTAINER Justin Too <too1@llnl.gov>

USER root
SHELL ["/bin/bash", "-c"]

# Installing tzdata hangs on interactive promot
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV DEBIAN_FRONTEND=noninteractive

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
        vim emacs \
        git wget curl \
        unzip \
        python python-pip \
        ghostscript graphviz \
        environment-modules \
        make automake libtool cmake \
        flex bison \
        gcc g++ gfortran \
        libboost-all-dev && \
    apt-get clean && \
    rm -rf /tmp/*

