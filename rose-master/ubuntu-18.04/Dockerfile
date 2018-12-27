FROM rosecompiler/rose-dependencies:ubuntu-18.04-latest
MAINTAINER Justin Too <too1@llnl.gov>

SHELL ["/bin/bash", "-c"]

#----------------------------------------------------------
# System
#----------------------------------------------------------
#RUN useradd rose -m -s /bin/bash
#RUN cp /root/.bashrc /home/rose/.bashrc
#USER rose
#ENV HOME /home/rose
#WORKDIR /home/rose
WORKDIR /root

#----------------------------------------------------------
# ROSE
#----------------------------------------------------------
COPY --chown=rose install-rose.sh .
RUN chmod +x ./install-rose.sh
RUN ./install-rose.sh

