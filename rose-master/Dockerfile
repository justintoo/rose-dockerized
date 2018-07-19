FROM rose-dependencies:centos7-latest
MAINTAINER Justin Too <too1@llnl.gov>

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

RUN ./create-rose-workspace.sh master &&   \
    ./bootstrap-rose.sh master &&          \
    ./configure-rose.sh master &&          \
    ./install-rose.sh master

