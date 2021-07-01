
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


