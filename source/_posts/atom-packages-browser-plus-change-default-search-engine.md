---
title: Atom 插件 browser-plus 修改默认搜索
tags: [编辑器, Atom]
categories: [编辑器]
comments: true
mathjax: false
date: 2017-03-27 22:58:02
---
安装了atom的browser-plus插件之后，发现url栏的默认搜索是google搜索，想要改成百度搜索怎么办？  

<!-- more -->

# 查找
很简单。  
找到配置文件，首先进行备份，以免以后想要改回来。
```
cd ~/.atom/packages/browser-plus/lib
cp ./browser-plus-view.coffee ./browser-plus-view.coffee.backup
```

# 修改
用vim打开。`/http://www.google.com/search?as_q=`。查找到三处。将这三处替换为`http://www.baidu.com/s?ie=UTF-8&wd=`。 
然后重启atom，测试，生效。
