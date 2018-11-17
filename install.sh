#!/bin/sh
apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce -y
curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
mkdir -p /opt/elk
wget -P /opt/elk "https://raw.githubusercontent.com/Kaustubhin/elkpaas/master/docker-compose.yml"
sysctl -w vm.max_map_count=262144
cd /opt/elk && docker-compose up -d elk