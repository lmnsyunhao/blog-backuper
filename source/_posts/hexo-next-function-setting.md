---
title: Hexo NexT 站内搜索 站点统计 RSS订阅 字数统计 阅读时长 进度条 图片放大 Canvas背景 DaoVoice聊天 Gitalk评论 功能配置
tags: [Hexo, NexT]
categories: [Hexo]
comments: true
mathjax: false
date: 2018-06-29 19:11:35
---
Hexo的NexT主题的一些功能如何开启。如下：站内搜索功能、站点访客量、站点阅读量、站点总字数、站点总阅读时长、RSS订阅、博文字数、博文阅读时长、博文阅读量、优雅的进度条、点击博文内图片放大、Canvas背景、DaoVoice聊天、Gitalk评论  

<!-- more -->
# 站内搜索
NexT支持集成Swiftype、微搜索、Local Search和Algolia。Swiftype、微搜索我没具体了解。  
Algolia界面很优雅，因为这个是第三方的，每次都得`hexo algolia`来上传一下，多了一步操作。而且，Algolia有试用期，试用期过后就降为免费版了，免费版的搜索时不能对文章内容进行搜索。所以，我没用这个。  
我用的是Local Search，这个是每次hexo g的时候都会产生一个`search.xml`的文件，搜索就是从这个文件里搜索，这个比较方便。而且支持文章内容搜索。下面说Local Search怎么配置。  
先打开博客根目录，安装`hexo-generator-searchdb`  
```
npm install hexo-generator-searchdb --save
```
然后去`博客配置文件`中加入下面的  
```yaml
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```
解释一下各个字段含义：摘自[官方](https://github.com/theme-next/hexo-generator-searchdb)
> * path - file path. By default is search.xml . If the file extension is .json, the output format will be JSON. Otherwise XML format file will be exported.
> * field - the search scope you want to search, you can chose:
>   * post (Default) - will only covers all the posts of your blog.
>   * page - will only covers all the pages of your blog.
>   * all - will covers all the posts and pages of your blog.
> * format - the form of the page contents, works with xml mode, options are:
>   * html (Default) - original html string being minified.
>   * raw - markdown text of each posts or pages.
>   * excerpt - only collect excerpt.
>   * more - act as you think.
> * limit - define the maximum number of posts being indexed, always prefer the newest.

limit就是xml中的包含的最大论文篇数。  
去`主题配置文件`中，打开local search。enable设置true  
```yaml
# Local search
# Dependencies: https://github.com/theme-next/hexo-generator-searchdb
local_search:
  enable: true
  # if auto, trigger search by changing input
  # if manual, trigger search by pressing enter key or search button
  trigger: auto
  # show top n results per article, show all results by setting to -1
  top_n_per_article: 1
  # unescape html strings to the readable one
  unescape: false
```

# 站点访客量 站点阅读量
这个用[不蒜子](http://ibruce.info/2015/04/04/busuanzi/)，去`主题配置文件`中打开busuanzi就好。  
```yaml
# Show Views/Visitors of the website/page with busuanzi.
# Get more information on http://ibruce.info/2015/04/04/busuanzi/
busuanzi_count:
  enable: true
  total_visitors: true
  total_visitors_icon: user
  total_views: true
  total_views_icon: eye
  post_views: false
  post_views_icon: eye
```
特别说明一下，不蒜子就是统计每个url访问了多少次。虽然能够统计单片博文的访问量，但是没办法在主页显示某个博文的访问量，只有点进去这个博文，才能显示访问量。  
所以单篇博文访问量我们用leancloud，详见[Hexo NexT 主题 LeanCloud 插件安装教程](/2018/06/27/hexo-leancloud-plugin-installation-tutor/)  

# 站点总字数 站点总阅读时长 博文字数 博文阅读时长
首先安装hexo-symbols-count-time，在博客根目录输入，  
```
npm install hexo-symbols-count-time --save
```
修改博客配置文件，打开`博客配置文件`，添加如下内容。  
```yaml
symbols_count_time:
  symbols: true
  time: true
  total_symbols: true
  total_time: true
```
symbols是博文字数，time是博文阅读时长，total_symbols是站点总字数，total_time是站点总阅读时长。  
检查一下`主题配置文件`:  
```yaml
# Post wordcount display settings
# Dependencies: https://github.com/theme-next/hexo-symbols-count-time
symbols_count_time:
  separated_meta: true
  item_text_post: true
  item_text_total: false
  awl: 4
  wpm: 275
```
awl是平均字长度average word length，默认是4，wpm是阅读速度，word per minute。  

# RSS订阅
打开`主题配置文件`，找到如下：  
```yaml
# Set rss to false to disable feed link.
# Leave rss as empty to use site's feed link, and install hexo-generator-feed: `npm install hexo-generator-feed --save`.
# Set rss to specific value if you have burned your feed already.
rss:
```
如果你自己生成了rss，那么上边就填地址，否则的话留空。  
安装hexo-generator-feed，在博客根目录输入，  
```
npm install hexo-generator-feed --save
```
每次`hexo g`的时候就会生成了atom.xml。  

# 博文阅读量
不蒜子统计每个url访问了多少次。虽然能够统计单篇博文的访问量，但是没办法在主页显示某个博文的访问量，只有点进去这个博文，才能显示访问量。  
所以单篇博文访问量我们用leancloud，详见[Hexo NexT 主题 LeanCloud 插件安装教程](/2018/06/27/hexo-leancloud-plugin-installation-tutor/)  

# 优雅的进度条
NexT主题里面能够使用Pace来设置优雅的进度条，可以看下[Demo](http://github.hubspot.com/pace/docs/welcome/)  
首先需要`git clone`一下，打开`NexT`主题目录下的`source\lib`目录，执行下面操作  
```
git clone https://github.com/theme-next/theme-next-pace pace
```
然后配置一下`主题配置文件`将pace设置成true。  
```yaml
# Progress bar in the top during page loading.
# Dependencies: https://github.com/theme-next/theme-next-pace
pace: true
# Themes list:
#pace-theme-big-counter
#pace-theme-bounce
#pace-theme-barber-shop
#pace-theme-center-atom
#pace-theme-center-circle
#pace-theme-center-radar
#pace-theme-center-simple
#pace-theme-corner-indicator
#pace-theme-fill-left
#pace-theme-flash
#pace-theme-loading-bar
#pace-theme-mac-osx
#pace-theme-minimal
# For example
# pace_theme: pace-theme-center-simple
pace_theme: pace-theme-corner-indicator
```
可以从上面的那些里面选一个喜欢的主题，写在pace_theme那里。  
最近又搞了搞，有第二种方法，更直接，不需要git clone，如下：  
首先得先把上面pace的位置设置成true，然后那个pace_theme位置填写你喜欢的主题。  
然后找到`主题配置文件`中如下位置，这么填cdn。  
```yaml
# Internal version: 1.0.2
# See: https://github.com/HubSpot/pace
# Or use direct links below:
# pace: //cdn.bootcss.com/pace/1.0.2/pace.min.js
# pace_css: //cdn.bootcss.com/pace/1.0.2/themes/blue/pace-theme-flash.min.css
pace: //cdn.bootcss.com/pace/1.0.2/pace.min.js
pace_css: //cdn.bootcss.com/pace/1.0.2/themes/blue/pace-theme-注意替换成一样的主题.min.css
```
注意，你上边填了什么主题，下边也要换成对应的主题。  

# 图片放大
使用fancybox来让博文里面的图片能够点击放大查看。  
首先需要`git clone`一下，打开`NexT`主题目录下的`source\lib`目录  
注意，如果这个目录下有fancybox文件夹，需要先删了才行。然后执行下面操作：  
```
git clone https://github.com/theme-next/theme-next-fancybox3 fancybox
```
然后配置一下`主题配置文件`将fancybox设置成true。  
```yaml
# Fancybox. There is support for old version 2 and new version 3.
# Please, choose only any one variant, do not need to install both.
# For install 2.x: https://github.com/theme-next/theme-next-fancybox
# For install 3.x: https://github.com/theme-next/theme-next-fancybox3
fancybox: true
```
第二种方法：不需要git clone  
首先，先把fancy设置成true。  
然后找到`主题配置文件中`如下位置： 这么填cdn。  
```yaml
# Internal version: 2.1.5
# See: http://fancyapps.com/fancybox/
fancybox: //cdn.bootcss.com/fancybox/3.2.5/jquery.fancybox.min.js
fancybox_css: //cdn.bootcss.com/fancybox/3.2.5/jquery.fancybox.min.css
```

# canvas背景
设置博客背景之后，就能跟我这个背景一样了。  
首先需要`git clone`一下，打开`NexT`主题目录下的`source\lib`目录，执行下面操作：  
```
git clone https://github.com/theme-next/theme-next-canvas-nest canvas-nest
git clone https://github.com/theme-next/theme-next-three three
```
然后配置一下`主题配置文件`下面四个选一个true，其他设置成false   
```yaml
# Canvas-nest
# Dependencies: https://github.com/theme-next/theme-next-canvas-nest
canvas_nest: false

# JavaScript 3D library.
# Dependencies: https://github.com/theme-next/theme-next-three
# three_waves
three_waves: false
# canvas_lines
canvas_lines: true
# canvas_sphere
canvas_sphere: false
```
第二种方法：不需要git clone  
同样四选一填写true。  
然后找到`主题配置文件`中如下位置，这么填cdn。  
```yaml
# Internal version: 1.0.0
# https://github.com/hustcc/canvas-nest.js
canvas_nest: //cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.js

# Internal version: 1.0.0
# See: https://github.com/theme-next/theme-next-three
# three: //cdn.jsdelivr.net/gh/theme-next/theme-next-three@1.0.0/three.min.js
# three_waves: //cdn.jsdelivr.net/gh/theme-next/theme-next-three@1.0.0/three-waves.min.js
# canvas_lines: //cdn.jsdelivr.net/gh/theme-next/theme-next-three@1.0.0/canvas_lines.min.js
# canvas_sphere: //cdn.jsdelivr.net/gh/theme-next/theme-next-three@1.0.0/canvas_sphere.min.js
three: //cdn.jsdelivr.net/gh/theme-next/theme-next-three@1.0.0/three.min.js
three_waves: //cdn.jsdelivr.net/gh/theme-next/theme-next-three@1.0.0/three-waves.min.js
canvas_lines: //cdn.jsdelivr.net/gh/theme-next/theme-next-three@1.0.0/canvas_lines.min.js
canvas_sphere: //cdn.jsdelivr.net/gh/theme-next/theme-next-three@1.0.0/canvas_sphere.min.js
```

# DaoVoice聊天
[Hexo NexT 添加 DaoVoice 在线聊天](/2018/06/30/hexo-next-add-daovoice-contact/)

# Gitalk评论
[Hexo NexT 添加 Gitalk评论功能](/2018/07/04/hexo-next-gitalk-comments-tutor/)