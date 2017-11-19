#!/usr/bin/env sh

set -x

which termite 2> /dev/null

if [ $? -eq 1 ]
then
    echo 'Termite: Start Install!'
    git clone --recursive https://github.com/thestinger/termite.git
    git clone https://github.com/thestinger/vte-ng.git
    sudo apt-get install -y \
         g++ \
         libgtk-3-dev \
         libvte-2.91-dev \
         gtk-doc-tools \
         gnutls-bin \
         valac \
         intltool \
         libpcre2-dev \
         libglib3.0-cil-dev \
         libgnutls28-dev \
         libgirepository1.0-dev \
         libxml2-utils \
         gperf
    echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
    cd vte-ng && ./autogen.sh && make && sudo make install
    cd ../termite && make && sudo make install
    sudo ldconfig
    sudo mkdir -p /lib/terminfo/x; sudo ln -s \
    /usr/local/share/terminfo/x/xterm-termite \
    /lib/terminfo/x/xterm-termite
    exit 0
else
    echo 'Termite: Already Installed!' >&2
    exit 1
fi
