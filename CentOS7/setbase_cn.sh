#!/bin/bash

echo "工作区"
mkdir -p /mnt/down && mkdir -p /mnt/app

echo "安装zsh"
yum -y install git zsh

echo "更换ZSH"
chsh -s /bin/zsh

echo "安装oh my zsh"
mkdir -p /mnt/down/ohmyzsh && git clone https://gitee.com/mirrors/oh-my-zsh.git /mnt/down/ohmyzsh



