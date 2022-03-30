# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

require 'yaml'

servers = YAML.load_file(File.join(File.dirname(__FILE__), 'servers.yml'))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  servers.each do |server|
    config.vm.define server["name"] do |srv|
      srv.vm.box = server["box"]
      srv.vm.box_url = server["box_url"]
      srv.vm.hostname = server["name"]
      srv.vm.boot_timeout = 300
      srv.vm.network "private_network", ip: server["ip"]
      srv.vm.provider :virtualbox do |vb|
        vb.name = server["name"]
        vb.memory = server["ram"]
        vb.cpus = server["cpus"]
      end

      # Fix for centos8 repositories
      if server['name'].match(/^centos8/)
        srv.vm.provision "shell", inline: "sed -i 's/releasever/releasever-stream/g' /etc/yum.repos.d/*"
      end
      if server['name'].match(/^arch/)
        srv.vm.provision "shell", inline: "pacman -Syy"
      end
      srv.vm.synced_folder "salt", "/srv/salt"
      if server['name'].match(/^clearlinux/)
        srv.vm.provision "shell", inline: "sudo swupd bundle-add -y salt"
      else
        srv.vm.provision :salt do |salt|
          salt.bootstrap_script = "bootstrap-salt.sh"
          salt.install_type = "stable"
          salt.no_minion = false
          if server['master'] == true
            salt.install_master = true
          end
          salt.bootstrap_options = "-P"
          salt.masterless = true
          salt.minion_config = "salt/minion"
          salt.run_highstate = false
        end
      end
    end
  end
end
