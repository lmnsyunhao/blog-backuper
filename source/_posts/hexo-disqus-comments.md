---
title: Hexo NexT Disqus 评论插件
tags: [Hexo, NexT]
categories: [Hexo]
comments: true
mathjax: false
date: 2017-03-29 21:14:36
---
自从多说关闭之后，第三方的评论工具让人找了又找。于是我找到了`Disqus`。本文针对说明`NexT`主题与`Disqus`的配置。  

<!-- more -->

# 注册Disqus账号
登陆`disqus.com`注册账号。注册过程，不多做说明。

# 进行邮箱确认
注册了disqus账号之后，一定要去邮箱点击一下确认。我当时就是没有点击确认，好像就没有进行下去，还是区点击一下确认吧。

# 进入 Disqus Home 页
应该在`disqus.com/home`
![Disqus home 页#postpic/pica/hexo-disqus-comments/disqusHome.png]()
之后点击右上角的齿轮，再点击 Add Disqus To Site。找到页面最下边的 Get Started 按钮。
![GET STARTED#postpic/pica/hexo-disqus-comments/getStarted.png]()
之后点击下面的install Disqus。
![I want to install Disqus on my site#postpic/pica/hexo-disqus-comments/disqusHome.png]()
注意WebsiteName，这个名字要用到配置文件中的。起一个你喜欢的。
![Website Name#postpic/pica/hexo-disqus-comments/websiteName.png]()

# 设置主题配置文件
打开主题配置文件。找到如下的位置：
```
# Disqus
disqus:
  enable: true
  shortname: ******
  count: true
```
shortname的位置就填写刚刚的 WebSite Name 的名字。这样就配置好了。

# 重新部署
```sh
hexo clean
hexo g
hexo d
```

# PS
不过，Disqus墙没墙掉我也不太清楚，让我很是无奈。
