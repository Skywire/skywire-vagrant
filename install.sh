#!/usr/bin/env bash

echo "Checking Vagrant version"
vagrant version

echo "Checking for vagrant-hostupdater"
if vagrant plugin list | grep -Fq "vagrant-hostsupdater"
then
    #update
    echo "vagrant-hostupdater already installed, checking for update"
    vagrant plugin update vagrant-hostsupdater
else
    #install
    echo "vagrant-hostupdater not installed. Installing"
    vagrant plugin install vagrant-hostsupdater
fi

echo "Pulling latest version of skywire-vagrant"
git pull

echo "Initialising and getting submodules"
git submodule update --init

echo "Type in the FULL PATH to the directory you want to install to with trailing slash, don't use '~' e.g. /Users/tom/sites/harrys/ "

read directory

echo "Copying files to $directory"
cp -r ./puppet $directory
cp ./Vagrantfile $directory

if [ -f ${directory}.gitignore ]; then
    echo "Checking .gitignore"
    if ! grep -Fq ".vagrant" ${directory}.gitignore
    then
        #add gitignore line
        echo "Updating .gitignore"
        cat .gitignore >> ${directory}.gitignore
    fi
fi

echo "Removing any unnecessary files"
cd $directory
find ./puppet -name ".git" -exec rm -rf {} \;

echo "Please type in the hostname to use e.g. vagrant.harrysoflondon.com"

read hostname

echo "Replacing default hostname with $hostname"
sed -i '' "s/vagrant.site/$hostname/g" ./Vagrantfile
sed -i '' "s/vagrant.site/$hostname/g" ./puppet/manifests/site.pp

echo "Please type in PHP version. Either: 53, 54, 55 or 56"

read php

echo "Updating PHP version"
sed -i '' "s/56/$php/g" puppet/manifests/site.pp

echo "Finished OK"
