---
title: ACM POJ 2955 题解 区间DP
tags: [ACM, POJ, DP, 区间DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-06-10 23:57:07
---
Brackets。区间划分DP，没有限制的区间划分。详见本文内容  

<!-- more -->

# 题解
Brackets  

# 限制
Time Limit: 1000MS  
Memory Limit: 65536K  

# 描述
We give the following inductive definition of a "regular brackets" sequence:  

* the empty sequence is a regular brackets sequence,  
* if s is a regular brackets sequence, then (s) and [s] are regular brackets sequences, and  
* if a and b are regular brackets sequences, then ab is a regular brackets sequence.  
* no other sequence is a regular brackets sequence  

For instance, all of the following character sequences are regular brackets sequences:  
(), [], (()), ()[], ()[()]  
while the following character sequences are not:  
(, ], )(, ([)], ([(]  
Given a brackets sequence of characters $a_1a_2...a_n$, your goal is to find the length of the longest regular brackets sequence that is a subsequence of $s$. That is, you wish to find the largest $m$ such that for indices $i_1, i_2, ..., i_m$ where $1 \le i_1 \lt i_2 \lt ... \lt i_m \le n$, $a_{i_1}a_{i_2} ... a_{i_m}$ is a regular brackets sequence.  
Given the initial sequence ([([]])], the longest regular brackets subsequence is [([])].  

# 输入格式
The input test file will contain multiple test cases. Each input test case consists of a single line containing only the characters (, ), [, and ]; each input test will have length between $1$ and $100$, inclusive. The end-of-file is marked by a line containing the word "end" and should not be processed.  

# 输出格式
For each input case, the program should print the length of the longest possible regular brackets subsequence on a single line.  

# 样本
```
((()))
()()()
([]])
)[)(
([][][)
end
```
```
6
6
4
0
6
```

# 思路
区间划分DP，没有限制的区间划分。  
dp[a][b]存的是区间[a,b]内满足要求的符号表达式的最大长度。  
然后dp[a][b]的最大长度，是对区间[a,b]进行划分得到的所有结果中，的最大值。  
如果str[a]=='('并且str[b]==')'或者是str[a]=='['并且str[b]==']'，即a位置与b位置正好能够配对的时候，dp[a][b]还要与dp[a+1][b-1]作比较，dp[a][b]取最大值。  
解释一下代码，  
16行的i是对区间长度进行迭代。17行的j是对不同的区间起始节点进行迭代。18行是对[j,j+i]区间的不同划分点进行迭代。  

# 代码
```c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int dp[105][105];
char str[105];

int main(){
    while(~scanf("%s", str)){
        if(str[0] == 'e') break;
        int n = strlen(str);
        memset(dp, 0, sizeof dp);

        for(int i = 0; i < n; i++){
            for(int j = 0; j < n-i; j++){
                for(int k = j; k < j+i; k++){
                    dp[j][j+i] = max(dp[j][j+i], dp[j][k]+dp[k+1][j+i]);
                }
                if((str[j] == '(' && str[j+i] == ')') || (str[j] == '[' && str[j+i] == ']'))
                    dp[j][j+i] = max(dp[j][j+i], dp[j+1][j+i-1]+2);
            }
        }

        printf("%d\n", dp[0][n-1]);
    }
    return 0;
}
```