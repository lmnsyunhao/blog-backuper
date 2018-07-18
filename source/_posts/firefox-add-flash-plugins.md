---
title: Ubuntu16.04 FireFox Flash 插件安装
tags: [Ubuntu, 浏览器, FireFox]
categories: [浏览器]
comments: true
mathjax: false
date: 2017-03-30 14:10:20
---
firefox浏览器下载了之后，默认都是没有安装插件的。如何给firefox浏览器安装插件呢？希望下这篇帖子能够帮助你。  

<!-- more -->

# flash插件官网
去`https://get.adobe.com/flashplayer/`这个网站，下载对应的flash插件。选择tar.gz下载。

# 解压
解压下载之后的文件。
```
tar -xzvf flash_player_npapi_linux.x86_64.tar.gz
```
# 目录结构
解压了之后，我们可以清晰的看到目录结构。
```
.
├── flash_player_npapi_linux.x86_64.tar.gz
├── LGPL
│   ├── LGPL.txt
│   └── notice.txt
├── libflashplayer.so
├── license.pdf
├── readme.txt
└── usr
    ├── bin
    ├── lib
    ├── lib64
    └── share
```

# 拷贝文件
将`libflashplayer.so`这个文件拷贝到`/usr/lib/firefox-addons/plugins`，将usr下的东西拷贝到/usr下。
```
sudo cp libflashplayer.so /usr/lib/firefox-addons/plugins
sudo cp -r usr/ /usr
```

# 重启firefox
重新启动，firefox，我们就会发现，能够使用flash插件了。
