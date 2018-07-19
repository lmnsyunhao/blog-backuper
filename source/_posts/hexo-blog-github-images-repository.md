---
title: Hexo博客 GitHub仓库图床
tags: [Hexo, GitHub]
categories: [Hexo]
comments: true
mathjax: false
date: 2018-07-18 19:06:52
---
随着博客的写作，其实我们比较担心的问题就是GitHub对于单个项目来说的大小是有一定限制的。而写博客中有免不了放图片。图片这种东西真是非常的占地方。网上都说用七牛云、微博、或者是什么座图床。我看了看，好像是挺麻烦的。又得注册账号，又得导出外链的。我发现github有一个图片预览的功能。于是我想到了用github这个图片预览的功能做一个图床。创造一个仓库专门存图片，如果这个仓库存满了，再创建一个仓库就好了。每个仓库能存1G的东西，所以觉得还不错。下面说一下我的思路。  

<!-- more -->

# 原项目结构
原来的项目结构是在`博客的项目目录`下的source文件夹下新建一个叫images的文件夹，文件夹下存图片。即`博客目录/source/images`  
可能有好多人最开始都跟我差不多的结构。我就是从这个结构开始改的。  

# 思路
这个就是GitHub图片预览的url`https://raw.githubusercontent.com/lmnsyunhao/blog-pica/master/acm-cf-963b-dfs/normal.png`，考虑到这个url太长，而且考虑到如果github之后更改这个url，那么很有可能所有的博文的图片链接都要修改。  
我有了这样一个思路，我的图片链接先请求到我自己的服务器上，然后服务器重写url，301重定向到github。这样如果某一天github这个图片预览的url格式变了的话，直接改服务器那边的重写规则就好了。甚至如果以后不支持图片预览的话，也能再做打算。不用修改博文。  
当然，如果你们懒得用服务器重定向了的话，直接把博文中的图片改成类似上边的那种url也行。  
OK，开搞。  

# 建立图片仓库
GitHub新建仓库`blog-pica`，如果这个仓库满了，我的下一个仓库名字就是`blog-picb`，我是这样定义的。  
然后我在本地的博客项目下新建images文件夹，即`博客目录/images`。因为如果放到source文件夹下，在`hexo g`时候会在`博客目录/public`文件夹下生成对应的images文件夹，这样的话`hexo d`的时候还是会将图片上传。即，保证了图片不会在博客仓库出现  
然后我修改`博客目录/.gitignore`文件，添加一行，内容是`/images/`，这样的话，就会将此文件夹忽略掉。从而保证图片只在图床仓库出现，不会在备份仓库出现。  
然后将之前的那些图片拷贝到`博客目录/images`文件夹下，然后执行下面操作：  
```
git init
git add .
git commit -m "images upload"
git remote add origin git@github.com:lmnsyunhao/blog-pica.git
git push -u origin master
```
`博客目录/images`这个位置只是我放图片仓库的位置，或者说你们想放哪儿放哪儿，不一定要放在博客项目内。因为现在这个图片仓库和博客项目已经没关系了。  
现在图片仓库已经建立好了，而且图片也已经上传到GitHub上了。  

# 添加DNS解析
如果你没有域名的话，那么不用添加解析。继续看下一节。  
我是在腾讯云托管的我的域名解析。所以去腾讯云添加一个解析记录。A类型记录，images.yunhao.space解析到自己的服务器IP地址。  
如果不会添加解析，[域名解析配置教程](/2018/07/01/domain-name-parsing-setting-tutor/)  

# 修改博文图片地址
这个比较简单，用Notepad++或者是sublime什么的，文件夹内搜索，比如搜`](/images/`这个，然后全部替换一下。具体怎么搜索，我就不管了。  
反正就是做如下替换。将`[图](/images/folder/1.png)`替换成`[图](http://images.yunhao.space/pica/folder/1.png`  
如果没有域名的话，那么那个images.yunhao.space就要替换成你的服务器ip地址了。  

# 配置nginx重写
我的服务器是Ubuntu16.04 Nginx。去自己的服务器上。进行如下操作：  
```
cd /etc/nginx/sites-available
vim 301.yunhao.space.images.conf
```
然后输入如下内容：  
```
server {
	server_name images.yunhao.space;
    location ~ \.png$ {
        rewrite ^/(pic[a-z])/(.*)$ http://raw.githubusercontent.com/lmnsyunhao/blog-$1/master/$2 permanent;
    }
}
```
保存退出vim，然后执行下面命令：  
```
cd ../sites-enabled
ln -s /etc/nginx/sites-available/301.yunhao.space.images.conf images-redirection
systemctl restart nginx.service
```
这个时候应该就ok了。然后每次的时候，需要提前把图片push到仓库中才行。  

# 仓库满了
如果某一天仓库满了的话，那么就在github上新建一个仓库`blog-picb`，然后将那个images文件夹删除，因为这个仓库满了，所以就把本地的删了，反正远程的也不收影响。然后再在同样的位置新建一个images的仓库，连上`blog-picb`这个新的仓库，然后继续往里面存图片就好了。  
当然之后写作的时候博文中图片的url就要换成blog-picb了。  