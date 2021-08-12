
      (1..5).each do |i|
        config.vm.define "consul-#{i}" do |consul|
          consul.vm.network "private_network", ip: "192.168.56.14#{i}"
        end
      end

    vault.vm.provision "shell", path: "scripts/install_vault.sh"
    # env: { "VAULT" => VAULT||=String.new } 


vagrant.configure("2") do |config|
  config.vm.box = "anhdht/mysql"
  config.vm.box_version = "0.0.1"
 
 
  (1..2).each do |i|
    config.vm.define "web#{i}" do |web|
      web.vm.network "private_network", ip: "192.168.50.#{i+10}" 
      #install webserver
      web.vm.provision "shell", inline: "apt-get update ; apt-get install -y nginx"
 
 end
 end
 end


Check the Vault configuration file
$ cat /etc/vault.d/vault.hcl

List the package that has been installed
$ dpkg-query -L consul

$ sudo su -
$ cp /usr/lib/systemd/system/consul.service /etc/systemd/system/consul.service

systemctl start consul

sudo systemctl status consul


vagrant@consul-3:~$ sudo su -
root@consul-3:~# cat /etc/hosts
127.0.0.1       localhost
127.0.1.1       vagrant.vm      vagrant

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
127.0.2.1 consul-3 consul-3
root@consul-3:~# cp /etc/hosts /vagrant


the Host IP needs to be setup properly when I create more than one machine.

export VAULT_ADDR="http://127.0.0.1:8200"

vault operator init \
    -key-shares=1 \
    -key-threshold=1

Unseal Key 1: uOhHwlYGEF2Wl+Zhv0QMRpVtd0P+YYrH8GInWnVG++4=

Initial Root Token: s.IUQclMrZKWTHNjtE8zyBj4su

vault operator unseal uOhHwlYGEF2Wl+Zhv0QMRpVtd0P+YYrH8GInWnVG++4=



vagrant@vault-3:~$ vault operator unseal xIcZkGcd+BUmTvZyNHW4TD8UaxFy8OIUOFQshHhJEtY=
Key                    Value
---                    -----
Seal Type              shamir
Initialized            true
Sealed                 false
Total Shares           1
Threshold              1
Version                1.7.0
Storage Type           consul
Cluster Name           vault-cluster-59b45975
Cluster ID             602a0242-21d5-2b82-7751-a43eb57a5136
HA Enabled             true
HA Cluster             https://127.0.0.1:8201
HA Mode                standby
Active Node Address    http://127.0.0.1:8200