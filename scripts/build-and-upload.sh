#!/bin/bash

#Set up credentials
export VAGRANT_CLOUD_ENDPOINT=https://app.vagrantup.com/api/v1
export ATLAS_USERNAME=finkit
export ATLAS_NAME=development-environment-base

set -e

cd c:/users/hashilocal/workspace/development-environment-base

git pull

#Validate
packer validate development-environment-base.json

#Build and upload
packer build -force -on-error=cleanup -parallel=false development-environment-base.json
