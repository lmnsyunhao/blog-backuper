---
title: Ubuntu16.04 Nginx 反向代理 Apache
tags: [Ubuntu, 服务器, Nginx, Apache, 代理]
categories: [服务器]
comments: true
mathjax: false
date: 2017-04-07 20:19:44
---
Nginx 处理静态界面的性能比 Apache 要高很多，Nginx 同样能够抗并发。但是对于 php 等，Nginx 可以通过 FastCGI 转给 php-fpm 处理。在这个过程中，还是可能会出现403等问题。如果能够让 Nginx 反向代理 Apache 就完美了。  

<!-- more -->

# Nginx 的优缺点
* 轻量级，比`apache`占用更少的内存及资源
* 抗并发，`nginx`处理请求是异步非阻塞的，而`apache`则是阻塞型的，在高并发下`nginx`能保持低资源低消耗高性能
* 没`Apache`稳定

# Apache 的优缺点
* `rewrite`，比`nginx`的`rewrite`强大
* 模块化，结构清晰
* 稳定，bug较少

# 思路
让`Nginx`始终监听80端口，做反向代理服务器，Apache退居二线，当遇到`Nginx`处理不了的请求时候，让Apache处理，处理之后，在返回给`Nginx`。帖子以`php`为例。

# 取消 Nginx 的 FastCGI 代理
如果只用`Nginx`来跑`php`项目的同学，一定设置过`FastCGI`代理给`php-fpm`，我们先取消这个代理，这样的话，`Nginx`就不能处理`php`了，能够便于之后的测试。  
在`/etc/nginx/sites-available/default`文件中。
```sh
cd /etc/nginx/sites-available
sudo vim default
```
找到如下的地方。
```sh
# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
#
location ~ \.php$ {
#	include snippets/fastcgi-php.conf;
#
#	# With php7.0-cgi alone:
#	fastcgi_pass 127.0.0.1:9000;
#	# With php7.0-fpm:
#	fastcgi_pass unix:/run/php/php7.0-fpm.sock;
}
```
将上面的东西注释掉。之后让`nginx`的配置文件重新载入一下。
```sh
sudo systemctl reload nginx
cd /var/www/html
sudo vim index.php
```
在`/var/www/html`目录下新建`index.php`文件。文件中输入
```php
<?php echo phpinfo(); ?>
```
这个时候，我们访问`http://localhost/index.php`会发现直接进行下载，没有进行解析。显然，`nginx`已经失去了解析`php`的功能。  
然后我们停止`nginx`。
```sh
sudo systemctl stop nginx
```

# 安装 Apache
如果没有安装`Apache`的同学请安装`apache`
```sh
sudo apt install apache2
```

# 修改 Apache 的 ports.conf
现在我们修改`apache`的配置文件，好让`apache`，退居二线。  
在`/etc/apache2`目录下，找到`ports.conf`文件，这个文件中，我们可以看到，是用来注册监听端口的文件。在`apache2.conf`文件中被包含进去了。
```sh
cd /etc/apache2
sudo vim ports.conf
```
文件中的内容如下。
```sh
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80

<IfModule ssl_module>
	Listen 443
</IfModule>

<IfModule mod_gnutls.c>
	Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
我们可以看到这个文件中最上面的说明。如果更改或者增加了监听端口的话，有也得在`000-default.conf`文件中做更改。  
好，现在我们把`Listen 80`改成`Listen 8080`，也就是说，我们取消监听80端口，改成监听8080端口。然后保存。

# 修改 Apache 的 000-default.conf
我们修改好了`ports.conf`，还要修改`000-default.conf`。
```sh
cd /etc/apache2/sites-available
sudo vim 000-default.conf
```
打开文件之后，我们就可以看到
```sh
<VirtualHost *:80>
	# The ServerName directive sets the request scheme, hostname and port that
	# the server uses to identify itself. This is used when creating
	# redirection URLs. In the context of virtual hosts, the ServerName
	# specifies what hostname must appear in the request's Host: header to
	# match this virtual host. For the default virtual host (this file) this
	# value is not decisive as it is used as a last resort host regardless.
	# However, you must set it for any further virtual host explicitly.
	#ServerName www.example.com

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html

	# Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
	# error, crit, alert, emerg.
	# It is also possible to configure the loglevel for particular
	# modules, e.g.
	#LogLevel info ssl:warn

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	# For most configuration files from conf-available/, which are
	# enabled or disabled at a global level, it is possible to
	# include a line for only one particular virtual host. For example the
	# following line enables the CGI configuration for this host only
	# after it has been globally disabled with "a2disconf".
	#Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
上面的第一行`<VirtualHost *:80>`。是虚拟主机的配置项。`*:80`的意思是所有`ip`的`80`端口。刚刚我们在`ports.conf`中只注册了`8080`端口，那么，我们同样也需要将这个位置的`80`改成`8080`。  
退出保存。
```sh
sudo systemctl reload apache2
```
现在`apache`就退居二线了。也就是说，`80`端口已经不被`apache`占用了。我们可以启动`nginx`了。
```sh
sudo systemctl start nginx
```
这个时候，`nginx`就能够成功启动了。如果不更改`Apache`监听端口的话，`nginx`是无法启动的，因为他们同时监听`80`端口。

# 测试1
我们先来测试一波，现在我们访问`http://localhost/index.php`会发现，直接下载`index.php`。但是我们访问`http://localhost:8080/index.php`会发现，能够成功解析界面。  
因为，前者是通过`nginx`来处理的，而后者是通过`apache`来处理的，所以显示的结果不一样。

# Nginx 做 Apache 的反向代理
现在我们要让`nginx`遇到`php`文件的时候，交给`apache`去处理，然后，返回结果。  
期待已久了吧？  
我们要修改`nginx`的`default`文件。
```sh
cd /etc/nginx/sites-available
sudo vim default
```
我们需要在处理匹配`php`的正则表达式的`location`下加一个代理。  
```sh
# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
#
location ~ \.php$ {
#	include snippets/fastcgi-php.conf;
#
#	# With php7.0-cgi alone:
#	fastcgi_pass 127.0.0.1:9000;
#	# With php7.0-fpm:
#	fastcgi_pass unix:/run/php/php7.0-fpm.sock;
	proxy_pass http://localhost:8080;
}
```
这句话的意思就是，匹配到`php`文件的时候，交给`localhost:8080`去处理。我们都知道`localhost:8080`是`apache`所在的位置。所以，这个反向代理就成功了。
```
sudo systemctl reload nginx
```
我们重新载入一下`nginx`的配置文件。

# 测试2
现在，一切都OK了。我们再测试一下。  
首先访问`http://localhost/index.php`。这个时候，就能够成功的显示界面了。可以看出`php`已经被解析了。  
然后如果，我们关闭`apache`的服务。
```
sudo systemctl stop apache2
```
这个时候，我们再访问，`http://localhost/index.php`。我们会发现，还是解析不了，是因为`apache`关闭的原因了。所以，这个真的是`apache`处理的`php`文件。
当然，我们也可以通过，界面显示内容的server API 来判断是谁解析的`php`文件。  
![phpinfo Server API](https://images.yunhao.space/pica/ubuntu-nginx-apache-reverse-proxy/phpinfo-server-api.png)
记得将`nginx`和`apache`都设置一下开机启动。
