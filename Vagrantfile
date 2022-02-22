# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

require 'yaml'

servers = YAML.load_file(File.join(File.dirname(__FILE__), 'servers.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  servers.each do |servers|
    config.vm.define servers["name"] do |srv|
      srv.vm.box = servers["box"]
      srv.vm.hostname = servers["name"]
      srv.vm.network "private_network", ip: servers["ip"]
      srv.vm.provider :virtualbox do |vb|
        vb.name = servers["name"]
        vb.memory = servers["ram"]
        vb.cpus = servers['cpus']
      end

      srv.vm.synced_folder "salt", "/srv/salt"
      srv.vm.network "private_network", type: "dhcp"
      if servers['name'] == 'centos8'
        srv.vm.provision "shell", inline: "sed -i 's/releasever/releasever-stream/g' /etc/yum.repos.d/*"
      end
      srv.vm.provision :salt do |salt|
        salt.install_type = "stable"
        salt.masterless = true
        salt.minion_config = "salt/minion"
        salt.run_highstate = true
      end
    end
  end
end
