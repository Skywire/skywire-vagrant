# skywire-vagrant

A standardised development environment With Vagrant/Puppet

The box has Percona, Nginx and PHP5.5-fpm installed and is based on the Nimbus 'Super Brew' server from Harrys of London.

You can connect to the box in your browser via http://vagrant.site and https://vagrant.site if you haven't change the default config.

The https site already has a self signed certificate setup.

## Installation

Download/Update Vagrant from: http://www.vagrantup.com/downloads

Download/Update Virtualbox from: https://www.virtualbox.org/wiki/Downloads

Install the [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) which will auto add the Vagrant box's defined hostname and IP to your hosts file and remove it again when needed.:

`vagrant plugin install vagrant-hostsupdater`

Ignore `/.vagrant` in your projects `.gitignore`.

## Configuration

* Configure Puppet by updating variables in `puppet/manifests/site.pp` such as `$phpVersion` and `$hostName`
* Ensure that the `config.vm.host_name` in `Vagrantfile` matches `$hostName` in `puppet/manifests/site.pp`
* The format of the hostname should match the live site but with a subdomain of 'vagrant' e.g. `vagrant.duchamplondon.com`

## Running

You can start the Vagrant box via:

`vagrant up`

You may be asked to enter the admin credentials for you computer so it can write to the hosts file.

## XDebug

XDebug is enabled. In XDebug, create a remote server to use debugging from. Set the `$phpstormServerName` variable in `puppet/manifests/site.pp` to the same name.

To debug a command line script, run it as normal in the command line with PhpStorm listening for it.

## Default Environment Information

####  Virtual Machine

* IP Address: 192.168.10.10
* Base Memory: 1024
* CPUs: 1

#### SSH

* Host: vagrant.site
* Port: 22
* Username: vagrant
* Password: vagrant

#### MySQL

* Host: 127.0.0.1
* Port: 3306
* DB: vagrant
* Root Username: root
* Root Password: no password set

## Useful commands

Full list via `vagrant --help`. For help on any individual command run `vagrant COMMAND -h`.

* `vagrant up` - starts and provisions the vagrant environment
* `vagrant status` - outputs status of the vagrant machine
* `vagrant reload` - restarts vagrant machine, loads new Vagrantfile configuration
* `vagrant ssh` - connects to machine via SSH
* `vagrant halt` - stops the vagrant machine

## Useful Tools

You may want to install [Vagrant Manager](http://vagrantmanager.com/) for a GUI that works on OSX and Windows.

## Possible Future Features

* separation of concerns - pull in configs e.g. bash from external repos
* add http://xhprof.io/ (see https://github.com/mikewhitby/magento-ansible)
* add Composer
* add Mailcatcher
* add Vanish
* add IonCube
* add PageSpeed
* add ElasticSearch
