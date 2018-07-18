---
title: GitHub Hexo blog 绑定域名
tags: [域名, GitHub, Hexo, DNS, Git]
categories: [Git]
comments: true
mathjax: false
date: 2017-03-27 16:47:20
---
Github 上的 username.github.io 的博客绑定域名操作。  

<!-- more -->

# 创建CNAME文件
首先我们要在`master`分之下创建`CNAME`文件，文件中写‘你自己想的二级域名.你购买的一级域名’。  
假设我想访问`www.yunhao.space`的时候，访问博客，那么二级域名是www，再加上一级域名，所以CNAME文件中写`www.yunhao.space`。  
假设想访问yunhao.space的时候，访问博客，那么二级域名就是空的，所以CNAME文件中写yunhao.space  
这时候就会遇到一个问题，每次在`hexo d`的时候，`CNAME`文件会被删除，不要慌，我们将`CNAME`文件创建在`source`目录下，然后再进行`hexo g`的时候，会生成。不用担心`CNAME`文件被删除的情况。  

# 开启仓库的GitHub Pages服务
一般是开启了，最好确认一下。去仓库的settings，注意是仓库的settings。找到GitHub Pages位置，将Source位置设置成master branch，然后点击Save。  

# 添加解析
去购买域名的网站。找到购买的一级域名。点击解析，然后添加记录。记录类型写`CNAME`，然后主机记录，就是你要起的二级域名，然后记录值，就是你的`github的username.github.io`了。如果不会添加记录，参考[域名解析配置教程](/2018/07/01/domain-name-parsing-setting-tutor/)  
我们看介绍可以知道`CNAME`是针对的两个域名之间的解析，即把记录值的域名，解析成二级域名和一级域名组合成的域名。  
添加完解析之后，稍等几分钟，访问域名就能看到你的博客了。  

# 更多
文章写得比较早，有点管中窥豹的感觉，想要了解更多的话，请参考我的另外几篇文章。[域名解析配置教程](/2018/07/01/domain-name-parsing-setting-tutor/)，[GitHub Hexo 博客 GitHub Pages 个人站点 多域名绑定问题](/2018/07/01/github-blog-multiple-domain-bundling-issue/)，[GoDaddy 域名 托管于腾讯云解析](/2018/06/18/godaddy-domain-dns-on-tencent-cloud/)