---
title: 刻录 Windows10 系统盘 UltraISO刻录法 与 官方工具法
tags: [UltraISO, Windows, 系统安装]
categories: [系统安装]
comments: true
mathjax: false
date: 2018-07-11 23:09:54
---
大学的时候，学会了装系统。干装系统这活儿也有两年了。说下刻录windows10系统盘的两种方法。UltraISO刻录方法，与官方的工具刻录方法。还有windows镜像的获得方法。  

<!-- more -->

# UltraISO + .iso镜像文件 刻录
首先你需要有UltraISO 软碟通软件，去百度下载。还需要有widows10的镜像文件。一般是.iso文件  
激活UltraISO软件，激活码善用搜索引擎。已经激活的话，请继续看  
![激活软件#postpic/pica/burn-windows-installation-disk/1.png]()
软件激活之后，打开软件。然后点击文件，打开，打开.iso镜像文件。  
![打开文件#postpic/pica/burn-windows-installation-disk/2.png]()
然后点击启动，写入硬盘映像，弹出窗口  
![刻录#postpic/pica/burn-windows-installation-disk/3.png]()
磁盘驱动器选择你要做成系统盘的U盘，写入方式选择USB-HDD+，然后点击写入。  
![开始制作#postpic/pica/burn-windows-installation-disk/4.png]()
刻录U盘的时候会格式化U盘(U盘质量不要太差)，确保备份好U盘文件。  
![格式化确认#postpic/pica/burn-windows-installation-disk/5.png]()
等待20分钟左右，就成功了。  
![成功#postpic/pica/burn-windows-installation-disk/6.png]()

# 写入方式
如果不想了解写入方式的话，那么就跳过这一节。  
写入方式，其实就是U盘的工作模式。有USB-HDD、USB-ZIP、RAW、USB-FDD、USB-CDROM等等。这些不同的模式，电脑在启动这个U盘的时候，将U盘视作不同的东西，按照不同的方式处理。  
USB-HDD，HDD是Hard Disk Driver，这是硬盘仿真模式，把U盘当做硬盘启动。这种模式兼容性很高，缺点是对于一些只支持USB-ZIP模式的电脑则无法启动。  
USB-HDD+，USB-HDD的增强版，同样对于只支持USB-ZIP的无法启动。兼容性比USB-HDD更好  
USB-HDD+ v2，USB-HDD的增强模式。同样对于只支持USB-ZIP的无法启动。兼容性比USB-HDD更好  
USB-ZIP，大容量软盘仿真模式，此模式在一些比较老的电脑上是唯一可选的模式，但对大部分新电脑来说兼容性不好，特别是2GB以上的大容量U盘。  
USB-ZIP+，USB-ZIP的增强版  
USB-ZIP+ v2，USB-ZIP的增强版  
USB-FDD，FDD是Floppy Disk Driver，软盘仿真模式。一般的软盘都用这个模式来启动。  
USB-CDROM，光盘仿真模式。  
RAW，未经处理的。未格式化的磁盘。  

# 官方工具 刻录
这个官方的工具叫MediaCreationTool，下载地址[MediaCreationTool](https://go.microsoft.com/fwlink/?LinkId=691209)，这个工具不仅可以直接刻录U盘，还能够下载windows10的iso镜像文件。  
首先打开这个文件，然后出现下面的界面，等待一会儿。  
![媒体创建工具#postpic/pica/burn-windows-installation-disk/7.png]()
![加载界面#postpic/pica/burn-windows-installation-disk/8.png]()
![加载界面#postpic/pica/burn-windows-installation-disk/9.png]()
如果提示更新了，如下：点击下载更新的媒体创建工具，如果没提示更新，请继续往下看。  
![提示更新#postpic/pica/burn-windows-installation-disk/10.png]()
然后弹出一个网页，网页中点击立即下载工具，就能够下载最新的媒体创建工具。下载完之后，打开新的媒体创建工具。  
![下载工具#postpic/pica/burn-windows-installation-disk/11.png]()
打开媒体创建工具，等一会儿，然后会出现下面的这个界面，点击接受  
![接受协议#postpic/pica/burn-windows-installation-disk/12.png]()
然后出现下面，点击创建安装介质，然后下一步，这个就是刻录U盘的  
![安装介质#postpic/pica/burn-windows-installation-disk/13.png]()
然后确认一下这个是不是自己想要的windows版本，一般默认就行。然后下一步  
![选择版本#postpic/pica/burn-windows-installation-disk/14.png]()
这个时候注意，如果选择ISO文件的话，那么它会下载windows10的镜像文件，然后保存到本地。如果刻录U盘(U盘质量不要太差)，选择U盘，然后点击下一步  
![U盘#postpic/pica/burn-windows-installation-disk/15.png]()
选择你要制作系统盘的U盘，然后点击下一步。  
![选择U盘#postpic/pica/burn-windows-installation-disk/16.png]()
等一会儿就好了。成功之后会有提示。这个时间比上面直接刻录时间要长一点。因为是先下载下来，然后给你刻录到U盘中。不过这种方式刻录的U盘总是最新版本的windows10。这也是这种方式的好处。  