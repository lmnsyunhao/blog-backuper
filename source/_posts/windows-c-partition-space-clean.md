---
title: Windows10 C盘 空间容量提升
tags: [Windows]
categories: [Windows]
comments: true
mathjax: false
date: 2018-05-20 18:31:14
---
windows10的C盘总是莫名其妙的变小，到底是什么在占用C盘？看看如何将C盘里能请出去的请出去。  

<!-- more -->

# 症状
作为一个开发者，在使用windows的过程中，发现windows的C盘空间越来越小，这可怎么办呢？经过排查发现主要是C盘用户目录下的东西增长了。  
下面我们说几种能够提升一下C盘空间的方法。  

# 用户目录移动
windows10有了一个功能，能够将用户目录移动到别的目录。  
在`C:\Users\yunhao`目录下，基本上大部分的文件夹都能够移动到别的目录，右键文件夹，打开属性。  
![文件夹属性#postpic/pica/windows-c-partition-space-clean/attribute.png]()
可以在位置选项下选择新的位置存放该文件夹，然后会弹出对话框问你是不是要将原文件夹的内容移动过去。选是就行。  

# 设置更改存储位置
windows10的设置也能够更改内容的默认存储位置。`windows键+I`唤出设置，`系统->存储`，可以看到右侧更改新内容的保存位置。  
![设置->系统->存储#postpic/pica/windows-c-partition-space-clean/setting.png]()
![更改新内容的保存位置#postpic/pica/windows-c-partition-space-clean/path.png]()
然后改到对应的目录就行了。  

# 想法
以下字符请自行产生映射  

* 想法 -> IDEA
* 因特尔 -> intel
* 属性 -> properties

如果你安装了`想法`，那么在用户目录下会看到`.因特尔lij想法`这个目录。想要移动这个目录，需要在`想法`安装目录下的`bin`文件夹下找到`想法.属性`这个文件，然后改user.home那两行。  

# Gradle
用户目录下`.gradle`目录的移动，需要新建环境变量`GRADLE_USER_HOME`，值为`你要移动的到的目录\.gradle`，需要写上`.gradle`。  

# Android SDK
用户目录下`.android`目录的移动，需要新建环境变量`ANDROID_SDK_HOME`，值为`你要移动到的目录`，最后__不用__写上`.android`。  

# Maven
用户目录下的`.m2`目录的移动，需要在`maven`安装目录下`conf`文件夹下的`setting.xml`中改`<localRepository>你要移动到的目录/.m2/repository</localRepository>`  

# Vagrant
用户目录下的`.vagrant.d`目录的移动，需要新建环境变量`VAGRANT_HOME`，值为`你要移动到的目录\.vagrant.d`，需要写上`.vagrant.d`。  