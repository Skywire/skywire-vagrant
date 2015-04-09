#!/usr/bin/env bash

echo "Checking vagrant version"
vagrant version

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

echo "Pulling latest version"
git pull

echo "Initialising and getting submodules"
git submodule update --init

echo "Type in the directory you want to install to (ie: /Users/tom/sites/harrys/) with trailing slash, also full directory please, don't use ~"

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

echo "Removing any unesscassry files"
cd $directory
find . -name ".git" -exec rm -rf {} \;

echo "Please type in the hostname to use. IE: vagrant.harrysoflondon.com"

read hostname

echo "Replacing hostname with $hostname"
sed -i '' "s/vagrant.site/$hostname/g" ./Vagrantfile
sed -i '' "s/vagrant.site/$hostname/g" ./puppet/manifests/site.pp

echo "Please type in PHP version. Either: 53,54,55,56"

read php

echo "updating PHP version"
sed -i '' "s/56/$php/g" puppet/manifests/site.pp

echo "Finished OK"