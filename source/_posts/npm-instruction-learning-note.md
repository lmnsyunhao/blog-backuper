---
title: NPM 学习笔记
tags: [NPM, NodeJS]
categories: [NodeJS]
comments: true
mathjax: false
date: 2018-06-30 01:12:40
---
总结一下NPM的命令，防止以后总是去查阅。只是一些常用的命令，以及语义化版本号的含义。  

<!-- more -->

# NPM
NPM全称是node package manager。在安装nodejs的时候就会连带安装npm，用来维护和管理node_modules。我为什么要写这篇博客呢？因为懒得每次都百度。所以就mark一下。  

# 官方文档
官方的中文文档请见[中文文档](https://www.npmjs.com.cn/)  

# 本地安装和全局安装
如果你自己的模块依赖于某个包，并通过 Node.js 的 require 加载，那么你应该选择本地安装，这种方式也是 npm install 命令的默认行为。  
如果你想将包作为一个命令行工具，（比如 grunt CLI），那么你应该选择全局安装。  

# 语义化版本号
package.json中的dependencies里面都有version，那么version字段具体都表示什么含义呢？  
a.b.c的含义，如下：  
发布补丁，就增加最后一位数字，比如1.0.1  
如果增加新功能，且不影响原有的功能，就增加小版本号，比如1.1.0  
如果引入的变化，破坏了向后兼容性，就增加大版本号，比如2.0.0  
对于依赖包的版本，版本位置应该怎样填写？  
* 只接受补丁: 1.0 或 1.0.x 或 ~1.0.4
* 只接受小版本号和补丁: 1 或 1.x 或 ^1.0.4
* 接受全部更新: * 或 x

# 指令
* npm更新  
  `npm install npm -g`  
  `npm install npm@latest -g` 安装最新测试版  
  `npm install npm@next -g` 安装下一个未发行版  
* 创建package.json  
  `npm init`  
  `npm init -y` 会抽取项目的信息来生成package.json  
  `npm init --yes` 会抽取项目的信息来生成package.json  
  `npm set init.author.email "wombat@npmjs.com"` 设置初始化信息  
  `npm set init.author.name "ag_dubs"` 设置初始化信息  
  `npm set init.license "MIT"` 设置初始化信息  
* 查看npm版本  
  `npm -v`  
* 安装模块  
  `npm install <package_name>` 本地安装  
  `npm install <package_name> -g` 全局安装  
  `npm install <package_name> --save` 会将package_name添加到package.json中的dependencies下  
  `npm install <package_name> --save-dev` 会将package_name添加到package.json中的devDependencies下  
* 更新模块  
  `npm update [-g] [<pkg>...]` -g决定更新全局还是更新本地，如果没指定任何的pkg，那么就都更新。  
* 检查模块更新  
  `npm outdated [[<@scope>/]<pkg> ...]`  
* 删除模块  
  `npm uninstall <package_name>`  
  `npm uninstall --save <package_name>` 卸载并移除package.json中的依赖。  
* 查看全局安装的模块
  `npm list -g`
* 查看某个模块的版本号
  `npm list <Module Name>`
* 查看当前目录所有模块
  `npm ls`
* 搜索某模块
  `npm search <Module Name>`
* 查看某条命令帮助
  `npm help <command>`
