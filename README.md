# developer-environment

## overview
This project produces an Ubuntu OS Vagrant box, which is built using [Hashicorp Packer](https://www.packer.io/) for consumption by [Hashicorp Vagrant](https://www.vagrantup.com/), tailored to run on [VirtualBox](https://www.virtualbox.org/). The box is provisioned using [Ansible](https://www.ansible.com/), and aims to provide developers with an environment containing some of the most common development tools and packages.

## validate
To [validate](https://www.packer.io/docs/commands/validate.html) the packer configuration, navigate to the root of the project and run:

```
packer validate developer-environment.json
```

## build
To [build](https://www.packer.io/docs/commands/build.html) the project, navigate to the root of the project and run:
```
packer build developer-environment.json
```
**You'll need to set the `ATLAS_TOKEN`, `ATLAS_USERNAME` & `ATLAS_NAME` environment variables to push this artefact up to Vagrant**

## download
The built vagrant artefact is available [here](https://atlas.hashicorp.com/cooperc/boxes/developer-environment). You'll also require [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) to use this base box.

## run
You can create a basic `Vagrantfile` which will download the box and setup an environment:

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Check and Install required plugins if missing
installed_plugins = false
required_plugins=%w( vagrant-vbguest )
required_plugins.each do |plugin|
  if !Vagrant.has_plugin?plugin
    system "vagrant plugin install #{plugin}"
    installed_plugins = true
  end
end

if installed_plugins
  puts "Please re-run 'vagrant up' command"
  exit
end

Vagrant.require_version ">= 1.9.5"

$windows = (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
$mac = (/darwin/ =~ RUBY_PLATFORM) != nil
$linux = (/linux/ =~ RUBY_PLATFORM) != nil

Vagrant.configure(2) do |config|

  config.vm.box = "cooperc/developer-environment"
  config.vm.box_version = "0.99"

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.vbguest.iso_path = "http://download.virtualbox.org/virtualbox/%{version}/VBoxGuestAdditions_%{version}.iso"
  end

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.name = "development-environment"
    v.customize ["modifyvm", :id, "--cpus", "2"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    v.customize ["modifyvm", :id, "--monitorcount", "1"]
    v.customize ["modifyvm", :id, "--memory", "2048"]
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
  end
  config.vm.synced_folder ".", "/vagrant"
end
```
Save the file (_Vagrantfile_) and within the same directory, run:
```
vagrant up
```
See [Vagrant cli commands](https://www.vagrantup.com/docs/cli/) for more information.
