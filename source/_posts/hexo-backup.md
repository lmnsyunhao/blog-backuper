---
title: Hexo 备份
tags: [Hexo]
categories: [Hexo]
comments: true
mathjax: false
date: 2017-03-27 14:55:40
---
hexo 备份和移植  

<!-- more -->

# 创建仓库
PS：如果远程已经备份好，只是要`pull`下来，请跳到恢复一节  
假设我们的博客的项目目录为`blog`  
我们可以看到在`blog`目录下是没有`.git`文件夹的。  
首先，我们先将所有的更改，提交到本地库
```sh
git add .
git commit -m "backup"
```
# 创建backup分支
我们新建一个叫做`backup`的分支。然后切换到该分支，再删除`master`分支。
```sh
git branch backup
git checkout backup
git branch -d master
git branch
```
我们可以通过`git branch` 查看，只剩一个`backup`分支。

# 连接远程
我们连接远程库，并进行`push`操作，如下，远程库会自动建立`backup`分支。
```sh
git remote add origin 你的username.github.io的项目地址
git push origin backup:backup
```

# 修改push和pull的默认分支
保险起见，设置默认的跟踪分支，之后会看到本地的`backup`分支跟踪`origin/backup`分支
```sh
git push -u origin backup
git branch --set-upstream-to=origin/backup backup
```
设置了之后，我们再进行`git push` 或者是`git pull`的操作的时候就不用担心，会影响到`origin/master`分支了。

# 备份
之后我们再上传新的帖子的时候，要进行下面的操作。
```sh
hexo clean
hexo g
git add .
git commit -m "backup"
git push
hexo d
```
这样就能够备份了

# 恢复
本地的博客丢了怎么办？这样就能够弄一份一模一样的了。
```sh
mkdir blog
cd blog
git init
git remote add origin 你的username.github.io的项目地址
git pull origin backup:backup
git branch
git checkout backup
git branch -d master
git push -u origin backup
git branch --set-upstream-to=origin/backup backup
npm install
hexo clean
hexo g
hexo d
```
