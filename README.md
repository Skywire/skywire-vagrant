# skywire-vagrant

A standardised development environment With Vagrant/Puppet

The box has Percona, Nginx and PHP installed and is based on the Nimbus 'Super Brew' server from Harrys of London.

The https site already has a self signed certificate setup.

## Installation

Download/Update Vagrant from: http://www.vagrantup.com/downloads

Download/Update Virtualbox from: https://www.virtualbox.org/wiki/Downloads

Use the installer at `install.sh`.

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

## XHProf

* Profiling made easy.
* Turn on profiling by adding `?_profile=1` to the end of a url
* Turn off profiling by either closing your browser window or adding `?_profile=0` to the end of a url
* Then head to port 81 of your site to view your profiles e.g. http://vagrant.duchamplondon.com:81
* PHPStorm breaks during debugging on the header and footer. You can change this bu turning off the two "Force break ..." options in PHP/Debug in the options

* Wall Time = Time in function and decendants
* Exclusive Wall Time = Time in function

## MailHog

* Capture email being sent from the server
* View email in a web interface on port 8025. Eg: http://vagrant.duchamplondon.com:8025
* Set up MailHog to then send email onwards to actual destination

## Default Environment Information

####  Virtual Machine

* IP Address: 192.168.10.10
* Base Memory: 512
* CPUs: 1

#### SSH

This can be retrieved by running `vagrant ssh-config` from the host machine.

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
* `` - Updates git submodules and pulls latest commits

## Useful Tools

You may want to install [Vagrant Manager](http://vagrantmanager.com/) for a GUI that works on OSX and Windows.

## Possible Future Features

* add ElasticSearch

## Updating the vagrant box

* Comment out the include includes in the main manifest/init.pp
* run the following in the vagrant box:
    * `wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O .ssh/authorized_keys`
    * `chmod 700 .ssh`
    * `chmod 600 .ssh/authorized_keys`
    * `chown -R vagrant:vagrant .ssh`
    * `sudo rm /etc/udev/rules.d/70-persistent-net.rules`
* Also trim down the .bash_profile file so that things aren't interefing
* Then shut the vagrant box down with the following in the Vagrantfile
    * config.ssh.insert_key = false
* Check where the ssh key is currently with:
    * `vagrant ssh-config`
* and delete the SSH key
* Now you can package up the vagrant box with:
    * `vagrant package --base skywire-vagrant_default_1443182016420_24825 --output ~/Desktop/skywire1.box`
* Upload this to https://atlas.hashicorp.com/valguss2001
