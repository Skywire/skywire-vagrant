#!/usr/bin/env bash
# This bootstraps Puppet on CentOS 6.x
# It has been tested on CentOS 6.5 64bit

set -e

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

if which puppet > /dev/null 2>&1; then
  echo "Puppet is already installed"
  exit 0
fi

# Install higher version of ruby
echo "Install pre requisits for RVM"
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel > /dev/null
yum install -y libyaml-devel libffi-devel openssl-devel make > /dev/null
yum install -y bzip2 autoconf automake libtool bison iconv-devel > /dev/null
echo "Install RVM"
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
echo "Install Ruby 1.9.3"
rvm install 1.9.3
rvm use 1.9.3 --default
echo "Install Puppet"
gem install puppet --no-rdoc --no-ri -v 3.8.1

echo "Puppet installed!"