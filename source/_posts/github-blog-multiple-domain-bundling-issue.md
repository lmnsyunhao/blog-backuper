---
title: GitHub Hexo 博客 GitHub Pages 个人站点 多域名绑定问题
tags: [GitHub, GitHub Pages, 域名, GoDaddy, 腾讯云, DNS, Hexo, Nginx, 服务器]
categories: [服务器, 域名]
comments: true
mathjax: false
date: 2018-07-01 23:19:54
---
我的个人站点托管在GitHub上，想要多个域名都能够正常访问站点，比如，yunhao.space可以访问站点，blog.yunhao.space也可以访问站点。记录一次折腾。因为设置过程中，会有缓存，所以吧有的时候，不一定能够是真的能访问，所以得再三确认。  

<!-- more -->

# GitHub Pages
GitHub Pages提供了将项目设置成站点的功能。可以通过特定的网址访问。  
GitHub Pages站点有两类，第一类是用户组织站点，第二类是项目站点。第一类站点的仓库名字必须和用户名一样，第二类站点的仓库名字可以随便。访问第一类站点网址是`username.github.io`，访问第二类站点网址是`username.github.io/repository_name`。  
官方说，用户组织站点，每个账户只能有一个，而项目站点每个项目无限。详见[官方文档](https://help.github.com/articles/troubleshooting-custom-domains/#reached-limit-for-user-or-organization-pages-site)  
个人站点就是用户站点。  

# 多域名绑定的官方解释
[Multiple domains in CNAME file](https://help.github.com/articles/troubleshooting-custom-domains/#multiple-domains-in-cname-file)，这是官方解释：  
> A CNAME file can contain only one domain. To point multiple domains to the same Page, set up redirects through your DNS provider.  

官方说github上的CNAME文件中只能有一个域名。我们就要另寻他法。  

# 301重定向
于是我们想到了301重定向。为什么一定要重定向呢？  
重定向可以让我们浏览器的地址栏修改url。如果只是在dns做CNAME解析的话，是没办法让地址栏修改url的。于是我们就会看到GitHub的404。  
有人说了，我们可以自己定义一个404.html，然后放在个人站点的根目录下，然后404.html中用js的window.location.href重定向不就好了？  
__这会失败__，因为这个404的错误，是github找不到你的个人站点的根目录，报的404，就是说github不知道你想访问哪个项目。  
而在个人站点根目录下放404.html只能解决在这个目录下找不到某个文件什么的问题，显示404.html的内容。  
所以，上边那种做法会失败。  

# 服务器重定向
这里以Nginx服务器做例子。如果你想将域名blog.yunhao.space 301重定向到 yunhao.space的话，那么如下配置nginx的服务器：  
我的服务器是Ubuntu16.04，nginx是apt-get安装的。  
```
cd /etc/nginx/sites-available
vim redirection.conf
```
新建redirection.conf之后，在文件中按照下面这样写入：  
```
server {
        server_name blog.yunhao.space;
        rewrite ^(.*)$ http://yunhao.space$1 permanent;
}
```
保存退出后，重启一下nginx服务  
```
cd /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/redirection.conf redirection
systemctl stop nginx.service
systemctl start nginx.service
```
记得dns添加A解析，`blog.yunhao.space`解析到服务器IP地址，如果不会，参考[域名解析配置教程](/2018/07/01/domain-name-parsing-setting-tutor/)  
然后等一会儿，测试一下，就成功了。这个方法可以说是最直接的，最正常的，我就是采用的这种方法。  
记得设置nginx开机自启动，否则重启之后，就不能提供服务了。  

# GitHub多项目重定向
这个方法取自一个GitHub Pages的特性。  
* 项目站点可以有自己的域名，不一定要用`个人站点域名/项目名称`来访问。  

解释一下，比如个人站点域名是`yunhao.space`，github上有个项目站点，项目名字是test，那么在配置好GitHub Pages的情况下，可以通过`yunhao.space/test`来访问。这个是官方文档中说明的。  
其实GitHub Pages的项目站点域名绑定比官方说的更强大，也就是说虽然你的个人站点绑定域名是`yunhao.space`，项目站点可以绑定`test.yunhao.space`，甚至是`test.yunhao.life`，顶级域名都可以不一样。  
想要使用上边特性其实很简单，需要注意两点，第一就是dns解析和github仓库中CNAME文件相对应。第二就是github仓库开启了GitHub Pages服务。  
下面我继续说这个通过多个项目站点进行重定向的方法。这个例子就正好能够反映上边这个GitHub Pages的特性。  
比如现在我的`yunhao.space`已经绑定了个人站点，我想让`test.yunhao.life`这个域名也指向我的个人站点。  
首先，dns添加CNAME解析，`test.yunhao.life`解析到`lmnsyunhao.github.io`如果不会，参考[域名解析配置教程](/2018/07/01/domain-name-parsing-setting-tutor/)  
然后，在github上新建一个仓库，名字比如说叫test。然后clone下来。  
然后，test仓库里放一个CNAME文件，文件中写`test.yunhao.life`。  
然后，test仓库里放404.html的文件。文件中用js重定向。如下：注意domain变量内设置自己的想要重定向到的域名  
```html
<script>
var domain = "yunhao.space";
var src = window.location.href;
var prtc = src.substring(0, src.indexOf(':'));
var target = src.substring(src.indexOf('/', src.indexOf(':') + 3));
window.location.href = prtc + "://" + domain + target;
</script>
```
然后，将新增文件add, commit并push到github上master分支。  
然后，开启test项目的GitHub Pages服务。如下：点击settings，然后往下滚，到GitHub Pages，然后选master，并保存。  
![开启GitHub Pages服务](https://images.yunhao.space/pica/github-blog-multiple-domain-bundling-issue/2.png)
![开启GitHub Pages服务](https://images.yunhao.space/pica/github-blog-multiple-domain-bundling-issue/3.png)
等会儿，然后测试一下，应该就能定向了。  

# 域名注册商重定向
有点域名注册商提供了重定向服务，比如GoDaddy，腾讯云。腾讯云的重定向，如下图：  
![腾讯云重定向](https://images.yunhao.space/pica/github-blog-multiple-domain-bundling-issue/1.png)
显性URL类型就是301重定向服务，不过大家也从上边的弹窗看到了，有些限制。所以，我在GoDaddy上边找到了重定向服务。  
因为我的域名就是在GoDaddy上边买的。所以我就直接设置了。我看了看，GoDaddy上边好像不能接管别的域名注册商处注册的域名。如果你是GoDaddy买的域名，那么恭喜你了。这个方法，你可以看一看，否则的话你就得看看自己的域名注册商是否提供重定向服务了。  
首先登陆GoDaddy，然后点击我的产品。  
![我的产品](https://images.yunhao.space/pica/github-blog-multiple-domain-bundling-issue/4.png)
比如，我们要将`yunhao.life`重定向到`yunhao.space`，点击DNS  
![DNS](https://images.yunhao.space/pica/github-blog-multiple-domain-bundling-issue/5.png)
如果域名服务不在GoDaddy托管的话，那么首先点击下面的域名服务器，更改回默认的来，然后等更新好了，再继续。如果没出现这种情况，继续往下看：  
![修改托管DNS服务](https://images.yunhao.space/pica/github-blog-multiple-domain-bundling-issue/6.png)
找到转址这一块儿。上边域名转址是处理形如`yunhao.life`转到`yunhao.space`的，而子域名转址是`blog.yunhao.life`转到`yunhao.space`的，区别是二级域名是否为空。  
![转址](https://images.yunhao.space/pica/github-blog-multiple-domain-bundling-issue/7.png)
然后下面是域名转址的修改方式：即从`yunhao.life`转到`yunhao.space`  
![域名转址](https://images.yunhao.space/pica/github-blog-multiple-domain-bundling-issue/8.png)
如果想设置子域名转址，比如`blog.yunhao.life`转到`yunhao.space`，如下：  
![域名转址](https://images.yunhao.space/pica/github-blog-multiple-domain-bundling-issue/9.png)
现在就设置完了，估计得等一会儿，才能生效。我等了半个多小时。这个域名注册商提供的转址服务不一定快。比如GoDaddy这个的确能转。但是速度有点儿慢。而且好像对于`yunhao.life/hello.html`转到`yunhao.space/hello.html`类似情况不支持。  