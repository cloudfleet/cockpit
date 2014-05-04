#!/bin/bash

echo deb http://pagekite.net/pk/deb/ pagekite main | sudo tee -a /etc/apt/sources.list
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_12.04/ /' >> /etc/apt/sources.list.d/owncloud.list"
sudo apt-key adv --recv-keys --keyserver keys.gnupg.net AED248B1C7B2CAC3
wget http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_14.04/Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make pagekite
sudo apt-get install -y postgresql owncloud
sudo apt-get install -y authbind
sudo apt-get install -y git
sudo mkdir /etc/cockpit
sudo mkdir /var/log/cockpit
sudo touch /etc/authbind/byport/389
sudo chown cockpit /etc/authbind/byport/389
sudo chmod 755 /etc/authbind/byport/389


npm install
git clone https://github.com/cloudfleet/duralumin.git public/duralumin
cd public/duralumin
git checkout production
