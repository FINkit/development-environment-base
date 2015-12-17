#!/bin/bash

echo "Installing Docker..."
curl -sSL https://get.docker.com/ | sudo sh
adduser vagrant docker
