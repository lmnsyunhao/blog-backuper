---
title: Ubuntu16.04 GitHub SSH密钥 配置
tags: [Ubuntu, GitHub, OpenSSH, Git]
categories: [Git]
comments: true
mathjax: false
date: 2017-03-27 17:15:03
---
很多地方都需要用到SSH服务，本文简述SSH技术，如何生成并使用SSH密钥，Ubuntu 16.04 GitHub SSH连接。  

<!-- more -->

# SSH的简介
SSH技术是指通信的双方A，B，分别有自己的公钥和私钥，公钥负责加密信息，私钥负责解密信息。设定是这样的A公钥加密的信息，只能通过A的私钥来解密，不能通过其他的私钥来解密，而且通过A的公钥很难推断出A的私钥。  
通信开始前，双方得知对方的公钥，A给B发送数据，用B的公钥来加密。B给A发送数据用A的公钥来加密。  
此项技术能够保证通信之间的安全性。即使信息被第三方获取，也无法解密。避免了信息被窃取，篡改，和冒充的情况。  

# SSH的生成
首先查看`/home/username/.ssh`目录下是否有类似`id_rsa`和`id_rsa.pub`这样的一对文件存在。如果存在的话，不需要生成ssh。如果不存在的话，首先生成这样的文件。  
```
ssh-keygen
```
生成的过程中会有提示，会让你输入两次密码，这个密码是在使用ssh时候输入的，如果不想设置密码，直接按回车。  

# SSH在Github上的配置
登陆Github网站，找到个人设置界面。左侧有 SSH and GPG keys 类似字样的选项，点击。然后新建一个 SSH 的 key， 把`/home/username/.ssh/id_rsa.pub`中的内容复制过去。然后保存。之后就OK了。  
