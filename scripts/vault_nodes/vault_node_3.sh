#!/usr/bin/env bash

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

apt-get install vault=1.7.0 -V

apt-get install consul

tee consul3.json <<EOF
{
  "server": false,
  "datacenter": "dc2",
  "node_name": "consul-3",
  "data_dir": "/var/consul/data",
  "bind_addr": "127.0.0.1",
  "client_addr": "127.0.0.1",
  "retry_join": ["192.168.56.141","192.168.56.142"],
  "log_level": "DEBUG",
  "enable_syslog": true,
  "acl_enforce_version_8": false
}
EOF


export CONSUL_HTTP_ADDR="127.0.0.1:8500"

consul agent -data-dir=consul3.json

sudo systemctl start consul

sudo chown root:root vault

sudo useradd --system --home /etc/vault.d --shell /bin/false vault

cd /etc/vault.d

tee vault.hcl <<EOF
# Full configuration options can be found at https://www.vaultproject.io/docs/configuration

ui = true

#mlock = true
disable_mlock = true

#storage "file" {
#  path = "/opt/vault/data"
#}

storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault"
}

# HTTP listener
#listener "tcp" {
#  address = "127.0.0.1:8200"
#  tls_disable = 1
#}

# HTTPS listener
listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_cert_file   = "/opt/vault/tls/tls.crt"
  tls_key_file    = "/opt/vault/tls/tls.key"
}

# Example AWS KMS auto unseal
#seal "awskms" {
#  region = "us-east-1"
#  kms_key_id = "REPLACE-ME"
#}

# Example HSM auto unseal
#seal "pkcs11" {
#  lib            = "/usr/vault/lib/libCryptoki2_64.so"
#  slot           = "0"
#  pin            = "AAAA-BBBB-CCCC-DDDD"
#  key_label      = "vault-hsm-key"
#  hmac_key_label = "vault-hsm-hmac-key"
#}
EOF

sudo chown --recursive vault:vault /etc/vault.d

sudo chmod 640 /etc/vault.d/vault.hcl

vault server -config=/etc/vault.d/vault.hcl

systemctl enable vault
systemctl start vault





