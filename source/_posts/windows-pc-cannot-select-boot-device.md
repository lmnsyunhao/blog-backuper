---
title: Windows10 PC 无法进入选择启动项界面 无法进入BIOS界面
tags: [Windows, 系统安装]
categories: [系统安装]
comments: true
mathjax: false
date: 2018-05-23 15:12:59
---
windows10关机后，在重启电脑的瞬间，狂按F2，无法进入对应的BIOS，狂按F12，无法进入选择启动项界面。这是windows10的快速启动的特性。本文讲关闭快速启动的方法。  

<!-- more -->

# 症状
想要安装双系统，或是干什么事情的时候，需要选择启动项，但是发现怎么按F12或者其他对应的按键，都不能进入选择启动项的界面，当然BIOS界面也是进不去。  

# 原因
Windows10有快速启动这一个功能，就是为了让每次开机更快，它并没有彻底关机，而是做了一些小操作，像是休眠，给你一种关机的假象。  

# 标准解决方法
当然是关掉快速启动功能了。如何关闭呢？  
打开控制面板  
![控制面板](/images/windows-pc-cannot-select-boot-device/controlpanel.png)
点击系统和安全  
![系统和安全](/images/windows-pc-cannot-select-boot-device/systemandsafe.png)
点击电源选项下的更改电源按钮的功能  
![更改电源按钮功能](/images/windows-pc-cannot-select-boot-device/battery.png)
先点击上边的更改当前不可用的设置，然后取消勾选启用快速启动，最后保存更改就OK了  
![快速启动](/images/windows-pc-cannot-select-boot-device/change.png)

# 暴力解决方法
其实还有一种解决方法，但是只能当次适用。就是强制关机，强制关机后的第一次启动电脑可以进入选择启动项界面，之后就不行了。  

# 注
有的电脑尽管勾选了快速启动，还是能够正常的进入选择启动项界面，BIOS界面。比如工作站之类的。这些电脑就比较强大了。  