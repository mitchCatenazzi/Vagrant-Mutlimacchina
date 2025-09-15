Vagrant.configure("2") do |config|
  BOX_IMAGE = "ubuntu/jammy64"
  PROXY_ENABLE = false # true se si lavora sulla rete grigia a scuola, sennò false per la nera/casa
  PROXY_URL = "http://IPPROXY:PORTA" # se si il proxy a true in rete grigia, mettere IP e la PORTA del proxy della scuola

  # definizione base delle reti
  BASE_INT_NETWORK = "10.10.20"
  BASE_HOST_ONLY_NETWORK = "192.168.56"

  # controllo plugin proxy
  unless Vagrant.has_plugin?("vagrant-proxyconf")
    raise "plugin 'vagrant-proxyconf' non installato. 
    Eseguire: vagrant plugin install vagrant-proxyconf"
  end

  # proxy, configurazione comune a tutte le VM
  if PROXY_ENABLE
    config.proxy.http     = PROXY_URL
    config.proxy.https    = PROXY_URL
    config.proxy.no_proxy = "localhost,127.0.0.1"
  end

# do |web| fa sì che tutte le configurazioni successive siano riferite alla VM web
  config.vm.define "web" do |web|
    web.vm.box = BOX_IMAGE
    web.vm.hostname = "web.m340"

    # rete INTERNA di virtual box e Host-Only
    web.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.10", virtualbox__intnet: "intnet"
    # serve per accedere alla VM dal PC host
    web.vm.network "private_network", ip: "#{BASE_HOST_ONLY_NETWORK}.10"

    # synced folder
    web.vm.synced_folder "html", "/var/www/html"

    # script di setup
    web.vm.provision "shell", path: "web.sh"

    web.vm.provider "virtualbox" do |vb|
      vb.name = "web.m340"
      vb.memory = 2048
      vb.cpus = 2
    end
  end

  
  config.vm.define "db" do |db|
    db.vm.box = BOX_IMAGE
    db.vm.hostname = "db.m340"

    # rete INTERNA di virtual box, non necessita di host-only perchè comunica solo con la web, non con l'host
    db.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.11", virtualbox__intnet: "intnet"

    # script di setup
    db.vm.provision "shell", path: "db.sh"

    db.vm.provider "virtualbox" do |vb|
      vb.name = "db.m340"
      vb.memory = 2048
      vb.cpus = 2
    end
  end
end
