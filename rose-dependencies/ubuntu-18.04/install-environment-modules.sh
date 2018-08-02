#!/bin/bash -ex

#-----------------------------------------------------------
# Option 1 – Automatic installation
#-----------------------------------------------------------
apt-get install -y tcl tcl8.4-dev environment-modules

#-----------------------------------------------------------
# Option 2 – Manual installation
#-----------------------------------------------------------
: ${DESTDIR:=/tmp/environment-modules}
: ${WORKSPACE:=${DESTDIR}/workspace}
: ${PACKAGES_DIR:=/packages}
: ${MODULES_DIR:=/modules}

mkdir -p "${PACKAGES_DIR}"
mkdir -p "${MODULES_DIR}"

mkdir -p "${WORKSPACE}"
wget http://downloads.sourceforge.net/project/modules/Modules/modules-3.2.9/modules-3.2.9c.tar.gz
tar xvvf modules-3.2.9c.tar.gz
cd modules-3.2.9/

./configure --with-module-path="${MODULES_DIR}"
make -j
make -j install

cat > /etc/profile.d/modules.sh <<-EOF
#----------------------------------------------------------------------#
# system-wide profile.modules #
# Initialize modules for all sh-derivative shells #
#----------------------------------------------------------------------#
trap "" 1 2 3
 
MODULES=/usr/local/Modules/3.2.9
 
case "\$0" in
    -bash|bash|*/bash) . \$MODULES/init/bash ;;
       -ksh|ksh|*/ksh) . \$MODULES/init/ksh ;;
          -sh|sh|*/sh) . \$MODULES/init/sh ;;
                    *) . \$MODULES/init/sh ;; # default for scripts
esac
 
trap - 1 2 3
EOF

