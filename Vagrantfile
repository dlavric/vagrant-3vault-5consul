# -*- mode: ruby -*-
# vi: set ft=ruby :

# download Vault by specifying the version
# VAULT=""

Vagrant.configure("2") do |config|
    config.vm.box = "hashicorp/bionic64"


#=begin
      (1..3).each do |i|
        config.vm.define "consul-#{i}" do |consul|
          consul.vm.network "private_network", ip: "192.168.56.14#{i}"
          consul.vm.provision "shell",
            path: "scripts/consul_nodes/consul_node_#{i}.sh"
            config.vm.provider "virtualbox" do |v|
            end 
        end
      end
 #=end


=begin      
      (1..2).each do |i|
        config.vm.define "vault-#{i}" do |vault|
          vault.vm.network "private_network", ip: "192.168.56.15#{i}"
          vault.vm.provision "shell",
            path: "scripts/vault_nodes/vault_node_#{i}.sh"
            config.vm.provider "virtualbox" do |v|
            end
        end
      end
=end


end


