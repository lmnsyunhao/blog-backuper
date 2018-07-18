---
title: Git 警告错误 LF will be replaced by CRLF
tags: [Git, Hexo]
categories: [Git]
comments: true
mathjax: false
date: 2018-06-29 14:59:18
---
我忍了这个问题好久了，每次Hexo d的时候，一大溜这个警告错误，今天查了查，然后知道了到底是什么问题了。mark一下。  

<!-- more -->

# 症状
每次使用git的时候，都会出现这个问题：  
```
warning: LF will be replaced by CRLF in tags/组合数学/index.html.
The file will have its original line endings in your working directory.
```
一报一大溜，真的烦。  

# 原因
windows中的换行符为 CRLF，而在Linux下的换行符为LF。所以会给换过来。  
就是说，我们在`工作区`的文件中，有的是以LF作为换行符结尾的，然后在添加到`暂存区`的时候，git会`暂存区`的LF换成CRLF。然后统一提交时候，都是CRLF换行了。  

# Hexo请看这里
如果是`Hexo d`的时候出的这个问题。我就是这个时候出的  
那么直接禁用转换就好了。不需要删除.git什么的。因为`hexo d`的时候，他会在`.deploy_git`文件夹内自动从新生成`.git`  
```
git config –global core.autocrlf false
```

# 解决方法
输入下面命令禁用转换。  
```
git config –global core.autocrlf false
```
但是禁用转换之后，必须得把`.git`删了，然后重新`git init`一下才行。所以记得保存一下本地的修改什么的。或者push一下。然后：  
```
rm -rf .git
git init
```
到这就行了。我不太确定是不是只有windows上边才会有这种问题。  
