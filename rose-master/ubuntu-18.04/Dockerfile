FROM rosecompiler/rose-dependencies:ubuntu-18.04-latest
MAINTAINER Justin Too <too1@llnl.gov>

#----------------------------------------------------------
# System
#----------------------------------------------------------
RUN useradd rose -m -s /bin/bash
ENV HOME /home/rose
ENV ROSE_VERSION $(curl https://raw.githubusercontent.com/rose-compiler/rose-develop/master/ROSE_VERSION)

#----------------------------------------------------------
# ROSE
#----------------------------------------------------------
COPY create-rose-workspace.sh .
COPY bootstrap-rose.sh .
COPY configure-rose.sh .
COPY install-rose.sh .

RUN chmod +x ./create-rose-workspace.sh && \
    chmod +x ./bootstrap-rose.sh &&        \
    chmod +x ./configure-rose.sh &&        \
    chmod +x ./install-rose.sh

RUN ./create-rose-workspace.sh ${ROSE_VERSION} &&   \
    ./bootstrap-rose.sh ${ROSE_VERSION} &&          \
    ./configure-rose.sh ${ROSE_VERSION} &&          \
    ./install-rose.sh ${ROSE_VERSION}

