---
title: Ubuntu16.04 Nginx 配置站点学习笔记
tags: [Ubuntu, 服务器, Nginx]
categories: [服务器]
comments: true
mathjax: false
date: 2017-03-30 10:42:15
---
突然想看一看nginx的文件中应该如何写配置信息，于是看了nginx的官方文档。本文讲述nginx的目录结构，以及如何配置静态服务器等。  

<!-- more -->

# nginx 的目录结构
`nginx`的目录结构如下  
```sh
.
├── conf.d
│   └── my.conf
├── fastcgi.conf
├── fastcgi_params
├── koi-utf
├── koi-win
├── mime.types
├── nginx.conf
├── proxy_params
├── scgi_params
├── sites-available
│   ├── default
│   └── openapi.com
├── sites-enabled
│   ├── default -> /etc/nginx/sites-available/default
│   └── openapi.com -> /etc/nginx/sites-available/openapi.com
├── snippets
│   ├── fastcgi-php.conf
│   └── snakeoil.conf
├── uwsgi_params
└── win-utf
```
这个目录结构是用`tree`这个东西搞出来的。感兴趣的同学可以安装一下。个人感觉挺好用的。
```sh
sudo apt-get install tree
tree --help
cd /etc/nginx
tree
```
这样就会出现上面的文件目录了。

# nginx.conf
首先我们查看一下`nginx.conf`的文件内容。
```sh
user www-data;
worker_processes auto;
pid /run/nginx.pid;

events {
	worker_connections 768;
	# multi_accept on;
}

http {

	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;
	# server_tokens off;

	# server_names_hash_bucket_size 64;
	# server_name_in_redirect off;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# SSL Settings
	##

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;

	##
	# Logging Settings
	##

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	##
	# Gzip Settings
	##

	gzip on;
	gzip_disable "msie6";

	# gzip_vary on;
	# gzip_proxied any;
	# gzip_comp_level 6;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

	##
	# Virtual Host Configs
	##

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
}
...
```

# 迷之用户
我们可以看到，上面的`user`是`www-data`，这个是一个用户，没错。linux会创造一些用户，这些用户和普通用户是不一样的。他们主要用来进行一些系统上的的操作。大家可以看一下用户列表。
```sh
cat -n /etc/passwd | grep www-data
```
返回的结果中有一个什么什么`nologin`，这个东西其实就是限制用户登陆的。好了，不多做介绍。

# 多个进程
`nginx`是有一个`master`进程和若干个`worker`进程的。`worker`进程负责各种细致的工作，`master`进程负责管理各种`worker`进程。我们可以通过一下的命令来查看一下`nginx`的进程。
```sh
ps -aux | grep nginx
```
具体的输出如下:
```sh
root      1002  0.0  0.0 124972  1444 ?        Ss   14:45   0:00 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
www-data  1003  0.0  0.0 125348  3212 ?        S    14:45   0:00 nginx: worker process
www-data  1004  0.0  0.0 125348  3212 ?        S    14:45   0:00 nginx: worker process
www-data  1005  0.0  0.0 125348  3212 ?        S    14:45   0:00 nginx: worker process
www-data  1006  0.0  0.0 125348  3212 ?        S    14:45   0:00 nginx: worker process

```

# 启动的命令
启动`nginx`的命令有好多种方式。在这里我介绍一种方式。
```sh
sudo systemctl start nginx 启动nginx
sudo systemctl restart nginx 重启nginx
sudo systemctl stop nginx 关闭nginx
sudo systemctl reload nginx 重新加载nginx的配置文件
sudo systemctl status nginx 查看nginx的状态
```
建议保持一种方式对`nginx`进行操作。也就是说如果总是用`systemctl`来操作`nginx`的状态就一直用`systemctl`来操作，如果还用别的命令的话，免不了会出问题。之前我就出过问题。如果出了问题怎么办呢？也不要太慌张。`kill -9`强制杀死就好了。

# log文件
做一些比较基本的介绍。配置文件中，我们可以很清晰的找到。`access_log` 和 `error_log`这两行，这两行后面的目录就是存错误信息的目录，如果访问的时候出现什么404啊什么的。去这两个文件中查看，能够帮助定位错误信息。

# 注释
`nginx`的配置文件中注释的风格是在一行的开头加#号。这是一句废话。。。

# 虚拟主机配置
我们可以看到`nginx.conf`最下面的两行`include`，这个就是在启动`nginx`的时候，加载的配置文件。在修改配置文件的时候不建议在`nginx.conf`文件中做改动，建议在`conf.d/`目录下新建`.conf`文件，或是在`sites-available/`目录下新建文件，然后在`sites-enabled/`目录下做软连接。

# 配置文件的嵌套格式
最外层是`http` context(上下文)，然后是`server` context， 最后是`location` context
```
http{
    server {
        location {

        }
    }
}
```

# 配置静态服务器
首先打开`nginx`服务器。
```
sudo systemctl start nginx
sudo systemctl enable nginx 设置开启自启动
```
我们在新建`/test/data`目录，与`/test/images`目录。  
然后我们在`/test`目录下新建index.html文件，文件中写`/test`。在`/test/data`目录下新建index.html文件，文件中写`/test/
data`，同样在`/test/images`下的index.html文件中写`/test/images`。  
首先请确保，其他的位置没有定义`location /`。确保`/test/data`与`/test/images`至少有`r-xr-xr-x`权限。  
我们在`conf.d`目录下新建一个`my.conf`文件。然后编辑该文件。  
```
server {
	location / {
		root /test/data;
	}
	location /images/ {
		root /test;
	}
}
```
修改完该文件之后，我们要`reload`一下
```
sudo systemctl reload nginx
```
root代表绑定到路由的文件系统。如果如果不写监听端口的话，默认监听80端口。因此这样的话，在浏览器中访问`http://localhost/`的时候，我们会看到`/test/data`，如果访问`http://localhost/images/`我们会看到`/test/images`。  
如果出现问题的话，那么可以参考`/var/log/nginx/error.log`这个文件的最后一行。就是刚刚访问出现问题的地方，或许会有所帮助。

# 配置代理服务器
代理服务器(proxy server)是指将用户发来的请求，发送给被代理方，然后再将被代理方返回的结果，发给用户。也就是说正常的服务器和用户之间的通信被一个类似中介的服务器分成了2段，用户和原来的服务器不直接通信，而是通过代理服务器进行通信。  
将刚刚的配置文件改成这个样子
```
server {
	listen 8080;
	location / {
		root /test/data;
	}
	location /images/ {
		root /test;
	}
}
```
然后我们`reload`一下nginx
```
sudo systemctl reload nginx
```
这个时候，我们会发现访问`http://localhost/`不能显示界面了。这是因为我们把刚刚的两个服务，定到了8080端口。这个时候我们访问的时候需要在后面加上端口号`http://localhost:8080/`这样的话，就会和刚刚一样了。  
现在我们再次修改配置文件
```
server {
	listen 8080;
	location / {
		root /test/data;
	}
	location /images/ {
		root /test;
	}
}

server {
	location / {
		proxy_pass http://localhost:8080;
	}
}
```
我们再`reload`一下。`proxy_pass`，这个意思是被代理的服务器的地址。  
我们这个时候访问`http://localhost/`这个时候，我们会发现，页面显示`/test/data`。`localhost:8080`被`localhost`代理了。  
如果出现了错误的话，我们就在`/var/log/nginx/error.log`文件中查看具体的错误信息。

# 正则匹配
`location`的url还可以使用正则匹配，～号代表的是正则匹配，而后面的就是正则表达式啦。`\.(gif|jpg|png)$`的意思是，以`.gif`或者`.jpg`或者`.png`结尾的就用这个`location`定位。当然，你需要在`/test/images`目录下有对应的图片。
```
server {
	listen 8080;
	location / {
		root /test/data;
	}
	location /images/ {
		root /test;
	}
}

server {
	location / {
		proxy_pass http://localhost:8080;
	}
	location ~ \.(gif|jpg|png)$ {
		root /test/images;
	}
}
```
```
sudo systemctl reload nginx
```
记得`reload`一下。当你访问`http://localhost/haha.png`的时候，就会发现在`/test/images/haha.png`的图片显示在了网页上。

# FastCGI 代理
用过`php`的大家都知道，`nginx`是没办法直接和`php`连起来的。需要一个`php-fpm`的东西。这个的话，就需要在`nginx`的配置文件中增加`fastcgi_pass`这个东西。和`proxy_pass`类似。在这篇博客中不做叙述。在`Ubuntu16.04 PHP Nginx 配置`这篇博客中详细说明。

# 匹配方式
`nginx`官方文档中说明。
在匹配`location`的时候，首先匹配直接指明的`location`前缀，之后再匹配`正则表达式`。
匹配直接指明的`location`前缀的时候，按能匹配到最长前缀进行匹配。
之后，再进行`正则表达式`匹配，正则表达式匹配中，如果有多个能够匹配上，按出现时间最早的进行匹配。
