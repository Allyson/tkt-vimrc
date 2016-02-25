#!/bin/bash

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
curl -sL https://deb.nodesource.com/setup_5.x | bash -
sudo apt-get update

apt-get install -y build-essential cmake python-virtualenv cmake python-dev
apt-get install -y nodejs
apt-get install -y mongodb-org
apt-get install -y ntp

if [ ! -e /swapfile ]
then
	fallocate -l 4G /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo "/swapfile none swap sw 0 0" >> /etc/fstab
fi

#	Changes ssh port to 2324
sed -i.bak 's/\(Port\s*\)\([0-9]\+\)/# \1\2\n\12324/gm' /etc/ssh/sshd_config

#	This should be done to fix missing locale on mongodb
#
LC_COUNT=`grep '^LC_ALL' /etc/environment | wc -l`

if [ ${LC_COUNT} -eq 0 ] && [ ${LC_ALL:-'0'} == '0' ]
then
	echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment
else
	echo '***** LC_ALL already configured *****'
fi
