# $ docker run -v $(pwd)/mkinstaller:/root/mkinstaller -ti rosecompiler/rose:ubuntu-16.04-latest bash
export MKINSTALLER_HOME="/root/mkinstaller"
export PATH="${MKINSTALLER_HOME}/bin:${PATH}"

"${MKINSTALLER_HOME}/share/make-boost-dir.sh"
source "/root/opt/boost/setup.sh"
