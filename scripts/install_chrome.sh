#!/bin/bash

###############################################################################################
## Installing Google Chrome                                                                  ##
###############################################################################################
echo "Installing chrome..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
apt-get -qq update >/dev/null 2>/dev/null
apt-get -qq -f install >/dev/null 2>/dev/null
apt-get -qq install google-chrome-stable >/dev/null 2>/dev/null
