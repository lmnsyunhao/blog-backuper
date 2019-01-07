---
title: U启动 制作WinPE启动盘 支持UEFI启动
tags: [U启动, WinPE, 系统安装, UEFI]
categories: [系统安装]
comments: true
mathjax: false
date: 2018-07-13 23:05:21
---
WinPE又叫Windows Preinstallation Environment，这个PE其实就是一个安装在U盘中的小的windows系统，里面有一些非常基础实用的功能，这个PE可以解决一些磁盘损坏、启动项丢失等与系统有关的问题。所以今天就来看看如何来制作WinPE盘。制作WinPE有好多，比如大白菜，老毛桃，大番薯等。唉，真的烦，怎么都是吃的？而且一个个起名字还这么难听。终于我找着了一个好听的，也非常好用。叫U启动，本文说如何刻录U启动WinPE盘，并且支持UEFI启动。  

<!-- more -->

# PE
Preinstallation Environment，能够管理启动项；能够再你windows系统坏的时候将你的文件备份出来；能够做最基本的磁盘管理等等。他的功能非常的多。所以，装系统的时候免不了使用PE。  

# U启动
安装过程很简单。打开官网，[U启动官网](http://www.uqdown.cn/)，然后点击下载UEFI版。如下图：   
![U启动官网](https://images.yunhao.space/pica/burn-windows-preinstallation-environment-disk/1.png)
下载了之后，打开下载的exe，然后安装U启动。如下图：  
![安装](https://images.yunhao.space/pica/burn-windows-preinstallation-environment-disk/2.png)
安装完成之后，打开U启动，然后插入U盘，U盘的质量不要太差，要不然刻录出的盘容易出问题。如下图，选中你要制作的U盘，然后其余都是默认，点击开始制作  
![制作](https://images.yunhao.space/pica/burn-windows-preinstallation-environment-disk/3.png)
然后应该会提示会清空U盘的所有数据，点击确定。  
![清除U盘](https://images.yunhao.space/pica/burn-windows-preinstallation-environment-disk/4.png)
等待制作完成  
![正在制作](https://images.yunhao.space/pica/burn-windows-preinstallation-environment-disk/5.png)
完成后会询问是否模拟启动，这个模拟启动没什么用处，就是检测这个是否刻录成功，一般都是成功的，就不用模拟启动了，选择否。  
![模拟启动](https://images.yunhao.space/pica/burn-windows-preinstallation-environment-disk/6.png)
然后U启动 WinPE，就制作好了。这个U盘支持UEFI启动，当然Legacy也同样支持。  