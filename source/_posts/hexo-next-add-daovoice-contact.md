---
title: Hexo NexT 添加 DaoVoice 在线聊天
tags: [Hexo, NexT, DaoVoice]
categories: [Hexo]
comments: true
mathjax: false
date: 2018-06-30 01:11:22
---
今天发现了一个有意思的在线聊天工具，DaoVoice，很有意思，还是免费的，本文讲如何将DaoVoice集成进Hexo博客，以NexT主题为例。其他主题些许不同。  

<!-- more -->

# DaoVoice
一个实时在线沟通的工具。可以及时解答客户的问题。还能够绑定微信。具体请看[一分钟了解DaoVoice](http://blog.daovoice.io/daovocie_manhua/?utm_source=DaoCloud&utm_campaign=39_campaign&utm_medium=daovoice_widget&utm_term=footer_link&utm_content=one_min)  

# 新建应用
首先现在DaoVoice上注册一个账号。打开[DaoCloud首页](https://www.daocloud.io/)。找到DaoVoice服务，然后点击，如下图：  
![DaoVoice服务](/images/hexo-next-add-daovoice-contact/1.png)
然后再下边的界面中选择注册，或登录。  
![注册或登录](/images/hexo-next-add-daovoice-contact/2.png)
如果是新注册的用户，那么注册之后，就会看到下面的这个界面。这个是让你添加一个应用的，填写你的公司名称，你的电话号码，然后点击保存就好了  
![新建应用](/images/hexo-next-add-daovoice-contact/3.png)
如果你是老用户了，找不到上边这个界面了，在下面的位置可以找到，找到之后向上边设置一下。  
![新建应用](/images/hexo-next-add-daovoice-contact/4.png)

# 安装到网站
如下图，点击应用设置，安装到网站，JS，仅匿名用户，然后找到下面两个代码。  
![安装到网站](/images/hexo-next-add-daovoice-contact/5.png)
打开博客的主题目录下的文件`/themes/next/layout/_custom/head.swig`。  
然后粘贴成下面这样：  
```swig
{#
Custom head.
#}
{% if config.daovoice %}
  <script>
  (function(i,s,o,g,r,a,m){i["DaoVoiceObject"]=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;a.charset="utf-8";m.parentNode.insertBefore(a,m)})(window,document,"script",('https:' == document.location.protocol ? 'https:' : 'http:') + "//widget.daovoice.io/widget/{{config.daovoice_app_id}}.js","daovoice")
  daovoice('init', {
      app_id: "{{config.daovoice_app_id}}"
    });
  daovoice('update');
  </script>
{% endif %}
```
注意app_id后边的那个要换一下，然后那个网址后边哪儿也要换成变量。就是上边图片中，那两段代码中被黑条盖住的部分要替换  
那个被黑条盖住的部分就是你的app_id。打开`博客配置文件`然后增加下面内容：  
```yaml
# 实时联系
daovoice: true
daovoice_app_id: 你的app_id
```
将`你的app_id`替换成黑条盖住的部分就行了。然后执行`hexo cl & hexo g & hexo d`，之后ping一下，如下图  
![Ping](/images/hexo-next-add-daovoice-contact/6.png)
如果成功了，现在就已经接入了，网站右下角就应该有一个悬浮钮了。  

# 微信绑定
绑定到微信，可以实时处理消息，回复消息。  
![微信绑定](/images/hexo-next-add-daovoice-contact/7.png)
扫码之后，就能看到下面的绑定成功。  
![绑定成功](/images/hexo-next-add-daovoice-contact/8.png)

# 设置悬浮钮
如果悬浮钮遮挡其他元素了，或者是想设置悬浮钮的颜色，什么的。点击应用设置，聊天设置，如下图：  
![聊天设置](/images/hexo-next-add-daovoice-contact/9.png)
在这里，我们可以设置欢迎语，按钮的颜色，位置什么的。  

# 新消息指派
设置一下新消息指派，点击应用设置，新消息设置，默认指派选择自己。如下图  
![新消息指派](/images/hexo-next-add-daovoice-contact/10.png)

# 费用问题
这个应用是免费的。不过也有付费版。你的网站用户数小于5000的时候，就是免费的。具体的需不需要付费，请看[资费情况](http://guide.daocloud.io/daovoice/%E6%94%B6%E8%B4%B9%E8%A7%84%E5%88%99-9145665.html?_ga=2.184733417.1747920387.1530264739-470864725.1530264739)  

# 用户手册
其他问题，请自行查阅[官方用户手册](http://guide.daocloud.io/daovoice/daovoice-5868545.html)