---
title: Windows10 生成 SSH密钥 GitHub配置
tags: [Windows, GitHub, OpenSSH, Git]
categories: [Windows]
comments: true
mathjax: false
date: 2018-06-19 16:30:35
---
很多地方都需要用到SSH服务，本文简述SSH技术，如何生成并使用SSH密钥，GitHub SSH连接。  

<!-- more -->

# SSH的简介
SSH技术是指通信的双方A，B，分别有自己的公钥和私钥，公钥负责加密信息，私钥负责解密信息。设定是这样的A公钥加密的信息，只能通过A的私钥来解密，不能通过其他的私钥来解密，而且通过A的公钥很难推断出A的私钥。  
通信开始前，双方得知对方的公钥，A给B发送数据，用B的公钥来加密。B给A发送数据用A的公钥来加密。  
此项技术能够保证通信之间的安全性。即使信息被第三方获取，也无法解密。避免了信息被窃取，篡改，和冒充的情况。  

# 生成密钥
首先看看，C盘用户目录(例如：C:\Users\yunhao)下，有没有.ssh这个文件夹。如果有就不用生成，没有就生成一下。或者.ssh文件夹里面没有东西的话也需要生成  
Windows环境下生成SSH密钥和Ubuntu下生成密钥的方法几乎相仿。windows下生成可以借助GitBash来生成。在某个文件夹下右键，然后打开GitBash。如果不想用GitBash来生成key的话。那么请看本文OpenSSH服务一节  
输入`ssh-keygen`回车。生成过程中，会有提示，然后会输入两次密码，这个密码是在使用ssh时候用的，如果不想设置密码的话，就直接回车就好了。  

# GitHub上配置
登陆Github网站，找到个人设置界面。左侧有 SSH and GPG keys 类似字样的选项，点击。然后新建一个 SSH 的 key， 把`C:\Users\username\.ssh\id_rsa.pub`中的内容复制过去。然后保存。之后就OK了。  

# OpenSSH服务
还有一种方法能够生成密钥。就是开启Windows的OpenSSH服务。之后使用cmd输入ssh-keygen命令来生成。  
开启方法如下：  
[开启OpenSSH方法](/2018/06/19/windows-openssh-and-ssh-remote-connection/)