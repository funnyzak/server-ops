# ServerOPS

服务器维护。

## CentOS7

### 系统基础配置

```bash
# 切换到root用户然后执行
sudo curl https://gitee.com/funnyzak/server-ops/raw/master/CentOS7/setbase_cn.sh -o ./setbase_cn.sh && \
sudo sh ./setbase_cn.sh
```


### 只安装ZSH

```bash
# 切换到root用户然后执行
sudo curl https://gitee.com/funnyzak/server-ops/raw/master/CentOS7/setbase_zsh.sh -o ./setbase_zsh.sh && \
sudo sh ./setbase_zsh.sh

# then
chsh -s /bin/zsh

source ~/.zshrc
```
