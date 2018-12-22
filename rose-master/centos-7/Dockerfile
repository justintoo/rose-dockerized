FROM rosecompiler/rose-dependencies:centos-7-latest
MAINTAINER Justin Too <too1@llnl.gov>

SHELL ["/bin/bash", "-c"]

#----------------------------------------------------------
# System
#----------------------------------------------------------
#RUN useradd rose -m -s /bin/bash
#RUN cp /root/.bashrc /home/rose/.bashrc
#USER rose
ENV HOME /root
WORKDIR /root

#----------------------------------------------------------
# ROSE
#----------------------------------------------------------
COPY --chown=root install-rose.sh .
RUN chmod +x ./install-rose.sh
RUN ./install-rose.sh

