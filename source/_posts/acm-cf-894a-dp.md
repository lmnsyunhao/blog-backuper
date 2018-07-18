---
title: ACM CodeForces 894 A 题解 DP
tags: [ACM, CodeForces, DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-05-21 22:38:42
---
QAQ，简单DP题，详见本文内容。  

<!-- more -->

# 题目
A. QAQ

# 限制
time limit per test: 1 second  
memory limit per test: 256 megabytes  
input: standard input  
output: standard output  

# 描述
"QAQ" is a word to denote an expression of crying. Imagine "Q" as eyes with tears and "A" as a mouth.  
Now Diamond has given Bort a string consisting of only uppercase English letters of length n. There is a great number of "QAQ" in the string (Diamond is so cute!).  
Bort wants to know how many subsequences "QAQ" are in the string Diamond has given. Note that the letters "QAQ" don't have to be consecutive, but the order of letters should be exact.  

# 输入格式
The only line contains a string of length $n$$(1 \le n \le 100)$. It's guaranteed that the string only contains uppercase English letters.  

# 输出格式
Print a single integer — the number of subsequences "QAQ" in the string.  

# 样本
```
QAQAQYSYIOIWIN
```
```
4
```
```
QAQQQZZYNOIWIN
```
```
3
```

# 提示
In the first example there are 4 subsequences "QAQ": "**QAQ**AQYSYIOIWIN", "**QA**QA**Q**YSYIOIWIN", "**Q**AQ**AQ**YSYIOIWIN", "QA**QAQ**YSYIOIWIN".

# 思路
用dp;
dp[0][i]代表前i个字符内Q字符出现的次数。
dp[1][i]代表前i个字符内QA序列出现的次数。QA序列是QA对，QA两个字符不一定连续。
dp[2][i]代表前i个字符内QAQ序列出现的次数。
可以用滚动数组来减少空间复杂度。本代码中没有使用滚动数组。

# 代码
``` c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

char str[110];
int dp[3][110];

int main(){
    while(~scanf("%s", str)){
        memset(dp, 0, sizeof dp);
        int len = strlen(str);
        for(int i = 0; i < len; i++){
            if(i == 0){
                if(str[i] == 'Q'){
                    dp[0][i] = 1;
                }
                continue;
            }
            if(str[i] == 'Q'){
                dp[0][i] = dp[0][i-1] + 1;
                dp[1][i] = dp[1][i-1];
                dp[2][i] = dp[2][i-1] + dp[1][i-1];
            }
            else if(str[i] == 'A'){
                dp[0][i] = dp[0][i-1];
                dp[1][i] = dp[0][i-1] + dp[1][i-1];
                dp[2][i] = dp[2][i-1];
            }
            else{
                dp[0][i] = dp[0][i-1];
                dp[1][i] = dp[1][i-1];
                dp[2][i] = dp[2][i-1];
            }
        }
        printf("%d\n", dp[2][len-1]);
    }
    return 0;
}
```