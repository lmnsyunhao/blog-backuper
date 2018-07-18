---
title: Ubuntu16.04 PPPoE 拨号上网
tags: [Ubuntu, PPPoE, DSL]
categories: [Ubuntu]
comments: true
mathjax: false
date: 2017-03-27 14:41:12
---
学校给了我们一个客户端来有线登陆，但是只能是windows的，ubuntu想要连接有线怎么办？ubuntu PPPoE 拨号登陆校园网  

<!-- more -->

# 配置信息
打开终端，输入`sudo pppoeconf`  
之后会出现界面，让你输入用户名，注意这个界面上默认有username，一定要把username全都删掉，再输入用户名才行。之前一直没注意。  
后面一路选是，直到有一个是询问是否开机自动连接，这个选否。  

# 三条命令
我们可以通过`plog`这条命令来，查看状态。  
我们可以通过`sudo poff -a`来断开所有连接。  
我们下次连接的时候通过`pon dsl-provider`来连接。
