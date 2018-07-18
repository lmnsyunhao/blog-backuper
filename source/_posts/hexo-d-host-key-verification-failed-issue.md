---
title: Hexo d 时遇到 Host Key Verification Failed 问题
tags: [Hexo, GitHub, Git]
categories: [Hexo]
comments: true
mathjax: false
date: 2018-06-24 00:09:57
---
Verification Failed，我记得之前就出现过这种问题，当时忘记了怎么解决的了。而且，也不确定真的是同一类问题。所以，我就先mark一下。  

<!-- more -->

# 症状
今天，在hexo d的时候遇到一个奇怪的问题，这个问题之前没出现过。自打win10更新一次以后就有问题了，不知道是不是更新的问题。以下是hexo报的log  
```
On branch master
nothing to commit, working tree clean
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
FATAL Something's wrong. Maybe you can find the solution here: http://hexo.io/docs/troubleshooting.html
Error: Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

    at ChildProcess.<anonymous> (E:\code\blog\node_modules\hexo-util\lib\spawn.js:37:17)
    at emitTwo (events.js:126:13)
    at ChildProcess.emit (events.js:214:7)
    at ChildProcess.cp.emit (E:\code\blog\node_modules\cross-spawn\lib\enoent.js:40:29)
    at maybeClose (internal/child_process.js:925:16)
    at Socket.stream.socket.on (internal/child_process.js:346:11)
    at emitOne (events.js:116:13)
    at Socket.emit (events.js:211:7)
    at Pipe._handle.close [as _onclose] (net.js:567:12)
```
大概说的是ssh key认证失败，不能读取远程库。然后我把自己电脑上的rsa_pub重新放到了github上一次，结果还是失败。  

# 解决方法
要提前用ssh连一下github，把github的公钥记录在本地的know_hosts里面就好了。具体方法是，在cmd中输入如下命令：  
```
ssh git@github.com
```
然后输入yes。  
之后再进行`hexo d`的时候就没这个问题了。