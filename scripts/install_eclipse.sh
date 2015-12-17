#!/bin/bash

echo "Installing Eclipse..."
JDK_HOME="$(find /opt -name jre -type d -print 2>/dev/null | head -1)/.."
sudo echo "JDK_HOME=${JDK_HOME}" >> /etc/environment
product=sts
version=3.7.0.RELEASE
eclipse="http://dist.springsource.com/release/STS/3.7.0.RELEASE/dist/e4.5/spring-tool-suite-3.7.0.RELEASE-e4.5-linux-gtk-x86_64.tar.gz"
mkdir -p /opt/${product}/${version}
wget --quiet -nv ${eclipse} -O /opt/${product}/${version}/$(basename ${eclipse})
chmod 777 -R /opt/${product}/
tar zxf /opt/${product}/${version}/$(basename ${eclipse}) -C /opt/${product}/${version} --strip 2 >/dev/null 2>/dev/null
ln -sf /opt/${product}/${version}/STS /usr/bin/STS
chown -R vagrant:vagrant /opt/${product}
rm /opt/${product}/${version}/$(basename ${eclipse})
