---
title: MathJax 基本语法学习笔记
tags: [MathJax]
categories: [Language]
comments: true
mathjax: true
date: 2018-05-22 10:32:00
---
博客中遇到复杂的数学公式怎么办？来学习一波MathJax的语法，遇到难写的数学公式不用再去查了。mark一下。  

<!-- more -->

# 显示公式
在行中显示，就用`$...$`  
单独一行显示，则用`$$...$$`  

# 上标和下标
上标用`^`，下标用`_`。如果上下标符号要显示两个以上的字符，用`{}`括起来。  
> `$x^2$` 表示 $x^2$  
> `$\log_2 x$` 表示 $\log_2 x$  
> `$x^{10}$` 表示 $x^{10}$  

# 希腊字母
小写开头字母就小写，大写的话开头字母就大写，前提是该希腊字符有大写。  
> `$\alpha, \beta, …, \omega$` 表示 $\alpha, \beta, …, \omega$  
> `$\Gamma, \Delta, …, \Omega$` 表示 $\Gamma, \Delta, …, \Omega$  

# 括号
> 小括号，`$()$` 表示 $()$  
> 方括号，`$[]$` 表示 $[]$  
> 花括号，`$\\{\\}$` 表示 $\\{\\}$  
> 绝对值符号，`$\vert x \vert$` 表示 $\vert x \vert$  
> 范数符号，`$\Vert x \Vert$` 表示 $\Vert x \Vert$  
> 尖角符号，`$\langle x \rangle$` 表示 $\langle x \rangle$  
> 向上取整符号，`$\lceil \rceil$` 表示 $\lceil \rceil$  
> 向下取整符号，`$\lfloor \rfloor$` 表示 $\lfloor \rfloor$  

括号默认不会随着高度伸缩，如果需要伸缩，用`\left(…\right)`来进行自动伸缩。`\left`和`\right`在三种括号，绝对值符号，范数符号，尖角符号，向上下取整符号中有用  
> 不伸缩，`$(\frac{\sqrt x}{y^3})$` 表示 $(\frac{\sqrt x}{y^3})$  
> 伸缩，`$\left(\frac{\sqrt x}{y^3}\right)$` 表示 $\left(\frac{\sqrt x}{y^3}\right)$  

如果只需显示一半的符号，可以用`.`来表示另一边为空。`$\left. \frac 1 2 \right \rbrace$` 表示 $\left. \frac 1 2 \right \rbrace$  
当然也可以手动调整括号的大小，如`$\Bigl(\bigl((x)\bigr)\Bigr)$` 表示 $\Bigl(\bigl((x)\bigr)\Bigr)$  

# 求和与积分
> 求和，`$\sum_1^n$` 表示 $\sum_1^n$  
> 积分，`$\int_1^n$` 表示 $\int_1^n$  
> 连乘，`$\prod$` 表示 $\prod$  
> 并集，`$\bigcup$` 表示 $\bigcup$  
> 交集，`$\bigcap$` 表示 $\bigcap$  
> 重积分，`$\iint$` 表示 $\iint$  

# 分数
> `$\frac a b$` 表示 $\frac a b$  
> `${a+1 \over b+1}$` 表示 ${a+1 \over b+1}$  

# 根号
> `$\sqrt {x^3}$` 表示 $\sqrt {x^3}$  
> `$\sqrt[3] {\frac x y}$` 表示 $\sqrt[3] {\frac x y}$  

# 极限
> `$\lim_{x \to 0}$` 表示 $\lim_{x \to 0}$  

# 空格
`$a\, a\; a\quad a\qquad a$` 表示 $a\, a\; a\quad a\qquad a$  
加入一段文字，可用`$\\{x \in s \mid x \text{ is extra large}\\}$`表示 $\\{x \in s \mid x \text{ is extra large}\\}$  
在`\text{...}`里面还可以嵌套`$...$`  

# 转义符
一般情况下用\来作转义，但如果想要转义`\`，需要用`\backslash`，`\\`表示换行。  

# 符号总结
`$\pm$` 表示 $\pm$  
`$\times$` 表示 $\times$  
`$\div$` 表示 $\div$  
`$\sum$` 表示 $\sum$  
`$\prod$` 表示 $\prod$  
`$\coprod$` 表示 $\coprod$  
`$\mid$` 表示 $\mid$  
`$\nmid$` 表示 $\nmid$  
`$\cdot$` 表示 $\cdot$  
`$\leq$` 表示 $\leq$  
`$\geq$` 表示 $\geq$  
`$\neq$` 表示 $\neq$  
`$\approx$` 表示 $\approx$  
`$\equiv$` 表示 $\equiv$  
`$\circ$` 表示 $\circ$  
`$\ast$` 表示 $\ast$  
`$\bigodot$` 表示 $\bigodot$  
`$\bigotimes$` 表示 $\bigotimes$  
`$\bigoplus$` 表示 $\bigoplus$  
`$\mapsto$` 表示 $\mapsto$  
`$\longmapsto$` 表示 $\longmapsto$  
`$\hookleftarrow$` 表示 $\hookleftarrow$  
`$\hookrightarrow$` 表示 $\hookrightarrow$  
`$\leftharpoonup$` 表示 $\leftharpoonup$  
`$\rightharpoonup$` 表示 $\rightharpoonup$  
`$\leftharpoondown$` 表示 $\leftharpoondown$  
`$\rightharpoondown$` 表示 $\rightharpoondown$  
`$\rightleftharpoons$` 表示 $\rightleftharpoons$  
`$\leadsto$` 表示 $\leadsto$  
`$\nearrow$` 表示 $\nearrow$  
`$\searrow$` 表示 $\searrow$  
`$\swarrow$` 表示 $\swarrow$  
`$\nwarrow$` 表示 $\nwarrow$  
`$\nleftarrow$` 表示 $\nleftarrow$  
`$\nrightarrow$` 表示 $\nrightarrow$  
`$\nLeftarrow$` 表示 $\nLeftarrow$  
`$\nRightarrow$` 表示 $\nRightarrow$  
`$\nleftrightarrow$` 表示 $\nleftrightarrow$  
`$\nLeftrightarrow$` 表示 $\nLeftrightarrow$  
`$\dashrightarrow$` 表示 $\dashrightarrow$  
`$\dashleftarrow$` 表示 $\dashleftarrow$  
`$\leftleftarrows$` 表示 $\leftleftarrows$  
`$\leftrightarrows$` 表示 $\leftrightarrows$  
`$\Lleftarrow$` 表示 $\Lleftarrow$  
`$\twoheadleftarrow$` 表示 $\twoheadleftarrow$  
`$\leftarrowtail$` 表示 $\leftarrowtail$  
`$\looparrowleft$` 表示 $\looparrowleft$  
`$\leftrightharpoons$` 表示 $\leftrightharpoons$  
`$\curvearrowleft$` 表示 $\curvearrowleft$  
`$\circlearrowleft$` 表示 $\circlearrowleft$  
`$\Lsh$` 表示 $\Lsh$  
`$\upuparrows$` 表示 $\upuparrows$  
`$\upharpoonleft$` 表示 $\upharpoonleft$  
`$\downharpoonleft$` 表示 $\downharpoonleft$  
`$\multimap$` 表示 $\multimap$  
`$\leftrightsquigarrow$` 表示 $\leftrightsquigarrow$  
`$\rightrightarrows$` 表示 $\rightrightarrows$  
`$\rightleftarrows$` 表示 $\rightleftarrows$  
`$\rightrightarrows$` 表示 $\rightrightarrows$  
`$\rightleftarrows$` 表示 $\rightleftarrows$  
`$\twoheadrightarrow$` 表示 $\twoheadrightarrow$  
`$\rightarrowtail$` 表示 $\rightarrowtail$  
`$\looparrowright$` 表示 $\looparrowright$  
`$\rightleftharpoons$` 表示 $\rightleftharpoons$  
`$\curvearrowright$` 表示 $\curvearrowright$  
`$\circlearrowright$` 表示 $\circlearrowright$  
`$\Rsh$` 表示 $\Rsh$  
`$\downdownarrows$` 表示 $\downdownarrows$  
`$\upharpoonright$` 表示 $\upharpoonright$  
`$\downharpoonright$` 表示 $\downharpoonright$  
`$\rightsquigarrow$` 表示 $\rightsquigarrow$  
`$\uparrow$` 表示 $\uparrow$  
`$\downarrow$` 表示 $\downarrow$  
`$\Uparrow$` 表示 $\Uparrow$  
`$\Downarrow$` 表示 $\Downarrow$  
`$\updownarrow$` 表示 $\updownarrow$  
`$\Updownarrow$` 表示 $\Updownarrow$  
`$\rightarrow$` 表示 $\rightarrow$  
`$\leftarrow$` 表示 $\leftarrow$  
`$\Rightarrow$` 表示 $\Rightarrow$  
`$\Leftarrow$` 表示 $\Leftarrow$  
`$\leftrightarrow$` 表示 $\leftrightarrow$  
`$\Leftrightarrow$` 表示 $\Leftrightarrow$  
`$\longrightarrow$` 表示 $\longrightarrow$  
`$\longleftarrow$` 表示 $\longleftarrow$  
`$\Longrightarrow$` 表示 $\Longrightarrow$  
`$\Longleftarrow$` 表示 $\Longleftarrow$  
`$\longleftrightarrow$` 表示 $\longleftrightarrow$  
`$\Longleftrightarrow$` 表示 $\Longleftrightarrow$  
`$\emptyset$` 表示 $\emptyset$  
`$\in$` 表示 $\in$  
`$\notin$` 表示 $\notin$  
`$\subset$` 表示 $\subset$  
`$\supset$` 表示 $\supset$  
`$\subseteq$` 表示 $\subseteq$  
`$\supseteq$` 表示 $\supseteq$  
`$\bigcap$` 表示 $\bigcap$  
`$\bigcup$` 表示 $\bigcup$  
`$\bigvee$` 表示 $\bigvee$  
`$\bigwedge$` 表示 $\bigwedge$  
`$\biguplus$` 表示 $\biguplus$  
`$\bigsqcup$` 表示 $\bigsqcup$  
`$\because$` 表示 $\because$  
`$\therefore$` 表示 $\therefore$  
`$\forall$` 表示 $\forall$  
`$\exists$` 表示 $\exists$  
`$\not=$` 表示 $\not=$  
`$\not>$` 表示 $\not>$  
`$\not\subset$` 表示 $\not\subset$  
`$\aleph$` 表示 $\aleph$  
`$\beth$` 表示 $\beth$  
`$\daleth$` 表示 $\daleth$  
`$\gimel$` 表示 $\gimel$  
`$\alpha$` 表示 $\alpha$  
`$\beta$` 表示 $\beta$  
`$\gamma$` 表示 $\gamma$  
`$\Gamma$` 表示 $\Gamma$  
`$\digamma$` 表示 $\digamma$  
`$\delta$` 表示 $\delta$  
`$\Delta$` 表示 $\Delta$  
`$\epsilon$` 表示 $\epsilon$  
`$\varepsilon$` 表示 $\varepsilon$  
`$\zeta$` 表示 $\zeta$  
`$\eta$` 表示 $\eta$  
`$\theta$` 表示 $\theta$  
`$\Theta$` 表示 $\Theta$  
`$\vartheta$` 表示 $\vartheta$  
`$\iota$` 表示 $\iota$  
`$\kappa$` 表示 $\kappa$  
`$\varkappa$` 表示 $\varkappa$  
`$\lambda$` 表示 $\lambda$  
`$\Lambda$` 表示 $\Lambda$  
`$\mu$` 表示 $\mu$  
`$\nu$` 表示 $\nu$  
`$\xi$` 表示 $\xi$  
`$\Xi$` 表示 $\Xi$  
`$\pi$` 表示 $\pi$  
`$\Pi$` 表示 $\Pi$  
`$\varpi$` 表示 $\varpi$  
`$\rho$` 表示 $\rho$  
`$\varrho$` 表示 $\varrho$  
`$\sigma$` 表示 $\sigma$  
`$\Sigma$` 表示 $\Sigma$  
`$\varsigma$` 表示 $\varsigma$  
`$\varsigma$` 表示 $\varsigma$  
`$\tau$` 表示 $\tau$  
`$\upsilon$` 表示 $\upsilon$  
`$\Upsilon$` 表示 $\Upsilon$  
`$\phi$` 表示 $\phi$  
`$\Phi$` 表示 $\Phi$  
`$\varphi$` 表示 $\varphi$  
`$\chi$` 表示 $\chi$  
`$\psi$` 表示 $\psi$  
`$\Psi$` 表示 $\Psi$  
`$\omega$` 表示 $\omega$  
`$\Omega$` 表示 $\Omega$  