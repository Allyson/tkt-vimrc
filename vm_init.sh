#!/bin/bash

NEW_SSH_PORT=2324

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
curl -sL https://deb.nodesource.com/setup_5.x | bash -
sudo apt-get update

apt-get install -y build-essential cmake python-virtualenv cmake python-dev bc
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
SSH_PORT=$(awk '/^Port\s+/{print $NF}' /etc/ssh/sshd_config)

echo "SSH_PORT: ${SSH_PORT} - NEW_SSH_PORT: ${NEW_SSH_PORT}"

if [ ${SSH_PORT} -eq ${NEW_SSH_PORT} ]
then
	echo "***** ssh Port already ${NEW_SSH_PORT}. Nothing done"
else
	sed -i.bak 's/^\(Port\s*\)\([0-9]\+\)/# \1\2\n\12324/gm' /etc/ssh/sshd_config
fi

#	This should be done to fix missing locale on mongodb
#
LC_COUNT=`grep '^LC_ALL' /etc/environment | wc -l`

if [ ${LC_COUNT} -eq 0 ] && [ ${LC_ALL:-'0'} == '0' ]
then
	echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment
else
	echo '***** LC_ALL already configured *****'
fi

npm install -g pm2
#
#	Configure firewall
#
ufw allow ${NEW_SSH_PORT}/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable

