# vagrant-3vault-5consul
Vagrant builds 3 vault and 5 consul

This repository has been created for the purpose 
of learning the following [tutorial](https://learn.hashicorp.com/tutorials/vault/deployment-guide?in=vault/day-one-consul).

List what the package that has installed 
$ dpkg-query -L vault

Do not ask for confirmation when destroying the machine
$ vagrant destroy -f

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