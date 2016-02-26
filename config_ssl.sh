#!/bin/sh
#
#	Configure server to https
VER=01.00

if [ $# -eq 0 ]
then
	echo "config_ssl.sh Ver: ${VER}"
	echo "========================\n"
	echo "This script will configure letsencrypt's files and mongodb keys.\n"

	echo "Missing domain Name"
	echo "Usage: $0 domainName\n\n"
	exit
fi

git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
cd /opt/letsencrypt

./letsencrypt-auto certonly --standalone



