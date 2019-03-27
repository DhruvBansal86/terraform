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

echo "=====================>!!!! INSTALLING JENKINS !!!!<========================"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get update
sudo apt-get install -y jenkins

sudo touch /opt/jenkins.txt

sleep 10

echo "=====================>!!!! INSTALLING ANSIBLE !!!!<========================"

sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

sudo touch /opt/ansible.txt
sleep 10
