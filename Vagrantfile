# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.define "squid-proxy-server" do |squid|
      squid.vm.box = "gusztavvargadr/ubuntu-server-2204-lts"
      squid.vm.box_version = "2204.0.2503"
      squid.vm.hostname = "squid-proxy-server"
      squid.vm.network "private_network", ip: "192.168.56.10"
      squid.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
    end

    config.vm.define "virus-server" do |virus|
      virus.vm.box = "gusztavvargadr/ubuntu-server-2204-lts"
      virus.vm.box_version = "2204.0.2503"
      virus.vm.hostname = "virus-server"
      virus.vm.network "private_network", ip: "192.168.56.11"
      virus.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.cpus = 4
      end
    end

        # Ubuntu Desktop (using the Ubuntu Desktop box)
        config.vm.define "ubuntu-desktop-client" do |desktop|
          desktop.vm.box = "gusztavvargadr/ubuntu-desktop-2204-lts"
          desktop.vm.box_version = "2204.0.2409"
          desktop.vm.hostname = "ubuntu-desktop-client"
          desktop.vm.network "private_network", ip: "192.168.56.30"
          
          # Enable GUI for the desktop version
          desktop.vm.provider "virtualbox" do |vb|
            vb.gui = true
            vb.memory = "4096"
            vb.cpus = 2
            vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
            vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
            vb.customize ["setextradata", :id, "GUI\/LastGuestSizeHint", "1920,1080"]
          end
          desktop.vm.provision "shell", inline: <<-SHELL
            apt update
            apt upgrade -y
            apt install openvpn -y
            apt install -y net-tools
            echo 'http_proxy=http://192.168.56.10:3128' >> /etc/environment
            echo 'https_proxy=http://192.168.56.10:3128' >> /etc/environment
          SHELL
        end
      end