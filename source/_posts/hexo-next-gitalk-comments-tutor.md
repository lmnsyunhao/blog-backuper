---
title: Hexo NexT 添加 Gitalk评论功能
tags: [Hexo, NexT, Gitalk]
categories: [Hexo]
comments: true
mathjax: false
date: 2018-07-04 11:30:52
---
多说关闭之后，其实还有好多评论，友言、畅言、来比力、disqus、Valine、HyperComments、Gitment。这些我都看过，都不太喜欢。来比力是韩国出的，HyperComments俄罗斯出的，畅言好像得备案才行，Valine是基于LeanCloud的而且匿名的话太丑了，Gitment移动端适配不好，等等问题。最终我找到了Gitalk这个插件。本文介绍如何给Hexo添加Gitalk评论功能，以NexT主题为例。  

<!-- more -->

# Gitalk
Gitalk和Gitment一样，是利用GitHub的Issue功能。移动端适配比Gitment好。目前Gitalk还没有被默认集成进NexT主题里。所以需要自己配置。  

# 新建OAuth应用
登陆GitHub，然后点击头像，然后Settings，Developer settings。如下：  
![Developer settings](/images/hexo-next-gitalk-comments-tutor/1.png)
然后，点击OAuth Apps，New OAuth App，如下：  
![新建OAuth应用](/images/hexo-next-gitalk-comments-tutor/2.png)
填写下面红框的内容。Application Name随便起，Homepage URL是你需要用这个应用的地址，就是博客的地址，callback URL是你的回调地址，一般填你的博客地址。如果你在调试的话，可以填localhost  
![填写内容](/images/hexo-next-gitalk-comments-tutor/3.png)
然后，你会跳到这个界面。client id和secret这两个有用。记得不要给别人  
![ID和Secret](/images/hexo-next-gitalk-comments-tutor/4.png)

# 添加代码
在主题中添加代码，我是强迫症，秉着对NexT主题代码最小的破坏。而且最好在NexT主题中该加代码的地方加。  
找到NexT的主题目录，然后进入这个路径`/next/layout/_custom/`下，应该有head.swig，header.swig，sidebar.swig这三个文件。  
这三个文件应该就是自定义布局的位置。然后，在sidebar.swig里面添加如下代码：  
```swig
{% if page.comments and config.gitalk.enable %}
  <link rel="stylesheet" href="{{ config.gitalk.gitalk_css }}">
  <script src="{{ config.gitalk.gitalk_js }}"></script>
  <script src="{{ config.gitalk.md5 }}"></script>
  <script>
      var gitalk = new Gitalk({
        clientID: '{{ config.gitalk.clientID }}',
        clientSecret: '{{ config.gitalk.clientSecret }}',
        repo: '{{ config.gitalk.repo }}',
        owner: '{{ config.gitalk.owner }}',
        admin: '{{ config.gitalk.admin }}',
        id: md5(location.pathname),
        distractionFreeMode: 'true'
      });
      var div = document.createElement('div');
      div.setAttribute("id", "gitalk_comments");
      div.setAttribute("class", "post-nav");
      var bro = document.getElementById('posts').getElementsByTagName('article');
      bro = bro[0].getElementsByClassName('post-block');
      bro = bro[0].getElementsByTagName('footer');
      bro = bro[0];
      bro.appendChild(div);
      gitalk.render('gitalk_comments');
  </script>
{% endif %}
```
注意，15行至第22行，是给评论区找一个div，然后23行将div的id传过去。  

# 修改站点配置文件
找到`站点配置文件`，然后添加以下内容。owner是你的github登录名，repo是博客在github上边的仓库名，admin写自己的github登录名，clientID和clientSecret填写上边得到的那两个，下面的三个cdn不要修改  
```yaml
# Gitalk评论
gitalk:
  enable: true
  owner: 
  repo: 
  admin: 
  clientID: 
  clientSecret: 
  gitalk_css: //cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.css
  gitalk_js: //cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.min.js
  md5: //cdn.bootcss.com/blueimp-md5/1.1.0/js/md5.min.js
```

# 初始化
每次`hexo d`之后，都要去博客里面看一下，登陆自己的github，然后这个时候会自动初始化评论区。必须初始化一下。这个比gitment的点击才能初始化功能稍微方便点。只需要进入那个界面就可以了。  