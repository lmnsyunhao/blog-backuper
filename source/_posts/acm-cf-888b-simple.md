---
title: ACM CodeForces 888 B 题解 基础题
tags: [ACM, CodeForces, 基础题]
categories: [ACM, 基础题]
comments: true
mathjax: true
date: 2018-06-07 16:15:16
---
Buggy Robot，水题，计数就行了。详见本文内容。  

<!-- more -->

# 题目
B. Buggy Robot  

# 限制
time limit per test: 2 seconds  
memory limit per test: 256 megabytes  
input: standard input  
output: standard output  

# 描述
Ivan has a robot which is situated on an infinite grid. Initially the robot is standing in the starting cell $(0,0)$. The robot can process commands. There are four types of commands it can perform:  
* U — move from the cell $(x,y)$ to $(x,y+1)$;  
* D — move from $(x,y)$ to $(x,y-1)$;  
* L — move from $(x,y)$ to $(x-1,y)$;  
* R — move from $(x,y)$ to $(x+1,y)$.  

Ivan entered a sequence of $n$ commands, and the robot processed it. After this sequence the robot ended up in the starting cell $(0,0)$, but Ivan doubts that the sequence is such that after performing it correctly the robot ends up in the same cell. He thinks that some commands were ignored by robot. To acknowledge whether the robot is severely bugged, he needs to calculate the maximum possible number of commands that were performed correctly. Help Ivan to do the calculations!  

# 输入格式
The first line contains one number $n$ — the length of sequence of commands entered by Ivan $(1 \le n \le 100)$.  
The second line contains the sequence itself — a string consisting of $n$ characters. Each character can be $U$, $D$, $L$ or $R$.  

# 输出格式
Print the maximum possible number of commands from the sequence the robot could perform to end up in the starting cell.  

# 样本
```
4
LDUR
```
```
4
```
```
5
RRRUU
```
```
0
```
```
6
LLRRRR
```
```
4
```
# 思路
水题。算一下L、R、U、D四个字符的个数，然后为了回到原点，所以选取的L、R的个数必须相等，选取的U、D的个数也必须相等。详见代码。  

# 代码
```c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int n;
char c;

int main(){
    while(~scanf("%d\n", &n)){
        int cntl = 0, cntr = 0, cntu = 0, cntd = 0;
        for(int i = 1; i <= n; i++){
            scanf("%c", &c);
            if(c == 'L') cntl++;
            else if(c == 'R') cntr++;
            else if(c == 'U') cntu++;
            else if(c == 'D') cntd++;
        }
        printf("%d\n", min(cntl, cntr)*2 + min(cntu, cntd)*2);
    }
    return 0;
}
```