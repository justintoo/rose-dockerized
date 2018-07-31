FROM rose-dependencies:ubuntu-16.04-latest
MAINTAINER Justin Too <too1@llnl.gov>

#--------------------------------------------------------------------------
# Install general software development dependencies
#
# 1. Make sure the software packages that we'll install are up-to-date with the
#    Package Management System
# 2. Install general development tools
# 3. Install ROSE development system dependencies
#
# Note: Remove workspace caches in each layer, otherwise it'll still exist on each layer
# even if we remove it in the final layer. https://blog.codeship.com/reduce-docker-image-size/
#--------------------------------------------------------------------------

#----------------------------------------------------------
# Install ROSE using spack
#
# Note: Fails on Macbook Pro for some reason; possible solution is to use `spack install -j 1`
#----------------------------------------------------------
RUN spack --verbose --insecure install -j 1 --no-checksum rose %gcc@4.8

