#!/bin/bash

echo deb http://pagekite.net/pk/deb/ pagekite main | sudo tee -a /etc/apt/sources.list
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_12.04/ /' >> /etc/apt/sources.list.d/owncloud.list"
sudo apt-key adv --recv-keys --keyserver keys.gnupg.net AED248B1C7B2CAC3
sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make pagekite
sudo apt-get install -y owncloud

npm install