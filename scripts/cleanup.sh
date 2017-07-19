#!/bin/bash -eux

# Credits to:
#  - http://vstone.eu/reducing-vagrant-box-size/
#  - https://github.com/mitchellh/vagrant/issues/343

APT_CACHE_LOCATION=/var/cache/apt

# delete all linux headers
dpkg --list | awk '{ print $2 }' | grep linux-headers | xargs apt-get -y purge

# this removes specific linux kernels, such as
# linux-image-3.11.0-15-generic but 
# * keeps the current kernel
# * does not touch the virtual packages, e.g.'linux-image-generic', etc.
#
sudo dpkg --list | awk '{ print $2 }' | grep 'linux-image-3.*-generic' | grep -v `uname -r` | xargs apt-get -y purge >/dev/null 2>/dev/null

# delete linux source
sudo dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge >/dev/null 2>/dev/null

# delete development packages
sudo dpkg --list | awk '{ print $2 }' | grep -- '-dev$' | xargs apt-get -y purge >/dev/null 2>/dev/null

# delete obsolete networking
sudo apt-get -y purge ppp pppconfig pppoeconf >/dev/null 2>/dev/null

# delete oddities
sudo apt-get -y purge popularity-contest >/dev/null 2>/dev/null

sudo apt-get -y autoremove >/dev/null 2>/dev/null

echo "Cleaning the ubuntu cache"
echo "Size of $APT_CACHE_LOCATION  before cleanup: $(du -sh $APT_CACHE_LOCATION | awk '{print $1}')"
sudo apt-get -y clean >/dev/null 2>/dev/null
echo "Size of $APT_CACHE_LOCATION  after cleanup: $(du -sh $APT_CACHE_LOCATION | awk '{print $1}')"
sudo rm -rf VBoxGuestAdditions.iso

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done

# Zero /tmp
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/tmp/zero bs=1024 count=$count
rm /tmp/zero
sync
 
# Zero /boot
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/boot/zero bs=1024 count=$count
rm /boot/zero
sync

# Zero /
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/zero bs=1024 count=$count
rm /zero
sync

# Zero swaps
swappart=$(cat /proc/swaps | grep -v Filename | tail -n1 | awk -F ' ' '{print $1}')
if [ "$swappart" != "" ]
then
  swapoff $swappart
  dd if=/dev/zero of=$swappart
  mkswap $swappart
  swapon $swappart
fi
