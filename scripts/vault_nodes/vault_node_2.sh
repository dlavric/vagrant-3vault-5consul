#!/usr/bin/env bash

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

apt-get install -y vault=1.7.0 -V

apt-get install -y consul

mkdir -p /var/consul
chown -R consul:consul /var/consul

cd /etc/consul.d

tee consul2.json <<EOF
{
  "server": false,
  "datacenter": "dc1",
  "node_name": "consul-client-2",
  "data_dir": "/var/consul/data",
  "bind_addr": "192.168.56.152",
  "client_addr": "127.0.0.1",
  "retry_join": ["192.168.56.141","192.168.56.142","192.168.56.143"],
  "log_level": "DEBUG",
  "enable_syslog": true,
  "acl_enforce_version_8": false
}
EOF

#consul agent -data-dir=consul2.json

sudo systemctl start consul

sudo chown root:root vault

sudo useradd --system --home /etc/vault.d --shell /bin/false vault

cd /etc/vault.d

tee vault.hcl <<EOF
ui = true
mlock = false
disable_mlock = true

storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault"
}

# HTTP listener
listener "tcp" {
  address          = "127.0.0.1:8200"
  cluster_address  = "127.0.0.1:8201"
  tls_disable      = "true"
}

api_addr =  "127.0.0.1:8200"
cluster_addr = "127.0.0.1:8201"
EOF

sudo chown --recursive vault:vault /etc/vault.d

sudo chmod 640 /etc/vault.d/vault.hcl

systemctl enable vault
systemctl stop vault
systemctl start vault





