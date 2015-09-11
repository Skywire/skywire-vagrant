unless Vagrant.has_plugin?("vagrant-hostsupdater")
  raise 'vagrant-hostsupdater is not installed! Please run "vagrant plugin install vagrant-hostsupdater"'
end

Vagrant.configure("2") do |config|
    config.vm.host_name = "vagrant.site"
    config.vm.box       = "valguss2001/Skywire_Centos6"
    config.vm.network :private_network, ip: "192.168.33.10"
    config.vm.synced_folder ".", "/vagrant"

    config.vm.provider "virtualbox" do |v|
        host = RbConfig::CONFIG['host_os']
        # Give VM 1/4 system memory & access to all cpu cores on the host
        if host =~ /darwin/
            cpus = `sysctl -n hw.ncpu`.to_i
            # sysctl returns Bytes and we need to convert to MB
            mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
        elsif host =~ /linux/
            cpus = `nproc`.to_i
            # meminfo shows KB and we need to convert to MB
            mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
        else # sorry Windows folks, I can't help you
            cpus = 2
            mem = 1024
        end

        v.customize ["modifyvm", :id, "--memory", mem]
        v.customize ["modifyvm", :id, "--cpus", cpus]
    end

    config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.manifest_file = "site.pp"
        puppet.module_path = "puppet/modules"
    end
end