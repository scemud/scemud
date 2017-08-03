require './vars.rb'

%w[
  vagrant-vbguest
  vagrant-reload
].each do |plugin|
  if (ARGV[0] == 'up') && (Vagrant.has_plugin?(plugin) == false)
    puts " "
    puts "  Missing plugin!"
    puts "  -----------------------------------------"
    puts "  vagrant plugin install #{plugin}"
    puts "  -----------------------------------------"
    puts " "
    exit
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = "jhcook/fedora26"

  config.vm.provider "virtualbox" do |v|
    v.memory = $FULL_ENV ? 6144 : 2048
    v.cpus = $FULL_ENV ? 4 : 1
    if $FULL_ENV then 
      v.gui = true
      v.customize ["modifyvm", :id, "--vram", "128"]
      v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end
  end

  $WORKSPACE = "/home/vagrant/workspace"
  if $FULL_ENV then 
    config.vm.provision "file", source: ".", destination: $WORKSPACE

    if Vagrant::Util::Platform.windows? then
      config.vm.provision "shell", path: ".scripts/reset_executable_bits.sh", env: {
        WORKSPACE: $WORKSPACE
      }
    end
  else
    config.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true
    config.vm.synced_folder ".", $WORKSPACE
  end

  config.vm.provision "file", source: ".scripts/.bashrc", destination: "/home/vagrant/.bashrc"
  config.vm.provision "file", source: $GIT_PRIVKEY_PATH, destination: "/home/vagrant/.ssh/id_rsa"
  config.vm.provision "shell", path: ".scripts/provision.sh", env: {
    FULL_ENV: $FULL_ENV,
    GIT_NAME: $GIT_NAME,
    GIT_EMAIL: $GIT_EMAIL
  }
  config.vm.provision :reload
end
