---
title: Windows10 开启OpenSSH服务 CMD配置SSH远程连接服务
tags: [Windows, CMD, OpenSSH]
categories: [Windows]
comments: true
mathjax: false
date: 2018-06-19 16:34:55
---
windows10开启OpenSSH的两种方法，不用去下载PuTTY，XShell啦，CMD直接可以使用SSH服务。  

<!-- more -->

# 开启OpenSSH服务
想要cmd能够使用ssh远程连接服务。我们需要打开OpenSSH服务。  
首先打开设置，快捷键windows键+I。  
![设置](/images/windows-openssh-and-ssh-remote-connection/setting.png)
然后打开应用。然后看到右侧有管理可选功能。点击管理可选功能  
![应用](/images/windows-openssh-and-ssh-remote-connection/application.png)
如果列表中有OpenSSH 客户端，或者是OpenSSH Client字样的东西，说明你的电脑已经开启了OpenSSH服务了。  
![可选功能](/images/windows-openssh-and-ssh-remote-connection/add-function.png)
如果没开启OpenSSH服务，那么就点击添加功能，然后把OpenSSH安装了就行了。  
![OpenSSH](/images/windows-openssh-and-ssh-remote-connection/openssh.png)
安装了之后，重启一下电脑，然后才能在CMD中使用ssh远程连接的服务。  
![OpenSSH功能](/images/windows-openssh-and-ssh-remote-connection/openssh-functions.png)
我们可以看到打开OpenSSH服务之后，也就开启了上图的功能。  

# SSH远程连接
我们打开CMD或者是powershell之后，就能够发现可以使用ssh远程连接服务了。  