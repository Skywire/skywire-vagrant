#!/usr/bin/env bash

echo $'\nInstalling Skywire Vagrant...'

echo $'\n** Checking Vagrant version'
vagrant version

echo $'\n** Checking for vagrant-hostupdater'
if vagrant plugin list | grep -Fq "vagrant-hostsupdater"
then
    #update
    echo $'vagrant-hostupdater already installed, checking for update'
    vagrant plugin update vagrant-hostsupdater
else
    #install
    echo $'vagrant-hostupdater not installed. Installing'
    vagrant plugin install vagrant-hostsupdater
fi

echo $'\n** Pulling latest version of skywire-vagrant'
git pull

echo $'\n** Initialising and getting submodules'
git submodule update --init
git submodule foreach git pull origin master

echo $'\n** Type in the FULL PATH to the directory you want to install to WITH trailing slash, don\'t use \'~\' e.g. /Users/tom/sites/harrys/'

read directory

echo $'\n** Copying files to '$directory
cp -rv ./puppet $directory
cp -rv ./Vagrantfile $directory

if [ -f ${directory}.gitignore ]; then
    echo $'\n** Checking .gitignore'
    if ! grep -Fq ".vagrant" ${directory}.gitignore
    then
        #add gitignore line
        echo $'Updating .gitignore'
        cat .gitignore >> ${directory}.gitignore
    fi
fi

echo $'\n** Removing any unnecessary files'
cd $directory
find ./puppet -name ".git" -exec rm -rf {} \;

echo $'\n** Please type in the hostname to use e.g. vagrant.harrysoflondon.com'

read hostname

echo $'\n** Replacing default hostname with $hostname'
sed -i '' "s/vagrant.site/$hostname/g" ./Vagrantfile
sed -i '' "s/vagrant.site/$hostname/g" ./puppet/manifests/site.pp

echo $'\n** Please type in PHP version. Either: 53, 54, 55 or 56:'

read php

echo $'\n** Updating PHP version'
sed -i '' "s/56/$php/g" puppet/manifests/site.pp

echo $'\n** Do you want Varnish installed? Y/n'

read varnish

if [ varnish == 'Y' ]; then
    echo $'\n** Setting Varnish'
    sed -i '' "s/false/true/g" puppet/manifests/site.pp
fi

echo $'\nFinished OK'
