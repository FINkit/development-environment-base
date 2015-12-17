#!/bin/bash

VERSION=0.13.8
DEB=http://dl.bintray.com/sbt/debian/sbt-${VERSION}.deb

echo "Installing sbt..."
mkdir -p /opt/sbt/${VERSION}
wget --quiet -nv $DEB -O /opt/sbt/${VERSION}/sbt-${VERSION}.deb
dpkg -i /opt/sbt/${VERSION}/sbt-${VERSION}.deb >/dev/null 2>/dev/null
apt-get -qq update >/dev/null 2>/dev/null
apt-get -qq install --no-install-recommends sbt >/dev/null 2>/dev/null

# Clean up
rm /opt/sbt/${VERSION}/sbt-${VERSION}.deb
