---
title: Atom 编辑器的插件总结
tags: [编辑器, Atom]
categories: [编辑器]
comments: true
mathjax: false
date: 2017-03-27 20:35:40
---
总结一下我的 Atom 编辑器的 Package，个人认为比较好的一些。  

<!-- more -->

# 安装插件
找到编辑->设置->Install，在里面搜索插件的名字，可以直接点安装。
有些插件安装出现问题，可以到 atom.io/packages 这个网站上去所搜，然后找到github地址。
```sh
cd ~/.atom/packages
git clone github地址
cd 插件目录
apm install 或者是 npm install
```
注意有些插件是需要前置插件的！

# Remote-FTP
能够连接FTP，显示目录结构。比较有用。

# activate-power-mode
atom 互动的一个插件，比较有意思。打字的时候会有互动。

# atom-beautify
atom 美化代码排版的。当代码格式很乱的时候，就beautify一下。就整齐了。

# browser-plus
atom集成浏览器，能够在atom中搜索，是不是让搜索更加便捷了呢。

# color-picker
颜色选择器，前端程序员必备利器。

# file-icons
让atom的图标更丰富。

# git-plus
能够在命令界面控制git，感觉不太好用。感觉直接唤出命令行，更容易一些。

# language-ocaml
ocaml语言的高亮，自动自动补全什么的。

# markdown-preview-plus
markdown预览，`Ctrl+Shift+M`唤出。

# markdown-writer
markdown编写的助手吧，不知道具体是做什么的，反正写markdown，我就安装了。

# merge-conflicts
能够图形化的解决git中的冲突，可以一试。

# minimap
向sublime一样的右上角的代码缩略图。

# ocaml-indent
ocaml语言的自动缩进。

# platformio-ide-terminal
让atom能够唤出终端，利器，良心推荐。

# remote-edit
能够连接服务器并且编辑编辑文件。感觉不够方便，与remote-ftp结合起来，还不错。

# simplified-chinese-menu
简体中文汉化包，翻译了绝大部分的选项。
