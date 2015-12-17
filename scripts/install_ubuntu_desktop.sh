#!/bin/bash

echo "Installing ubuntu desktop"
sudo apt-get -y -qq install --no-install-recommends ubuntu-desktop >/dev/null 2>/dev/null

echo "Installing unity packages"
sudo apt-get -y -qq install unity-lens-* unity-scope-home >/dev/null 2>/dev/null
