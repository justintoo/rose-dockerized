FROM rose-dependencies:centos7
MAINTAINER Justin Too <too1@llnl.gov>

#----------------------------------------------------------
# ROSE
#----------------------------------------------------------
COPY create-rose-workspace.sh .
RUN chmod +x ./create-rose-workspace.sh
RUN ./create-rose-workspace.sh master

COPY bootstrap-rose.sh .
RUN chmod +x ./bootstrap-rose.sh
RUN ./bootstrap-rose.sh master

COPY bootstrap-rose.sh .
RUN chmod +x ./bootstrap-rose.sh
RUN ./bootstrap-rose.sh master

COPY configure-rose.sh .
RUN chmod +x ./configure-rose.sh
RUN ./configure-rose.sh master

COPY install-rose.sh .
RUN chmod +x ./install-rose.sh
RUN ./install-rose.sh master

