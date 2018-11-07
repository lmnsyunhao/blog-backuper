---
title: ACM CodeForces 873 B 题解 前缀和
tags: [ACM, CodeForces, 基础题]
categories: [ACM, 基础题]
comments: true
mathjax: true
date: 2018-06-07 23:49:23
---
Balanced Substring，可以用一个前缀和的思路来做，详见本文内容。  

<!-- more -->

# 题目
B. Balanced Substring  

# 限制
time limit per test: 1 second  
memory limit per test: 256 megabytes  
input: standard input  
output: standard output  

# 描述
You are given a string $s$ consisting only of characters $0$ and $1$. A substring $[l,r]$ of $s$ is a string $s_l$$s_{l+1}$$s_{l+2}$$...$$s_r$, and its length equals to $r-l+1$. A substring is called balanced if the number of zeroes (0) equals to the number of ones in this substring.  
You have to determine the length of the longest balanced substring of $s$.  

# 输入格式
The first line contains $n$ $(1 \le n \le 100000)$ — the number of characters in $s$.  
The second line contains a string $s$ consisting of exactly $n$ characters. Only characters $0$ and $1$ can appear in $s$.  

# 输出格式
If there is no non-empty balanced substring in $s$, print $0$. Otherwise, print the length of the longest balanced substring.  

# 样本
```
8
11010111
```
```
4
```
```
3
111
```
```
0
```

# 提示
In the first example you can choose the substring $[3,6]$. It is balanced, and its length is $4$. Choosing the substring $[2,5]$ is also possible.  
In the second example it's impossible to find a non-empty balanced substring.  

# 思路
前缀和的思想。从头往后扫，遇到1就加一，遇到0就减一，维护数列的前缀和。一旦r的前缀和l的前缀相等，那么[l+1,r]这个区间里的0和1的数量一定相等。  
mark数组中0到100000存储的是前缀和为-100000到0的首次出现位置。100001到200000存储的是前缀和为1到100000的首次出现位置。  
mark数组首先初始化为-2，然后将mark[0]设置为-1。每次计算前缀和，一旦发现某个mark对应某个前缀和在之前出现过，即不等于-2，那么就和res作比较。否则就更新mark的值为当前下标。  

# 代码
```c++
#include <cstdio>
#include <cstring>
#include <iostream>

using namespace std;

int n;
char c;
int num;
int mark[200005];

int main(){
    while(~scanf("%d\n", &n)){
        for(int i = -1*n; i <= n; i++){
            mark[i+100000] = -2;
        }
        mark[100000] = -1;

        int sum = 0;
        int res = 0;
        for(int i = 0; i < n; i++){
            scanf("%c", &c);
            num = c-'0';
            num == 0 ? sum-- : sum++;
            if(mark[100000+sum] != -2){
                res = max(i-mark[100000+sum], res);
            }
            else{
                mark[100000+sum] = i;
            }
        }
        printf("%d\n", res);
    }
    return 0;
}
```