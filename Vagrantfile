unless Vagrant.has_plugin?("vagrant-hostsupdater")
  raise 'vagrant-hostsupdater is not installed! Please run "vagrant plugin install vagrant-hostsupdater"'
end

Vagrant.configure("2") do |config|
    config.vm.host_name = "vagrant.site"
    config.vm.box       = "chef/centos-6.6"
    config.vm.network :private_network, ip: "192.168.33.10"

    config.vm.provider "virtualbox" do |v|
        v.memory = 512
        #Set this higher if you are using varnish etc
        #v.cpus = 2
        #I can't imagine you needing to set this, but i;ve added it as a comment just in case
    end

    config.vm.provision "shell", path: "puppet/install.sh"

    config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.manifest_file = "site.pp"
        puppet.module_path = "puppet/modules"
    end
end