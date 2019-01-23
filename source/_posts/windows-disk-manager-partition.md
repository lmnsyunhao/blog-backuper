---
title: Windows10 磁盘管理工具 分区管理 创建分区
tags: [Windows, 磁盘管理, 分区]
categories: [系统安装]
comments: true
mathjax: false
date: 2018-07-13 22:08:18
---
本文讲如何用windows10自带的磁盘管理工具进行分区管理。装系统之后一般都需要进行这种操作。安装双系统等可能也需要用到这个东西，所以再这里就单拿出来说一下。  

<!-- more -->

# 创建分区
首先打开磁盘管理，右键单击屏幕左下角windows徽。然后点击磁盘管理。如下：  
![打开磁盘管理#postpic/pica/windows-disk-manager-partition/1.png]()
然后点击需要分配的空间，即显示未分配的部分，然后右键单击，弹出框中点击新建简单卷。如下：  
![右键点击#postpic/pica/windows-disk-manager-partition/2.png]()
然后出现对话框，点击下一步：如图：  
![下一步#postpic/pica/windows-disk-manager-partition/3.png]()
然后填写新建的分区的大小。1G=1024M，如下图：点击下一步  
![划分大小#postpic/pica/windows-disk-manager-partition/4.png]()
然后给磁盘分配驱动器号。这个驱动器号分配了之后，不要乱改了。不然容易出现应用程序找不到，打不开的情况。点击下一步  
![分配驱动器号#postpic/pica/windows-disk-manager-partition/5.png]()
文件系统，一般都是NTFS，然后卷标这是是自己起的名字，如果不喜欢可以改。分配好之后，随时都可以改的。不会游应用程序找不到啊，这种情况。点击下一步  
![卷标#postpic/pica/windows-disk-manager-partition/6.png]()
然后出现这个界面，确认之后，点击完成。  
![完成#postpic/pica/windows-disk-manager-partition/7.png]()
稍等一会儿，等格式化完成之后就创建完成了。  