#!/bin/bash
apt-get -y update
apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev git
cd /usr/local/src
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz
tar -xvzf ruby-1.9.3-p194.tar.gz
cd ruby-1.9.3-p194/
./configure --prefix=/usr/local
make && make install
rm /usr/local/src/ruby-1.9.3-p194.tar.gz
gem install chef ruby-shadow --no-ri --no-rdoc
sudo git clone https://github.com/strtwtsn/WCMC_Cookbooks.git
sudo chef-solo -c /var/chef/config/chefsolo.rb -j /var/chef/roles/role.json


