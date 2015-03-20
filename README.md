# skywire-vagrant

A standardised development environment With Vagrant/Puppet 

The box has Percona, Nginx and PHP5.5-fpm installed and is based on the Nimbus 'Super Brew' server from Harrys of London.

You can connect to the box in your browser via http://vagrant.site and https://vagrant.site if you haven't change the default config.

The https site already has a self signed certificate setup.

## Installation

Download/Update Vagrant from: http://www.vagrantup.com/downloads

Download/Update Virtualbox from: https://www.virtualbox.org/wiki/Downloads

Install the [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater):

`vagrant plugin install vagrant-hostsupdater`

This plugin will auto add the Vagrant box's defined hostname and IP to your hosts file and remove it again when needed.

## Running

You can start the Vagrant box via:

`vagrant up`

## Configuration

* Configure Puppet by updating variables in: `puppet/manifests/site.pp`
* Ensure that the hostname is the same in that file as it is in `./Vagrantfile`

## XDebug

XDebug is enabled. In XDebug, create a remote server to use debugging from. Set the `$phpstormServerName` variable in `puppet/manifests/site.pp` to the same name.

To debug a command line script, run it as normal in the command line with PhpStorm listening for it.
