#!/bin/sh

echo "工作区创建"
mkdir -p /mnt/down && mkdir -p /mnt/app

echo "安装zsh"
yum -y install git zsh

echo "更新yum库"
yum update -y

echo "安装基础应用"
yum install epel-release -y
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

echo "安装配置cockpit"
yum -y install cockpit
systemctl enable --now cockpit.socket
systemctl start cockpit.service

echo "安装nodejs"
yum install -y nodejs 

echo "安装配置python3 环境"
yum install python3 -y
pip3 install virtualenv

echo "安装supervisor"
yum install -y supervisor
systemctl enable supervisord
systemctl start supervisord

echo "安装配置docker"
yum install -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker

echo "安装docker-compose"
curl -L "http://dev.kunlunwenbao.com:83/app/docker/compose/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "创建/mnt/app文件夹"
mkdir -p /mnt/app

echo "开启Nginx"
systemctl enable nginx 
systemctl start nginx

echo "设置防火墙"
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --zone=public --permanent --add-service=ssh
firewall-cmd --add-service=cockpit --permanent 
firewall-cmd --permanent --zone=public --add-port=80/tcp --add-port=443/tcp 
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --zone=public --add-port=9090/tcp --permanent
firewall-cmd  --reload
firewall-cmd --list-all

echo "更换ZSH"
chsh -s /bin/zsh

echo "clone oh my zsh"
mkdir -p /mnt/down/ohmyzsh && git clone https://gitee.com/mirrors/oh-my-zsh.git /mnt/down/ohmyzsh


echo "down omz install.sh"
curl https://gitee.com/funnyzak/server-ops/raw/master/CentOS7/res/ohmyzsh/tools/install.sh -o /mnt/down/ohmyzsh/tools/install.sh

echo "执行omz安装"
sh "/mnt/down/ohmyzsh/tools/install.sh"

echo "设置更新仓库zsh"
cd ~/.oh-my-zsh
git remote set-url origin https://gitee.com/mirrors/oh-my-zsh.git
git pull

echo "下载omz插件"
echo "zsh-syntax-highlighting"
git clone https://gitee.com/funnyzak/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "spaceship"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "下载zshrc"
curl https://gitee.com/funnyzak/server-ops/raw/master/CentOS7/res/ohmyzsh/zshrc -o ~/.zshrc

echo "生效zshrc"
source ~/.zshrc


echo "pull docker images"
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

echo "done."