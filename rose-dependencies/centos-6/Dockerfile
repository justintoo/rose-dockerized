FROM centos:centos6
MAINTAINER Justin Too <too1@llnl.gov>

# Note: Remove workspace caches in each layer, otherwise it'll still exist on each layer
# even if we remove it in the final layer. https://blog.codeship.com/reduce-docker-image-size/

#--------------------------------------------------------------------------
# Install general software development dependencies
#
# 1. Make sure the software packages that we'll install are up-to-date with the
#    Package Management System; automatically runs `yum check-update`
# 2. Install general development tools
# 3. Install ROSE development system dependencies
#--------------------------------------------------------------------------
USER root

#----------------------------------------------------------
# Install system dependencies, then remove unneeded bloat
#----------------------------------------------------------
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
        emacs &&                    \
    rm -f /var/lib/rpm/__* &&       \
    rpm --rebuilddb -v -v

# TOO1 (2018/12/20): Hanging on "Cleaning up list of fastest mirrors"
#    yum -y --enablerepo='*' clean all &&    \
#        rm -rf /var/cache/yum &&            \
#        rm -f /core* &&                     \
#        rm -rf /tmp/* &&                    \
#        dd if=/dev/zero of=/EMPTY bs=1M &&  \
#        rm -f /EMPTY

#----------------------------------------------------------
# Boost
#----------------------------------------------------------
# Fails if not all optional dependencies are available =/
RUN mkdir -p ~/opt/boost && \
    cd ~/opt/boost && \
    curl -s https://gist.githubusercontent.com/rosecompiler/e2916fb206f42f736e07/raw/de476176d0e5540aa382781a9cadd3e45b407eb9/install-boost.sh | bash /dev/stdin 1.66.0 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

#----------------------------------------------------------
# Bison
#----------------------------------------------------------
RUN mkdir -p ~/opt/bison && \
    cd ~/opt/bison && \
    curl -s https://gist.githubusercontent.com/justintoo/4d43442f1970690f846d/raw/395224c39452f5980ba513390c55393261410fd5/install-bison.sh | bash /dev/stdin 3.0 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

#----------------------------------------------------------
# Autoconf
#----------------------------------------------------------
RUN mkdir -p ~/opt/autoconf && \
    cd ~/opt/autoconf && \
    curl -s https://gist.githubusercontent.com/rosecompiler/679d0aae205f687a7091/raw/1cd8b2e1843c6301b20b537770d0fe512aff24d5/install-autoconf.sh | bash /dev/stdin 2.69 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

#----------------------------------------------------------
# Automake
#----------------------------------------------------------
RUN source ~/opt/autoconf/2.69/setup.sh && \
    mkdir -p ~/opt/automake && \
    cd ~/opt/automake &&  \
    curl -s https://gist.githubusercontent.com/rosecompiler/0354522d809b5803f17a/raw/d5c091a53e8831279b1ce49385572f28176771e8/install-automake.sh | bash /dev/stdin 1.14 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

#----------------------------------------------------------
# Libtool
#----------------------------------------------------------
RUN source /root/opt/automake/1.14/autoconf/2.69/setup.sh && \
    mkdir -p ~/opt/libtool && \
    cd ~/opt/libtool && \
    curl -s https://gist.githubusercontent.com/rosecompiler/f13bf9725f9ac99f6639/raw/2e759064a70d6a136509339bf279929910da9277/install-libtool.sh | bash /dev/stdin 2.4 && \
    find . -maxdepth 7 -type d -iname "*workspace*" -exec rm -rf {} \ || true;

