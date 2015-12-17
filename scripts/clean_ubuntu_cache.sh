#!/bin/bash

APT_CACHE_LOCATION=/var/cache/apt

echo "Cleaning the ubuntu cache"

echo "Size of $APT_CACHE_LOCATION  before cleanup: $(du -sh $APT_CACHE_LOCATION | awk '{print $1}')"
sudo apt-get clean >/dev/null 2>/dev/null
echo "Size of $APT_CACHE_LOCATION  after cleanup: $(du -sh $APT_CACHE_LOCATION | awk '{print $1}')"
