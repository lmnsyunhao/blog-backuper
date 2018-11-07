---
title: ACM HDU 4632 题解 区间DP
tags: [ACM, HDU, DP, 区间DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-06-10 14:31:43
---
Palindrome subsequence，区间DP。dp[i][j]表示的是i,j区间的回文子序列的个数。注意状态转移。详见本文具体内容  

<!-- more -->

# 题目
Palindrome subsequence  

# 限制
Time Limit: 2000/1000 MS (Java/Others)  
Memory Limit: 131072/65535 K (Java/Others)  

# 描述
In mathematics, a subsequence is a sequence that can be derived from another sequence by deleting some elements without changing the order of the remaining elements. For example, the sequence <A, B, D> is a subsequence of <A, B, C, D, E, F>.(http://en.wikipedia.org/wiki/Subsequence)  
Given a string $S$, your task is to find out how many different subsequence of $S$ is palindrome. Note that for any two subsequence $X = <S_{x_1}, S_{x_2}, ..., S_{x_k}>$ and $Y = <S_{y_1}, S_{y_2}, ..., S_{y_k}>$ , if there exist an integer $i$ $(1 \le i \le k)$ such that $x_i \ne y_i$, the subsequence $X$ and $Y$ should be consider different even if $S_{x_i} = S_{y_i}$. Also two subsequences with different length should be considered different.  

# 输入格式
The first line contains only one integer $T$ $(T \le 50)$, which is the number of test cases. Each test case contains a string $S$, the length of $S$ is not greater than $1000$ and only contains lowercase letters.  

# 输出格式
For each test case, output the case number first, then output the number of different subsequence of the given string, the answer should be module $10007$.  

# 样本
```
4
a
aaaaa
goodafternooneveryone
welcometoooxxourproblems
```
```
Case 1: 1
Case 2: 31
Case 3: 421
Case 4: 960
```

# 思路
区间DP。dp[i][j]表示的是i,j区间的回文子序列的个数。注意状态转移。  
在计算j-i+1长度的区间时，比j-i+1长度小的区间都已经计算过了。因此dp[i][j] = dp[i][j-1] + dp[i+1][j] - dp[i+1][j-1]。如果str[i]==str[j]，那么，dp[i][j]就还需要加上dp[i+1][j-1]+1。  
19行是对区间长度进行循环。20行是对每个长度的所有区间进行循环。  

# 代码
```c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

#define mod 10007
int t;
char str[1005];
int dp[1005][1005];

int main(){
    scanf("%d\n", &t);
    for(int w = 0; w < t; w++){
        scanf("%s", str);
        memset(dp, 0, sizeof dp);

        int n = strlen(str);
        for(int i = 0; i < n; i++){
            for(int j = 0; j < n-i; j++){
                if(i == 0) dp[j][j+i] = 1;
                else{
                    dp[j][j+i] = (dp[j][j+i-1]+dp[j+1][j+i])%mod;
                    if(str[j] != str[j+i]){
                        dp[j][j+i] -= dp[j+1][j+i-1];
                    }
                    else{
                        dp[j][j+i] += 1;
                    }
                    dp[j][j+i] = (dp[j][j+i]+mod)%mod;
                }
            }
        }
        printf("Case %d: %d\n", w+1, dp[0][n-1]);
    }
    return 0;
}

```