---
title: 刻录 Ubuntu16.04 系统盘 UltraISO刻录法
tags: [UltraISO, Ubuntu, 系统安装]
categories: [系统安装]
comments: true
mathjax: false
date: 2018-07-11 23:10:19
---
大学帮别人装了不少系统，双系统什么的，自己也看过不少博文，对装系统这方面有了些体会。应多位故人建议，总结整理。本文主要讲如何刻录Ubuntu的系统盘，以及Ubuntu系统镜像的来源。以16.04为例。  

<!-- more -->

# 下载镜像
Ubuntu镜像不难得，在[Ubuntu的官方网站](https://www.ubuntu.com/download/desktop)上就有，细心找找就能够找到镜像下载，一般都是1个G多。下载之后是`.iso`文件。  

# UltraISO刻录
刻录方式和windows大同小异。[刻录 Windows10 系统盘 UltraISO刻录法 与 官方工具法](/2018/07/11/burn-windows-installation-disk/)  
我们需要UltraISO和下载好的Ubuntu的`.iso`镜像文件  
首先打开UltraISO，如果没激活，请自行激活。点击文件，打开，然后打开镜像文件。  
![打开镜像](/images/burn-ubuntu-installation-disk/1.png)
然后点击启动，写入硬盘映像。弹出对话框  
![写入映像](/images/burn-ubuntu-installation-disk/2.png)
然后磁盘驱动器选择你要刻录的U盘(U盘质量不要太差)，然后写入方式选USB-HDD+，然后点击写入。等一会儿就刻录成功了。  
![刻录](/images/burn-ubuntu-installation-disk/3.png)