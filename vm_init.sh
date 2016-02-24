apt-get install -y build-essential python-virtualen git cmake python-dev
curl -sL https://deb.nodesource.com/setup | bash -
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update

apt-get install nodejs
apt-get install -y mongodb-org


#	This should be done to fix missing locale on mongodb
#
# echo ""LC_ALL=\"en_US.UTF-8\"" >> /etc/environment