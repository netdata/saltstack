Vagrant.configure("2") do |config|

  config.vm.define "ubuntu2004" do |ubuntu2004|
    ubuntu2004.vm.box = "ubuntu/focal64"
    ubuntu2004.vm.hostname = 'ubuntu2004'
    ubuntu2004.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end

    ubuntu2004.vm.synced_folder "salt", "/srv/salt"
    ubuntu2004.vm.network "private_network", type: "dhcp"
    ubuntu2004.vm.provision :salt do |salt|
      salt.install_type = "stable"
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
    end
  end

  config.vm.define "centos7" do |centos7|
    centos7.vm.box = "bento/centos-7"
    centos7.vm.hostname = 'centos7'
    centos7.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end

    centos7.vm.synced_folder "salt", "/srv/salt"
    centos7.vm.network "private_network", type: "dhcp"
    centos7.vm.provision :salt do |salt|
      salt.install_type = "stable"
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
    end
  end

  config.vm.define "centos8" do |centos8|
    centos8.vm.box = "bento/centos-8.5"
    centos8.vm.hostname = 'centos8'
    centos8.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end

    centos8.vm.synced_folder "salt", "/srv/salt"
    centos8.vm.network "private_network", type: "dhcp"
    centos8.vm.provision :salt do |salt|
      salt.install_type = "stable"
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
    end
  end
end
