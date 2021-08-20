#!/bin/bash

echo "工作区"
mkdir -p /mnt/down && mkdir -p /mnt/app

echo "安装zsh"
yum -y install git zsh

echo "更换ZSH"
chsh -s /bin/zsh

echo "安装oh my zsh"
mkdir -p /mnt/down/ohmyzsh && git clone https://gitee.com/mirrors/oh-my-zsh.git /mnt/down/ohmyzsh


curl https://gitee.com/funnyzak/server-ops/raw/master/CentOS7/res/ohmyzsh/tools/install.sh -o /mnt/down/ohmyzsh/tools/install.sh

sh /mnt/down/ohmyzsh/tools/install.sh

cd ~/.oh-my-zsh
git remote set-url origin https://gitee.com/mirrors/oh-my-zsh.git
git pull

git clone https://gitee.com/funnyzak/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


sudo yum update -y

sudo yum install epel-release -y


yum install -y zlib zlib-devel
yum install -y openssl openssl-devel
yum install -y vim*
yum install -y openssl*
yum install -y libffi-devel
yum install -y bzip2-devel
yum install -y lrzsz
yum install -y net-tools
yum install -y yum-utils
yum install -y ntfs-3g


yum -y install cockpit
systemctl enable --now cockpit.socket

systemctl start cockpit.service

firewall-cmd --add-service=cockpit --permanent 
firewall-cmd --reload


yum install -y nodejs 


# python3 环境
yum install python3 -y
pip3 install virtualenv


# 常驻进程程序 根据需要安装
yum install -y supervisor
systemctl enable supervisord
systemctl start supervisord

sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker


# 国内
sudo curl -L "http://dev.kunlunwenbao.com:83/app/docker/compose/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


mkdir -p /mnt/app
sudo systemctl enable nginx 
sudo systemctl start nginx

docker image pull funnyzak/java8-nodejs-python-go-etc:latest
docker image pull funnyzak/mysql-backup:latest
docker image pull funnyzak/alpine-cron:latest
docker image pull funnyzak/git-webhook:latest
docker image pull funnyzak/git-webhook-deploy:latest
docker image pull funnyzak/request-hub:latest
docker image pull nginx:1.18.0
docker image pull phpmyadmin/phpmyadmin:5.1.1-fpm
docker image pull redis:6.0.9
docker image pull mysql:5.7.27
docker image pull metabase/metabase:v0.37.2
docker image pull rabbitmq:3.8.11-management-alpine
docker image pull docker.elastic.co/elasticsearch/elasticsearch:7.6.0
docker image pull docker.elastic.co/logstash/logstash:7.6.0
docker image pull docker.elastic.co/kibana/kibana:7.6.0


# for aliyun
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --zone=public --permanent --add-service=ssh
firewall-cmd --permanent --zone=public --add-port=80/tcp --add-port=443/tcp 
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --zone=public --add-port=9090/tcp --permanent
firewall-cmd  --reload
firewall-cmd --list-all