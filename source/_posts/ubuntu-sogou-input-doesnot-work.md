---
title: Ubuntu16.04 Sogou 输入法的备选词框不见了解决方法
tags: [Ubuntu, 搜狗输入法]
categories: [Ubuntu]
comments: true
mathjax: false
date: 2017-03-30 14:50:27
---
正在写着博客，突然Ubuntu报了一个内部错误，查看详细一看，貌似是关于sogou输入法的。没当回事儿。过了一会儿，搜狗输入法的备选词框不见了，只能输入英文，这可怎么整。赶紧解决了它。  

<!-- more -->

本帖子针对`Ubuntu16.04`。  
# 症状
Sogou输入法的备选词框不见了。只能输入英文，而且按空格键还不能将英文输进去。  

# 解决方法
重新安装输入法。首先要卸载之前的输入法。`--purge`选项是清除配置文件的。更彻底的一种卸载。  
```sh
sudo apt remove sogoupinyin --purge
```
当然，单靠这一句话的力量好像并不能解决掉问题。  
```sh
cd ~/.config
sudo rm -r SogouPY.users
sudo rm -r SogouPY
sudo rm -r sogou-qimpanel
```
然后，在这些操作之后，我重启了一下电脑。不知道需不需要这一步  
之后，安装sogou输入法的依赖  
```sh
sudo apt install libopencc1 fcitx-libs fcitx-libs-qt fonts-droid-fallback
```
然后去sogou输入法的官网，找到上面的linux输入法。然后下载最新的`deb`包。  
```sh
sudo dpkg -i ~/下载/sogoupinyin_2.1.0.0082_amd64.deb
reboot
```
然后再重启一下电脑，sogou输入法就能正常使用了。  
