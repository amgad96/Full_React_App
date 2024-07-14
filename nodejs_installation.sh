#!/bin/bash
#This script to install nodejs and npm direclty on the jenkins server
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-get install -y nodejs
node -v
npm -v

