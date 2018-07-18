---
title: ACM CodeForces 933 A 题解 DP
tags: [ACM, CodeForces, DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-05-23 10:15:56
---
A Twisty Movement，用dp。注意别读错题。reverse这个词，不是将某一个区间的值1变2,2变1，而是翻转这个区间。详见本文具体内容。  

<!-- more -->

# 题目
A. A Twisty Movement  

# 限制
time limit per test: 1 second  
memory limit per test: 256 megabytes  
input: standard input  
output: standard output  

# 描述
A dragon symbolizes wisdom, power and wealth. On Lunar New Year's Day, people model a dragon with bamboo strips and clothes, raise them with rods, and hold the rods high and low to resemble a flying dragon.  
A performer holding the rod low is represented by a $1$, while one holding it high is represented by a $2$. Thus, the line of performers can be represented by a sequence $a_1, a_2, ..., a_n$.  
Little Tommy is among them. He would like to choose an interval $[l, r] (1 \le l \le r \le n)$, then reverse $a_l, a_{l+1}, ..., a_r$ so that the length of the longest non-decreasing subsequence of the new sequence is maximum.  
A non-decreasing subsequence is a sequence of indices $p_1, p_2, ..., p_k$, such that $p_1 < p_2 < ... < p_k$ and $a_{p1} \le a_{p2} \le ... \le a_{pk}$. The length of the subsequence is $k$.  

# 输入格式
The first line contains an integer $n (1 \le n \le 2000)$, denoting the length of the original sequence.  
The second line contains n space-separated integers, describing the original sequence $a_1, a_2, ..., a_n$ $(1 \le a_i \le 2, i = 1, 2, ..., n)$.  

# 输出格式
Print a single integer, which means the maximum possible length of the longest non-decreasing subsequence of the new sequence.  

# 样本
```
4
1 2 1 2
```
```
4
```
```
10
1 1 2 2 2 1 1 2 2 1
```
```
9
```

# 提示
In the first example, after reversing $[2, 3]$, the array will become $[1, 1, 2, 2]$, where the length of the longest non-decreasing subsequence is 4.  
In the second example, after reversing $[3, 7]$, the array will become $[1, 1, 1, 1, 2, 2, 2, 2, 2, 1$], where the length of the longest non-decreasing subsequence is 9.  

# 思路
最开始读错题了，还错误理解了两个位置。首先是子序列，即不要求连续。第二是reverse这个词，不是将某一个区间的值1变2,2变1，而是翻转这个区间，即1,2,1,1变成1,1,2,1。  
用dp。考虑四种情况。1...的子序列，1...2...的子序列，1...2...1...的子序列，1...2...1...2...的子序列。因为可以用reverse，所以让1...2...1...2...这种子序列最长就好了。  
dp[0][i]代表前i个字符内1...的子序列最长的长度是多少。  
dp[1][i]代表前i个字符内1...2...的子序列的最长的长度是多少。  
dp[2][i]代表前i个字符内1...2...1...的子序列的最长的长度是多少。  
dp[3][i]代表前i个字符内1...2...1...2...的子序列的最长的长度是多少。  
注意最后输出dp[0][n-1]到dp[3][n-1]中最大值。因为序列中不一定会有满足1...2...1...2...的子序列，比如"111", "222", "12", "21", "212"这种。  
可以用滚动数组，代码中没用滚动数组。  

# 代码
``` c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int n;
int num[2010];
int dp[4][2010];

int main(){
    while(~scanf("%d", &n)){
        memset(dp, 0, sizeof dp);
        for(int i = 0; i < n; i++){
            scanf("%d", &num[i]);
        }

        for (int i = 0; i < n; i++){
            if(i == 0){
                if(num[i] == 1){
                    dp[0][i] = 1;
                }
                else{
                    dp[1][i] = 1;
                }
                continue;
            }
            if(num[i] == 1){
                dp[0][i] = dp[0][i-1] + 1;
                dp[1][i] = dp[1][i-1];
                dp[2][i] = max(dp[2][i-1] + 1, dp[1][i-1] + 1);
                dp[3][i] = dp[3][i-1];
            }
            else{
                dp[0][i] = dp[0][i-1];
                dp[1][i] = max(dp[0][i-1] + 1, dp[1][i-1] + 1);
                dp[2][i] = dp[2][i-1];
                dp[3][i] = max(dp[2][i-1] + 1, dp[3][i-1] + 1);
            }
        }
        int res = 0;
        for(int i = 0; i < 4; i++){
            if(res < dp[i][n-1]) res = dp[i][n-1];
        }
        printf("%d\n", res);

    }
    return 0;
}
```