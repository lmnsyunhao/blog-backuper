---
title: ACM CodeForces 877 B 题解 DP
tags: [ACM, CodeForces, DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-06-08 23:18:41
---
Nikita and string，简单DP，详见本文内容。  

<!-- more -->

# 题目
B. Nikita and string  

# 限制
time limit per test: 2 seconds  
memory limit per test: 256 megabytes  
input: standard input  
output: standard output  

# 描述
One day Nikita found the string containing letters "a" and "b" only.  
Nikita thinks that string is beautiful if it can be cut into 3 strings (possibly empty) without changing the order of the letters, where the 1-st and the 3-rd one contain only letters "a" and the 2-nd contains only letters "b".  
Nikita wants to make the string beautiful by removing some (possibly none) of its characters, but without changing their order. What is the maximum length of the string he can get?  

# 输入格式
The first line contains a non-empty string of length not greater than $5000$ containing only lowercase English letters "a" and "b".  

# 输出格式
Print a single integer — the maximum possible size of beautiful string Nikita can get.  

# 样本
```
abba
```
```
4
```
```
bab
```
```
2
```

# 提示
It the first sample the string is already beautiful.  
In the second sample he needs to delete one of "b" to make it beautiful.  

# 思路
动态规划。  
dp[i][0]是指前i个字符中，a...序列(不一定连续)的最大长度。  
dp[i][1]是指前i个字符中，a...b...序列(不一定连续)的最大长度。  
dp[i][2]是指前i个字符中，a...b...a...序列(不一定连续)的最大长度。  
转换过程详见代码。  

# 代码
```c++
#include <cstdio>
#include <cstring>
#include <iostream>

using namespace std;

char str[5005];
int dp[5005][3];

int main(){
    while(~scanf("%s", str)){
        int len = strlen(str);
        memset(dp, 0, sizeof dp);
        for(int i = 1; i <= len; i++){
            if(str[i-1] == 'a'){
                dp[i][0] = dp[i-1][0]+1;
                dp[i][1] = dp[i-1][1];
                dp[i][2] = max(dp[i-1][1]+1, dp[i-1][2]+1);
            }
            else{
                dp[i][0] = dp[i-1][0];
                dp[i][1] = max(dp[i-1][0]+1, dp[i-1][1]+1);
                dp[i][2] = dp[i-1][2];
            }
        }
        printf("%d\n", max(dp[len][0], max(dp[len][1], dp[len][2])));
    }
    return 0;
}

```