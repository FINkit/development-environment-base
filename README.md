# development-environment-base

[![Build Status](https://travis-ci.org/FINkit/development-environment-base.svg?branch=master)](https://travis-ci.org/FINkit/development-environment-base)

## overview
This project produces an Ubuntu OS Vagrant box, which is built using [Hashicorp Packer](https://www.packer.io/) for consumption by [Hashicorp Vagrant](https://www.vagrantup.com/), tailored to run on [VirtualBox](https://www.virtualbox.org/). The box is provisioned using [Ansible](https://www.ansible.com/), and aims to provide developers with an environment containing some of the most common development tools and packages.

This will install:
* Intellij Community Edition
* Spring Tool Suite
* Maven
* Cloud Foundry CLI
* BOSH 2.0 CLI
* and a number of other supporting development tools.

For full details of the tooling and versions provided with this environment please refer to [the parent ansible playbook](https://github.com/FINkit/development-environment-base/blob/master/ansible/main.yml) as well as the [developer packages playbook](https://github.com/FINkit/development-environment-base/blob/master/ansible/roles/developer_packages/tasks/main.yml).

## validate
To [validate](https://www.packer.io/docs/commands/validate.html) the packer configuration, navigate to the root of the project and run:

```
packer validate development-environment-base.json
```

## build
To [build](https://www.packer.io/docs/commands/build.html) the project, navigate to the root of the project and run:
```
packer build development-environment-base.json
```
**You'll need to set the `VAGRANT_CLOUD_TOKEN`, `VAGRANT_CLOUD_ENDPOINT`, `ATLAS_USERNAME` & `ATLAS_NAME` environment variables to push this artefact up to Vagrant Cloud**

## download
The built vagrant artefact is available [here](https://app.vagrantup.com/finkit/boxes/development-environment-base). You'll also require [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) to use this base box.

## run

### Prerequisites - Minimum Hardware
* 8GB RAM (by default 4GB is allocated to the VM, see [Getting Started](#getting-started) to increase this)
* 30GB disk space (not all will be allocated immediately)

### Starting the VM
Included is a basic Vagrantfile, run:
```
vagrant up
```
See [Vagrant cli commands](https://www.vagrantup.com/docs/cli/) for more information.

### Customising the hardware requirements
The following environment variables can be set to tune the development environment.

| Variable | What for | Default |
| -------- | -------- | ------- |
| `DEVENV_PROCESSORS` | How many CPU cores to allocate | 2 |
| `DEVENV_MONITORCOUNT` | The number of monitors to use | 1 |
| `DEVENV_MEMORY` | How much memory, in MB, to allocate | 4096 |

## thanks
Credit to @geerlingguy for his [image](https://github.com/geerlingguy/packer-ubuntu-1804), on which this is based
