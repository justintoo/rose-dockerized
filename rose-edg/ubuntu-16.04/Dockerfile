FROM rosecompiler/rose-dependencies:ubuntu-16.04-latest
MAINTAINER Justin Too <too1@llnl.gov>

SHELL ["/bin/bash", "-c"]

WORKDIR /root

#----------------------------------------------------------
# ROSE
#----------------------------------------------------------
COPY EDG /root/EDG
COPY install-rose-edg.sh .
RUN chmod +x ./install-rose-edg.sh
RUN ./install-rose-edg.sh

