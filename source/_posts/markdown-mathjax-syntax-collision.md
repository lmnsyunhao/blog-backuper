---
title: Hexo 中 Markdown 与 MathJax 冲突解决
tags: [Hexo, Markdown, MathJax]
categories: [Hexo]
comments: true
mathjax: true
date: 2018-05-22 18:05:19
---
Hexo博客中会遇到mathjax公式渲染出现问题的情况，原来是markdown和mathjax的渲染出现冲突，本文解决冲突。  

<!-- more -->

# 症状
在网上找到的MathJax的公式，直接粘贴到Markdown文档中发现，显示格式不正确。比如：  
``` mathjax
mathjax的大括号
$$\{x\}$$
mathjax的换行符
$$f(b) = \begin{cases} b[1] \\ b[2] \end{cases}$$
```
在hexo中的实际效果为  
$$\{x\}$$
$$f(b) = \begin{cases} b[1] \\ b[2] \end{cases}$$
我的大括号呢？说好的换行符呢？怎么不显示了？  

# 分析
在hexo生成中，markdown会将文档先一步渲染，将某些字符转义，之后再是MathJax的渲染。在这个过程中会有冲突。  
对于大括号，markdown渲染器会将`\{`或是`\}`转义为`{`或是`}`，再等到MathJax渲染的时候当然就不对了。因为`\`没了啊。  
对于换行符，markdown渲染器会将`\\`转义为`\`，再到MathJax渲染的时候发现就剩一个了，所以就不换行了。  

# 解决方法
网上的一些解决方式都是修改mark.js中的正则表达式，来限制markdown的转义。或是npm安装一些东西来控制这些。有点粗暴。  
遇到类似的情况，发现是markdown先转义了，我的解决方法是，允许markdown转义，但要保证轮到MathJax转义的时候表达式是正确的。  
``` mathjax
mathjax的大括号
$$\\{x\\}$$
mathjax的换行符
$$f(b) = \begin{cases} b[1] \\\\ b[2] \end{cases}$$
```
改成上边这样，结果实际效果就正确了。  
$$\\{x\\}$$
$$f(b) = \begin{cases} b[1] \\\\ b[2] \end{cases}$$