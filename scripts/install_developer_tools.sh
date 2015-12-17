#!/usr/bin/env bash

echo "Installing developer packages..."
sudo apt-get -y --force-yes -qq install \
git \
gitk \
putty-tools \
dos2unix \
wmctrl \
byzanz \
alien \
tree \
jq \
groovy \
golang \
ldap-utils >/dev/null 2>/dev/null
