FROM rosecompiler/rose-dependencies:ubuntu-18.04-latest
MAINTAINER Justin Too <too1@llnl.gov>

SHELL ["/bin/bash", "-c"]

#----------------------------------------------------------
# System
#----------------------------------------------------------
RUN useradd rose -m -s /bin/bash
RUN cp /root/.bashrc /home/rose/.bashrc
USER rose
ENV HOME /home/rose
WORKDIR /home/rose

#----------------------------------------------------------
# ROSE
#----------------------------------------------------------
COPY --chown=rose create-rose-workspace.sh .
COPY --chown=rose bootstrap-rose.sh .
COPY --chown=rose configure-rose.sh .
COPY --chown=rose install-rose.sh .

RUN chmod +x ./create-rose-workspace.sh && \
    chmod +x ./bootstrap-rose.sh &&        \
    chmod +x ./configure-rose.sh &&        \
    chmod +x ./install-rose.sh

RUN . /home/rose/.bashrc &&                    \
    ./create-rose-workspace.sh &&              \
    ./bootstrap-rose.sh ${ROSE_VERSION} &&     \
    ./configure-rose.sh ${ROSE_VERSION} &&     \
    ./install-rose.sh ${ROSE_VERSION}

