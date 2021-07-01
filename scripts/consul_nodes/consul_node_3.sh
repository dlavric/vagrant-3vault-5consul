#!/usr/bin/env bash

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

apt-get install consul

mkdir -p /var/consul
chown -R consul:consul /var/consul

# Write the configuration file of consul 
cd /etc/consul.d
tee consul.hcl <<EOF
{
    "server": true,
    "node_name": "consul-3",
    "datacenter": "dc1",
    "data_dir": "/var/consul/data",
    "bind_addr": "192.168.56.143",
    "client_addr": "0.0.0.0",
    "advertise_addr": "127.0.0.1",
    "bootstrap_expect": 1,
    "retry_join": ["192.168.56.141","192.168.56.142"],
    "ui": true,
    "log_level": "DEBUG",
    "enable_syslog": true,
    "acl_enforce_version_8": false
}
EOF

sudo systemctl start consul