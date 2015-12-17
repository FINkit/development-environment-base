#!/bin/bash

echo "Installing mkcast..."
mkdir -p /opt/mkcast/
mkcast="https://github.com/KeyboardFire/mkcast/archive/master.zip"
wget --quiet -nv ${mkcast} -O /opt/mkcast/$(basename ${mkcast})
unzip /opt/mkcast/$(basename ${mkcast}) -d /opt/mkcast/
chown -R vagrant:vagrant /opt/mkcast/mkcast-master
ln -s /opt/mkcast/mkcast-master/mkcast /usr/local/bin/mkcast
ln -s /opt/mkcast/mkcast-master/newcast /usr/local/bin/newcast
apt-get -y -qq install wmctrl >/dev/null 2>/dev/null
apt-get -y -qq install byzanz >/dev/null 2>/dev/null
rm /opt/mkcast/$(basename ${mkcast})
