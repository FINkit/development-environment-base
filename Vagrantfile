# -*- mode: ruby -*-
# vi: set ft=ruby :

# Check and Install required plugins if missing
installed_plugins = false
required_plugins=%w( vagrant-vbguest vagrant-reload vagrant-cachier vagrant-env )
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

Vagrant.configure("2") do |config|
  config.trigger.before :up do |trigger|
    trigger.name = "Start"
    trigger.info =
        "******************************************************\n" +
        "* FinKit Development Environment                     *\n" +
        "*                                                    *\n" +
        "* WARNING!!! Do not login to development environment *\n" +
        "* before provisioning completes!!                    *\n" +
        "*                                                    *\n" +
        "* Premature access can cause adverse side effects    *\n" +
        "* and instability.                                   *\n" +
        "*                                                    *\n" +
        "* A message will display when it is safe to login.   *\n" +
        "******************************************************\n"
  end

  config.trigger.after :up do |trigger|
    trigger.name = "Finished"
    trigger.info =
        "******************************************************\n" +
        "* FinKit Development Environment                     *\n" +
        "*                                                    *\n" +
        "* You can now login to the development environment   *\n" +
        "* The username and password are both 'vagrant'       *\n" +
        "******************************************************\n"
  end

  # Latest version available at https://app.vagrantup.com/finkit/boxes/development-environment-base
  config.vm.box_url="https://app.vagrantup.com/finkit/boxes/development-environment-base"
  config.vm.box = "finkit/development-environment-base"
  config.vm.box_version = "2.0.1541623753"

  if Vagrant.has_plugin?("vagrant-cachier")
    # The vagrant-cachier plugin (optional) will speed up rebuilds by reusing downloaded artifacts
    # Configure cached packages to be shared between instances of the same base box.
    config.cache.scope = :box
  end

  config.vm.provision :reload

  # VirtualBox.
  config.vm.define "virtualbox" do |virtualbox|
    config.vm.provider :virtualbox do |v|
      v.gui = true
      v.name = "development-environment"
      v.customize ["modifyvm", :id, "--cpus", ENV['DEVENV_PROCESSORS'] || "2"]
      v.customize ["modifyvm", :id, "--monitorcount", ENV['DEVENV_MONITORCOUNT'] || "1"]
      v.customize ["modifyvm", :id, "--memory", ENV['DEVENV_MEMORY'] || "4096"]
      v.customize ["modifyvm", :id, "--vram", "128"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
      v.customize ["modifyvm", :id, "--accelerate3d", "on"]
      v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/ --timesync-set-threshold", 10000]
    end
  end

end
