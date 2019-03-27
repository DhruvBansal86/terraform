#!/bin/sh

echo "=====================>!!!! INSTALLING JAVA !!!!<========================"
sudo touch /opt/abc.txt

sudo apt-get install -y software-properties-common debconf-utils
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer

sudo touch /opt/java.txt

sleep 10

echo "=====================>!!!! INSTALLING TOMCAT !!!!<========================"
apt-get install -y tomcat8

sudo touch /opt/tomcat.txt

sleep 10

echo "=====================>!!!! INSTALLING DOCKER !!!!<========================"

sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo touch /opt/docker.txt

sleep 10
