# Vault HA with 3x Vault and 3x Consul 

Vagrant builds 3x Vault and 3x Consul cluster

This repository has been created for the purpose 
of learning the following [tutorial](https://learn.hashicorp.com/tutorials/vault/deployment-guide?in=vault/day-one-consul).


## Pre-requirements 
[X] Install [VirtualBox] (https://www.virtualbox.org/wiki/Downloads)

[X] Install [Vagrant] (https://www.vagrantup.com/downloads)

## Instructions

1. Clone this repository:
`git clone git@github.com:dlavric/vagrant-3vault-5consul.git`

2. Go to the directory of the repository:
`cd vagrant-3vault-5consul`

3. Create the guest machines with Vagrant:
`vagrant up`

4. Connect to the `vault-1` machine:
`vagrant ssh vault-1`

5. Check the status of Vault:
`systemctl status vault`

6. Check if there are any errors:
`journalctl -u vault`

7. Check the `Consul members`:
`consul members`  

8. Destroy the Vagrant machine:
`vagrant destroy -f`


## Additional information

- List what the package that has installed 
```
dpkg-query -L vault
dpkg-query -L consul
```

