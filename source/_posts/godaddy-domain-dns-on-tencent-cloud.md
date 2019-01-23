---
title: GoDaddy 域名 托管于腾讯云解析
tags: [GoDaddy, 域名, 腾讯云, DNS]
categories: [服务器, 域名]
comments: true
mathjax: false
date: 2018-06-18 22:57:39
---
GoDaddy上面买了域名，看大家都说托管到DNSPod上边快。于是我就写了这样一篇博客，DNSPod就是腾讯云。几乎一样。嗯。  

<!-- more -->

# 腾讯云获取域名服务器
注册并登陆了腾讯云之后，找到控制台。  
![控制台#postpic/pica/godaddy-domain-dns-on-tencent-cloud/tencent-control-panel.png]()
然后找到域名服务，云解析。  
![云解析#postpic/pica/godaddy-domain-dns-on-tencent-cloud/service.png]()
然后点击添加解析。将你要解析的域名加进来。  
![添加解析#postpic/pica/godaddy-domain-dns-on-tencent-cloud/add-parsing.png]()
添加域名就是你购买的域名，项目就默认就行。  
![添加解析#postpic/pica/godaddy-domain-dns-on-tencent-cloud/parsing-info.png]()
然后能看到添加的域名，点击后边的解析。  
![解析#postpic/pica/godaddy-domain-dns-on-tencent-cloud/parsing.png]()
然后应该会弹框出来，提示你去域名注册商处修改域名服务器。如下图，如果没有弹框的话，请继续看  
![弹框#postpic/pica/godaddy-domain-dns-on-tencent-cloud/1.png]()
如果没弹框，我们可以看到上边的域名服务器的地址。并且它提示我们去到域名注册商处更改地址。  
![DNS地址#postpic/pica/godaddy-domain-dns-on-tencent-cloud/dns-address.png]()

# GoDaddy自定义域名服务器
首先是去[GoDaddy](https://sg.godaddy.com/zh/)登陆账户（登陆密码还得要求有大写英文字母，小写英文字母，还有数字）。然后找到我的产品。  
![我的产品#postpic/pica/godaddy-domain-dns-on-tencent-cloud/godaddy-production.png]()
然后是找到需要托管的域名的DNS。  
![DNS#postpic/pica/godaddy-domain-dns-on-tencent-cloud/godaddy-dns.png]()
点击了DNS之后，我们可以看到，记录和域名服务器俩栏。我们需要把下面的域名服务器改成自定义的，然后将腾讯云上边的那个域名服务器的地址填上。刷新一下界面，我们就能够看到记录的位置显示信息，表示已经脱离了Godaddy的管理了。  
![自定义域名服务器#postpic/pica/godaddy-domain-dns-on-tencent-cloud/customized-dns.png]()
这个时候我们就只需要在腾讯云上添加解析的记录就ok了。  

# 腾讯云添加记录
添加记录的过程中，A类型是将域名指向IP，CNAME类型是将域名指向另一个域名。  
![添加记录#postpic/pica/godaddy-domain-dns-on-tencent-cloud/add-record.png]()
比如`主机记录`填写`@`，`记录类型`写`CNAME`，线路类型默认，`记录值`写`lmnsyunhao.github.io`，TTL600。这个就是表示在访问yunhao.space的时候就会解析到lmnsyunhao.github.io这个域名。相当于直接访问lmnsyunhao.github.io这个域名。  
比如`主机记录`填写`www`，`记录类型`写`A`，线路类型默认，`记录值`写`8.8.8.8`，TTL600。这个表示在访问`www.yunhao.space`的时候会解析到8.8.8.8。相当于直接访问8.8.8.8这个IP。  
`@`主机记录表示三级域名处为空。如果记录类型选`CNAME`那么记录值只能写域名才有效，记录类型选A，记录值只能写IP地址才有效。  
详细添加记录，请参考[域名解析配置教程](/2018/07/01/domain-name-parsing-setting-tutor/)  