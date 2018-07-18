---
title: ACM HDU 2577 题解 DP
tags: [ACM, HDU, DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-05-19 15:07:30
---
How to Type，简单DP，详见本文具体内容  

<!-- more -->

# 题目
How to Type

# 限制
Time Limit: 2000/1000 MS(JAVA/Others)  
Memory Limit: 32768/32768 K (JAVA/Others)

# 描述
Pirates have finished developing the software.He called Cathy to test his typing software. She is good at thinking. After testing for several days, she finds that if she types a string by some ways, she will type the key at least. But she has a bad habit that if the caps lock is on, she must turn off it, after she finishes typing. Now she wants to know the smallest times of typing the key to finish typing a string.

# 输入格式
The first line is an integer $t$ $(t \le 100)$, which is the number of test case in the input file. For each test case, there is only one string which consists of lowercase letter and upper case letter. The length of the string is at most 100.

# 输出格式
For each test case, you must output the smallest times of typing the key to finish typing this string.

# 样本
```
3
Pirates
HDUacm
HDUACM
```
```
8
8
8
```

# 提示
The string "Pirates", can type this way, Shift, p, i, r, a, t, e, s, the answer is 8.  
The string "HDUacm", can type this way, Caps lock, h, d, u, Caps lock, a, c, m, the answer is 8  
The stirng "HDUACM", can type this way, Caps lock, h, d, u, a, c, m, Caps lock, the answer is 8  

# 思路
用动态规划  
dp[0][j]代表，输入完j个字符之后保持在小写状态的情况下，最小的按键次数。  
dp[1][j]代表，输入完j个字符之后保持在大写状态的情况下，最小的按键次数。  
可以考虑用滚动数组，这样可以将数组缩小到dp[2][2]。本解法没用滚动数组。  

# 代码
``` c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int t;
char s[110];
int dp[2][110];

int main(){
    scanf("%d", &t);
    while(t--){
        scanf("%s", s);
        int len = strlen(s);
        memset(dp, 0x3f, sizeof dp);
        for (int i = 0; i < len; i++){
            if(s[i] >= 'a'  && s[i] <= 'z'){
                if(i == 0){
                    dp[0][i] = 1;
                    dp[1][i] = 2;
                }
                else{
                    dp[0][i] = min(dp[0][i-1]+1, dp[1][i-1]+2);
                    dp[1][i] = min(dp[1][i-1]+2, dp[0][i-1]+2);
                }
            }
            else{
                if(i == 0){
                    dp[0][i] = 2;
                    dp[1][i] = 2;
                }
                else{
                    dp[0][i] = min(dp[0][i-1]+2, dp[1][i-1]+2);
                    dp[1][i] = min(dp[1][i-1]+1, dp[0][i-1]+2);
                }
            }
        }
        int res = min(dp[0][len-1], dp[1][len-1]+1);
        printf("%d\n", res);
    }
    return 0;
}
```