#FROM centos:centos7
FROM openshift/jenkins-2-centos7
MAINTAINER Justin Too <too1@llnl.gov>

#--------------------------------------------------------------------------
# Install general software development dependencies
#
# 1. Make sure the software packages that we'll install are up-to-date with the
#    Package Management System; automatically runs `yum check-update`
# 2. Install general development tools
# 3. Install ROSE development system dependencies
#--------------------------------------------------------------------------
USER root

RUN yum upgrade -y &&               \
    yum groupinstall -y             \
        "Development Tools" &&      \
    yum install -y                  \
        git                         \
        glibc-devel                 \
        glibc-devel.i686            \
        tar                         \
        wget                        \
        which                       \
        ghostscript &&              \
    yum install -y                  \
        vim                         \
        emacs

RUN yum install -y yum-utils \
      device-mapper-persistent-data \
      lvm2 && \
    yum-config-manager \
      --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo && \
    yum -y install docker-ce && \
    systemctl start docker && \
    docker run hello-world


#----------------------------------------------------------
# Boost
#----------------------------------------------------------
RUN mkdir -p ~/opt/boost && \
    cd ~/opt/boost && \
    curl -s https://gist.githubusercontent.com/rosecompiler/e2916fb206f42f736e07/raw/4235600552d5efdb3f1c72cc6a758fef2a733401/install-boost.sh | bash /dev/stdin 1.66.0

#----------------------------------------------------------
# Bison
#----------------------------------------------------------
RUN mkdir -p ~/opt/bison && \
    cd ~/opt/bison && \
    curl -s https://gist.githubusercontent.com/justintoo/4d43442f1970690f846d/raw/395224c39452f5980ba513390c55393261410fd5/install-bison.sh | bash /dev/stdin 3.0

#----------------------------------------------------------
# Autoconf
#----------------------------------------------------------
RUN mkdir -p ~/opt/autoconf && \
    cd ~/opt/autoconf && \
    curl -s https://gist.githubusercontent.com/rosecompiler/679d0aae205f687a7091/raw/1cd8b2e1843c6301b20b537770d0fe512aff24d5/install-autoconf.sh | bash /dev/stdin 2.69

#----------------------------------------------------------
# Automake
#----------------------------------------------------------
RUN source ~/opt/autoconf/2.69/setup.sh && \
    mkdir -p ~/opt/automake && \
    cd ~/opt/automake &&  \
    curl -s https://gist.githubusercontent.com/rosecompiler/0354522d809b5803f17a/raw/d5c091a53e8831279b1ce49385572f28176771e8/install-automake.sh | bash /dev/stdin 1.14

#----------------------------------------------------------
# Libtool
#----------------------------------------------------------
RUN source /root/opt/automake/1.14/autoconf/2.69/setup.sh && \
    mkdir -p ~/opt/libtool && \
    cd ~/opt/libtool && \
    curl -s https://gist.githubusercontent.com/rosecompiler/f13bf9725f9ac99f6639/raw/2e759064a70d6a136509339bf279929910da9277/install-libtool.sh | bash /dev/stdin 2.4

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

