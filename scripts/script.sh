#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y

###INIT INSTALLS###
#Install Java
sudo apt install openjdk-17-jdk openjdk-17-jre -y
sudo apt-get install -y debian-keyring debian-archive-keyring apt-transport-https ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
###INIT INSTALLS###

##ADD REPOSITORY, KEYS###
# Add Jenkins repository
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

#Add Caddy repository

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

#Add Docker repository
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

##ADD REPOSITORY, KEYS###


sudo apt-get update

###INSTALL PACKAGES###
#Install Jenkins
sudo apt-get install jenkins -y

# Install Caddy
sudo apt-get install caddy -y

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

###INSTALL PACKAGES###

## POST INSTALL STEPS##

## POST INSTALL STEPS##