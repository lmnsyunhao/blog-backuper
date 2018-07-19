---
title: Git Submodule 特性详解
tags: [Git, GitHub]
categories: [Git]
comments: true
mathjax: false
date: 2018-07-18 18:55:15
---
今天在搞博客的时候，遇到了嵌套git项目的问题，之前一直没多想。然后今天遇到了问题，在这里总结一下git如何优雅的处理嵌套项目。即git的submodule特性是什么。  

<!-- more -->

# submodule介绍
当一个git项目a中嵌套了另一个git项目b，而且b没有被a的.gitignore文件忽略掉。这种情况下就会用到submodule这个特性了。在使用git命令的时候，git会检查当前项目内是否含有另一个需要监控的git项目，如果有就会弹出一个提示，提示应该用submodule来解决这种情况。  
为什么呢？试想一下，如果不用这种特性的话，那么每个a的commit中都会有一个b的所有的commit树。也就是成了树套树。空间复杂度就瞬间变成O(n*n)了。所以用submodule这个特性可以避免这种情况的发生。  
submodule在项目a中存储一个指向项目b的某次提交的commit id，在存储一些b的仓库地址等配置信息，以这种方式将b集成进来。避免了树套树的问题。  
接下来，我们在GitHub上面使用两个仓库来进行学习，主项目main，子模块sub。  

# 创建
现在假设，我们需要把`当前GitHub上的最新版本的sub`作为项目main的一个子模块加入。  
PS：如果你的子项目已经在主项目里了，而且并没有用submodule特性。(这种情况是可能出现的)。可以先切换到子项目根目录下，然后提交所有更改，push到远程。然后在主项目中删除子项目。然后继续进行下述操作。  
在主项目目录下执行命令，执行这个命令的时候子项目的远程仓库最好不是空的，不然好像.gitmodules中不会添加对应的内容。  
```
git submodule add git@github.com:lmnsyunhao/sub.git sub
```
执行这个命令之后主目录下就会多出一些文件，.gitmodules和sub文件夹。sub文件夹下就是成功引入的子模块的内容。  
我们执行`git status`能够看到有两个文件已经添加到暂存区，准备提交。sub文件夹被当做一个文件进行提交。  
这个时候就创建好了，然后commit和push一下父项目  
```
git commit -m "add submodule"
git push
```
然后我们到GitHub上可以看到子项目后边带了一个`@`，@后边的就是子项目的commit id，当前父项目的`commit id`所对应的子项目的`commit id`  

# 修改子项目
首先，我们需要能对子项目进行commit。  
进入子项目的目录，然后向正常的操作一样，add，然后commit，然后push。  
```
cd sub
git add .
git commit -m "modified something"
git push
```
修改完子项目之后，我们回到父项目的目录，会发现父项目中提示子项目有心的commit id。我们需要把父项目在提交一下，也就是将父项目中的sub文件指向最新的commit id。  
```
cd ..
git add .
git commit -m "update sub"
git push
```

# 更新项目
我们在main项目中执行操作：`<commit id>`是main的远程仓库最新的一次提交中对应的sub的commit id。  
```
cd main
git pull
git submodule update
cd sub
git merge <commit id> master
```
现在，main项目和sub项目已经和main的远程仓库一样了。因为sub可能还有commit id领先（可能出现这种情况，请看下边情景）。所以还需要在sub项目中执行下面：  
```
cd sub
git pull
```
这样做是为了及时将sub项目更新到最新。当然如果你永远都不会在main项目中修改sub项目的文件的话。那么不进行git pull也是可以的。  
上面是对sub子项目更新到最新，如果你还有很多子项目，想要将所有的子项目更新到最新的话。可以执行下面操作：  
```
git submodule foreach git pull
```

试想下面情景：  
假设sub是main的子项目，现在有3个人，1在开发main，2也在开发main，3在开发sub。1，2有权修改main和sub，3只有权修改sub。  
* 1先修改main和sub，main的commit id是main_a，sub的commit id是sub_a。然后push并离开了。  
* 2在1的基础上继续修改，在main_a的基础上修改main，commit id是main_b，在sub_a的基础上修改sub，commit_id是sub_b。  
* 3在2的基础上修改sub，在sub_b的基础上修改sub，commit id是sub_c。  
* 然后1回来了。他应该先在主项目下git pull，然后发现sub项目有新的提交。然后在主目录执行git submodule update，这个时候，cd到sub中，我们可以看到分支切换到了sub_b这个commit上。也就是说git submodule update只是切换分支，如果这个时候想继续对sub修改的话，首先，我们需要手动merge，执行git merge sub_b master，将sub_b分支merge到主分支上。然后现在这个状态就和main项目的最新状态是一样的了。但是我们知道sub项目还有个commit id，sub_c，我们需要及时对这个sub_c做个处理，否则的话，如果直接修改sub项目，提交的话，容易出现冲突。即，git pull一下，将sub_c更新过来。  

从上面的例子我们看到了git submodule update与直接在子项目里面git pull是有一些区别的。直接在子项目中执行git pull的话，那么就是一下子就更新到了sub_c这个commit id了。而git submodule update则是更新到main项目中最后一次提交时sub项目对应的commit id。  

# 克隆父项目
方法一：父项目和子项目一起克隆下来  
```
git clone git@github.com:lmnsyunhao/main.git --recursive
```
方法二：先克隆父项目，然后再克隆子项目  
```
git clone git@github.com:lmnsyunhao/main.git
cd main
git submodule init
git submodule update
```
上边的情景已经展示了`git submodule update`的性质了。即默认切换到对应的commit id，如果你需要修改子项目的话，还需要将commit id手动merge到master才能更改。  
```
git merge <commit id> master
```

# 删除子项目
不支持命令删除子项目，需要手动删除。  
```
cd main
git rm --cached sub
rm -rf sub
```
移除.gitmodules文件中对应的部分  
移除.git/config文件中对应的部分  
移除.git/modules文件夹下对应的文件夹  