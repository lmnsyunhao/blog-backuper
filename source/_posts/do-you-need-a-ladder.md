---
title: Do U Need A Ladder ?
tags: [Ladder, Proxifier, VPS, 服务器, 代理, DigitalOcean, SwitchyOmega]
categories: [服务器, Ladder]
comments: true
mathjax: false
date: 2018-06-20 22:09:21
---
授人以鱼不如授人以渔，我给你一个Ladder，不如教你配个Ladder。本文包括配IPv4，IPv6连接VPS，IPv6+Proxifier免校园网流量。然后还有过程中遇到的一些奇怪问题。mark一下。  

<!-- more -->

# 映射
请将本文中所有的“暗影袜子们”替换成如下字眼
![暗影袜子#postpic/pica/do-you-need-a-ladder/socks.png]()

# 安装SS
在服务器端操作。  
我购买的是Digital Ocean的服务器，Ubuntu16.04系统。  
确认当前是root用户，通过pip安装。  
```bash
sudo apt-get update
sudo apt-get install python-pip
pip install --upgrade pip
pip install 暗影袜子们
```
如果你不想用这种方式安装SS，那么可以看`apt方式安装SS`一节。  

# pip无法安装的问题
在上边安装的时候，可能会出现下面的问题，如果出现了，就解决一下，没出现当然就不用管这一节。报错如下：  
```bash
Traceback (most recent call last):
  File "/usr/bin/pip", line 9, in <module>
    from pip import main
ImportError: cannot import name main
```
解决方法是修改`/usr/bin/pip`文件，改成下面的。  
```
from pip import __main__
if __name__ == '__main__':
    sys.exit(__main__._main())
```

# apt方式安装SS
直接在命令行输入下面命令，如果有权限问题，注意加上sudo:  
```bash
sudo apt-get update
sudo apt install 暗影袜子们
```
这样安装与上边有2点区别。
第一，apt安装方式，ssserver的位置在`/usr/bin/ssserver`，而pip安装方法，ssserver在`/usr/local/bin/ssserver`  
第二，apt安装方式，ssserver没法加`-d`参数。不过这不要紧，用`systemd`设置开机自动时候不需要-d参数。  

# 配置IPv4连接
在服务器端操作。  
创建配置文件  
```bash
vim /etc/暗影袜子们.json
```
json文件中填写，如下  
```json
{
    "server":"服务器ip",
    "server_port":8388,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"自己设置的密码",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```
字段名称 | 各个字段的含义
---|---
Name | 解释说明
server | 监听的服务器地址
server_port | 监听的服务器端口
local_address | 本地监听的地址
local_port | 本地坚挺的端口
password | 登陆用的密码
timeout | 按秒计算
method | 加密方法 默认是"aes-256-cfb"
fast_open | 快速打开，TCP_FASTOPEN, 填写true或者false
workers | number of workers, available on Unix/Linux
大家在设置的时候最好不要弄错了，就想例子中的那样。一个空格最好都不要错，否则容易出莫名其妙的问题。  

# 配置IPv6连接
在服务器端操作  
如果你的服务器有ipv6的公网地址，那么你可以通过ipv6来连接你的VPS。那么配置文件中就如下填写：  
```json
{
    "server":"::",
    "server_port":8388,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"自己设置的密码",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```
就是server字段填::，这么填以后，你可以使用ipv6连接，也可以使用ipv4连接，亲测。  

# 启动ssserver服务
在服务器端操作。  
```bash
ssserver -c /etc/暗影袜子们.json
```
输入命令就能够开启ssserver服务了  
上面的命令是工作在前台的进程。如果想把ssserver放到后台工作。那么用下面的命令启动和停止。  
```bash
ssserver -c /etc/暗影袜子们.json -d start
ssserver -c /etc/暗影袜子们.json -d stop
```
如果你发现你的ssserver不支持-d命令的话，那么就是你安装暗影袜子们时候有问题。重装吧就。  

# 客户端配置
在客户端操作  
windows的客户端点选“添加服务器”，填写“地址”、“端口”、“加密方法”和“密码”即可。其中“端口”、“加密方法”和“密码”与前面设置的服务器配置相同。然后右键右下键的小飞机，确保服务器那块儿勾选的是自己刚刚配好的服务器  
如果服务器支持IPv4和IPv6双栈，那么客户端实际可以配置两个服务器参数，其仅有“地址”不相同。对于IPv4，填写服务器的IPv4地址；对于IPv6，填写服务器的IPv6地址（末尾不用加/64，也不用写[]）  
对于Ubuntu的配置，请看本文`Ubuntu16.04 SS客户端 SwitchyOmega配置`一节。

# 测试连通性
为了保险起见，客户端选择IPv4连接服务器。  
解释一下`系统代理模式`中的`全局模式`和`PAC模式`，PAC就是一个规则，定义了有哪些网站在国内，有哪些网站在国外。如果选择了全局模式，不管访问国内还是国外的网站，都会走VPS代理；而PAC模式，只有在国外的走代理，国内的不走。但是PAC规则更新慢的话，有时候还得调成全局模式。全局模式访问国内网站，比PAC访问国内网站要慢一点，因为走了代理。  
客户端设置好之后，看是不是能够正常的登上梯子（客户端登陆`youtube.com`）。如果正常，那么就成功了。  
设置客户端中服务器为IPv6地址的，同样访问上述网站，若都能很快正常打开，则成功。  
可以测试一下支不支持IPv6，访问网站[IPv6测试](https://test-ipv6.com/)

# ssserver配置systemd开机启动
在服务器端操作  
systemd配置文件一般存在于`/lib/systemd/system/`和`/etc/systemd/system/`这两个文件夹下，我们需要在`/lib/systemd/system`下创建配置文件。如下：如果创建过程中有权限问题，自觉用`sudo`  
```bash
cd /lib/systemd/system
vim ssserver.service
```
文件中写如下内容  
```
# /lib/systemd/system/ssserver.service

[Unit]
Description=ssserver
After=network.target

[Service]
ExecStart=/usr/local/bin/ssserver -c /etc/暗影袜子们.json
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
创建了文件之后，需要重新加载配置一下。  
```bash
systemctl daemon-reload
```
确保ssserver处于关闭状态，然后试试把刚才创建的ssserver.service启动  
```bash
systemctl start ssserver.service
```
如果没报任何信息的话，查看一下状态。  
```bash
systemctl status ssserver.service
```
如果显示running的话，那么就是配置成功了，然后设置一下开机启动。  
如果没有显示running，启动失败了的话，看下你们的`暗影袜子们.json`这个文件内容有没有写错，最好空格什么的不要少，也不要多。然后看下ssserver这个东西是不是在`/usr/local/bin/ssserver`这。用命令`which ssserver`看看这个是不是对的，有可能在`/usr/bin/ssserver`路径。然后把上边的那个文件`ssserver.service`中对应位置改成`/usr/bin/ssserver`。这样应该就能成了。  
```bash
systemctl enable ssserver.service
```
到这里，已经达到目的了，下面是一些有意思的操作，感兴趣的可以看一下。不感兴趣的不看也ok。  

# 配置全局代理+Proxifier
> Proxifier这个软件可以修改电脑上应用程序的代理，对于某些程序本身没有提供配置代理的功能时候，用这个方法就能够配置应用程序的代理了。  

配置这个的目的是让VPS和本地间走ipv6流量，然后系统代理模式选择全局代理，也就是说让所有的网络访问都走VPS。这样的话，也就是说所有的网络都走ipv6。这种情况下会有一些问题。有的软件不支持用前面这种形式访问网络。这个时候我们就需要一个叫做Proxifier的软件来给这些软件搞一下，让他们也能正常了。因为都是ipv6，所以就免流量了，而且不用登录校园网，这就是我们要的效果。  
首先，VPS那边得是ipv6能够访问的，就是配好了上边说的ipv6连接，其次，本地也需要有ipv6的地址。二者缺一不可。然后。配置一下Proxifier。配置方法如下：  
打开Proxifier，然后Profile，Proxy Servers，点击右侧Add。  
![1#postpic/pica/do-you-need-a-ladder/1.png]()
如下这样添加。点击确定。  
![2#postpic/pica/do-you-need-a-ladder/2.png]()
添加之后如下图：  
![3#postpic/pica/do-you-need-a-ladder/3.png]()
打开，Profile，Proxification Rules。  
![4#postpic/pica/do-you-need-a-ladder/4.png]()
如下设置  
![5#postpic/pica/do-you-need-a-ladder/5.png]()
点击Profile，Name Resolution：  
![6#postpic/pica/do-you-need-a-ladder/6.png]()
如下设置：  
![7#postpic/pica/do-you-need-a-ladder/7.png]()
这个时候，注销校园网络登陆。然后看看行不行？如果qq能正常使用，说明大功告成了。下次再使用的时候，ipv6连接+Proxifier都打开，就能够免流量了。  
我用的是有线连接的校园网（没登录），没测试无线能不能用，不过如果无线连接的时候，本地有ipv6地址的话，应该就能用。  
  
这时候会出问题，比如使用localhost:4000调试hexo时候，会无法访问。感觉是dns问题，因为现在是ipv6，可能会解析到ipv6的地址，然后proxifier会报错说，没法解决ipv4和ipv6混合使用的问题。这个时候不用localhost:4000，访问127.0.0.1:4000就能调试hexo了。  

# Google BBR 加速
说是能给网络加速，实际效果感觉并不明显，还是写一下吧。  
root登陆服务器，输入下面命令。  
```bash
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
chmod +x bbr.sh
./bbr.sh
```
安装完事儿之后会让重启服务器，然后就重启吧。  
输入下面命令。验证是否安装最新内核并开启了BBR。  
```bash
uname -r
```
查看一下；  
```bash
sysctl net.ipv4.tcp_available_congestion_control
```
上面结果中，看看等号后边带不带bbr，带就行。  
```bash
sysctl net.ipv4.tcp_congestion_control
```
上面结果应该等于bbr。  
```
sysctl net.core.default_qdisc
```
上面结果应该等于fq。  
```
lsmod | grep bbr
```
上面结果中，看看有没有tcp_bbr，说明已经启动。  

# 过了两天
我保证我这两天，没动服务器，也没开电脑。然后就出现了一个状况。  
ipv6可以连上服务器，但是ipv4死活连不上服务器。经过一番排查，我感觉是服务器那边的问题。然后，于此同时我用ssh竟然没法连接DigitalOcean的服务器了。闹心。  
我这个DigitalOcean最开始新建Droplet的时候，没有选ssh。不过，最开始的时候是能够用ssh连的，然后过了两天就连接超时，只能通过网页端的console连接。  
我查了不少教程又看了官方文档。并不会解决，然后我将droplet的系统重装了。然后依旧是这个问题。  
然后，我就把这个droplet删了。新建了一个droplet，新建时候上传了ssh公钥，并选择了对应的公钥。然后，当然ssh的连接超时的问题就解决了。  
然后照着我上边说的又走了一遍，ipv4连不上的问题也解决了。  

# Ubuntu16.04 SS客户端 浏览器 SwitchyOmega配置
这里说下Ubuntu配置，Ubuntu的配置相对较麻烦。  
首先需要在客户端安装暗影袜子们。安装方式与上面相似。  
```bash
sudo apt-get update
sudo apt-get install python-pip
pip install --upgrade pip
pip install 暗影袜子们
```
当然，如果出现pip无法安装的问题，请看上面的那节，同样解决一下。  
安完之后，在`/etc`目录下新建一个`暗影袜子们.json`的文件。文件中如下填写：  
```json
{
    "server":"上面配好的服务器的ip",
    "server_port":8388,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"自己设置的密码",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open":false
}
```
其实这个文件和上面的那个配置文件好像一样。然后，启动下看看能否成功启动`sslocal -c /etc/暗影袜子们.json`，如果能够正常启动，那么客户端这边儿就和服务器连上了。但是打开chrome，还是没法出去，比如油管网。这个时候，我们还需要配一下浏览器的代理。  
我以chrome浏览器为例。讲解一下配置。有个东西叫做，[SwitchyOmega](https://www.switchyomega.com/download/)，点击链接下载，如下  
![SwitchyOmega#postpic/pica/do-you-need-a-ladder/8.png]()
下载了之后应该是一个以crx后缀的文件。在浏览器的地址栏输入：`chrome://extensions`，将刚才下载的crx文件拖动到这里，会提示安装。如下  
![安装#postpic/pica/do-you-need-a-ladder/9.png]()
然后，等待安装成功会有提示，打开SwitchyOmega，配置一下代理。点击左侧`新建情景模式`，弹出对话框。`名称`随便起，`类型`选代理服务器，然后点击`创建`，如下图  
![新建情景模式#postpic/pica/do-you-need-a-ladder/10.png]()
然后点击新建的情景模式，`代理协议`选择SOCKS5，`代理服务器`填写127.0.0.1，`代理端口`填写1080。然后点击`应用选项`  
![设置情景模式#postpic/pica/do-you-need-a-ladder/11.png]()
然后再点击左侧的`auto switch`然后，勾选规则列表规则，后边选SS，就是你刚才配的情景模式，默认情景模式选择直接连接，规则列表格式选择AutoProxy规则列表地址填写`https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt`，然后点击立即更新情景模式。然后点击应用选项。如下图：  
![设置情景模式#postpic/pica/do-you-need-a-ladder/12.png]()
这个时候再切换到`auto switch`就好了。访问一下`youtube.com`，应该就能成功了。  
![auto switch#postpic/pica/do-you-need-a-ladder/13.png]()
之后再配置一下sslocal的开机子启动，请见`sslocal配置systemd开机启动`一节。  
PS:Windows上的chrome浏览器同样也可以加载这个插件，来增加规则，对于外边的网站走代理，里面的网站不走代理。配置过程相似。  

# sslocal配置systemd开机启动
在客户端操作  
systemd配置文件一般存在于`/lib/systemd/system/`和`/etc/systemd/system/`这两个文件夹下，我们需要在`/etc/systemd/system`下创建配置文件。如下：如果创建过程中有权限问题，自觉用`sudo`  
```bash
cd /etc/systemd/system
vim sslocal.service
```
文件中写如下内容  
```
# /lib/systemd/system/sslocal.service

[Unit]
Description=sslocal
After=network.target

[Service]
ExecStart=/usr/local/bin/sslocal -c /etc/暗影袜子们.json
ExecStop=/bin/kill -s TERM $MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
```
创建了文件之后，需要重新加载配置一下。  
```bash
systemctl daemon-reload
```
确保sslocal现在处于关闭状态，然后试试把刚才创建的sslocal.service启动  
```bash
systemctl start sslocal.service
```
如果没报任何信息的话，查看一下状态。  
```bash
systemctl status sslocal.service
```
如果显示running的话，那么就是配置成功了，然后设置一下开机启动  
```bash
systemctl enable sslocal.service
```

# 写在几个月后
Digital Ocean把我的账号封了。于是，我换了一个VPS供应商，Vultr。配置方式都一样。  