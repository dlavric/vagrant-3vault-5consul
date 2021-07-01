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