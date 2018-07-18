---
title: ACM CodeForces 983 B 题解 DP
tags: [ACM, CodeForces, DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-05-20 13:17:46
---
XOR-pyramid，用dp，提前打表，用递归的方式会超时。详见本文具体内容  

<!-- more -->

# 题目
B. XOR-pyramid

# 限制
time limit per test: 2 seconds  
memory limit per test: 512 megabytes  
input: standard input  
output: standard output  

# 描述
For an array $b$ of length $m$ we define the function $f$ as  
$$f(b) = \begin{cases} b[1] & \quad \text{if } m = 1 \\\\ f(b[1] \oplus b[2],b[2] \oplus b[3],\dots,b[m-1] \oplus b[m]) & \quad \text{otherwise,} \end{cases}$$
where $\oplus$ is bitwise exclusive OR.  
For example,  
$$f(1,2,4,8)=f(1\oplus2,2\oplus4,4\oplus8)=f(3,6,12)=f(3\oplus6,6\oplus12)=f(5,10)=f(5\oplus10)=f(15)=15$$  
You are given an array $a$ and a few queries. Each query is represented as two integers $l$ and $r$. The answer is the maximum value of $f$ on all continuous subsegments of the array $a_l, a_{l+1}, \ldots, a_r$  

# 输入格式
The first line contains a single integer $n$ $(1 \le n \le 5000)$ — the length of $a$.  
The second line contains $n$ integers $a_1, a_2, \dots, a_n (0 \le a_i \le 2^{30}-1)$ — the elements of the array.  
The third line contains a single integer $q$ $(1 \le q \le 100000)$ — the number of queries.  
Each of the next $q$ lines contains a query represented as two integers $l, r$ $(1 \le l \le r \le n)$.  

# 输出格式
Print q lines — the answers for the queries.  

# 样本
```
3
8 4 1
2
2 3
1 2
```
```
5
12

```
```
6
1 2 4 8 16 32
4
1 6
2 5
3 4
1 2
```
```
60
30
12
3
```
# 提示
In first sample in both queries the maximum value of the function is reached on the subsegment that is equal to the whole segment.  
In second sample, optimal segment for first query are $[3,6]$, for second query — $[2,5]$, for third — $[3,4]$, for fourth — $[1,2]$

# 思路
用dp，dp右上半个数组存储f(l到r)的值，dp左下半个数组存储l到r区间内子串的最大f函数值 
提前打表，用递归的方式会超时。亲测。

# 代码
``` c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int n, q, l, r;
int dp[5005][5005];

void calc(){
    for (int i = 2; i <= n; i++){
        for(int j = 0; j < n-i+1; j++){
            int x = j+1, y = i+j;
            dp[x][y] = dp[x+1][y] ^ dp[x][y-1];
            dp[y][x] = max(dp[x][y], max(dp[y][x+1], dp[y-1][x]));
        }
    }
}

int main(){
    while(~scanf("%d", &n)){
        for (int i = 1; i <= n; i++){
            scanf("%d", &dp[i][i]);
        }
        calc();
        scanf("%d", &q);
        for (int w = 0; w < q; w++){
            scanf("%d%d", &l, &r);
            printf("%d\n", dp[r][l]);
        }
    }
    return 0;
}
```