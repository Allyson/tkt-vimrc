#!/bin/bash

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
curl -sL https://deb.nodesource.com/setup_5.x | bash -
sudo apt-get update

apt-get install -y build-essential cmake python-virtualenv cmake python-dev
apt-get install -y nodejs
apt-get install -y mongodb-org


#	This should be done to fix missing locale on mongodb
#
echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment
