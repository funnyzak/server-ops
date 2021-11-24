
#!/bin/sh
set -x

yum install -y zsh git wget

echo "clone oh my zsh"
mkdir -p /mnt/down/ohmyzsh && git clone https://gitee.com/mirrors/oh-my-zsh.git /mnt/down/ohmyzsh

echo "down omz install.sh"
curl https://gitee.com/funnyzak/server-ops/raw/master/CentOS7/res/ohmyzsh/tools/install.sh -o /mnt/down/ohmyzsh/tools/install.sh

echo "执行omz安装"
sh /mnt/down/ohmyzsh/tools/install.sh  --unattended

echo "设置更新仓库zsh"
cd ~/.oh-my-zsh
git remote set-url origin https://gitee.com/mirrors/oh-my-zsh.git
git pull

echo "下载omz插件"
echo "zsh-syntax-highlighting"
git clone https://gitee.com/funnyzak/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "zsh-autosuggestions"
git clone https://gitee.com/funnyzak/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "spaceship"
git clone https://gitee.com/funnyzak/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "下载zshrc"
curl https://gitee.com/funnyzak/server-ops/raw/master/CentOS7/res/ohmyzsh/zshrc -o ~/.zshrc


echo "更换ZSH"
chsh -s /bin/zsh

echo "生效zshrc"
source ~/.zshrc