Vagrant.configure("2") do |config|
  # MySQL VM
  config.vm.define "vm-db" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.network "private_network", ip: "192.168.56.10"
    db.vm.provision "shell", path: "scripts/setup_db.sh"
  end

  # Redis VM
  config.vm.define "vm-cache" do |cache|
    cache.vm.box = "ubuntu/focal64"
    cache.vm.network "private_network", ip: "192.168.56.11"
    cache.vm.provision "shell", path: "scripts/setup_cache.sh"
  end

  # App VM
  config.vm.define "vm-app" do |app|
    app.vm.box = "ubuntu/focal64"
    app.vm.network "private_network", ip: "192.168.56.12"
    app.vm.synced_folder "../spring-mysql-redis", "/home/vagrant/app"
    app.vm.provision "shell", path: "scripts/setup_app.sh"
  end

  # Nginx Proxy VM
  config.vm.define "vm-proxy" do |proxy|
    proxy.vm.box = "ubuntu/focal64"
    proxy.vm.network "forwarded_port", guest: 80, host: 8080
    proxy.vm.provision "shell", path: "scripts/setup_proxy.sh"
  end
end
