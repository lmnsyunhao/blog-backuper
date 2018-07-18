---
title: ACM HDU 2844 题解 多重背包
tags: [ACM, HDU, DP, 背包问题]
categories: [ACM, DP, 背包问题]
comments: true
mathjax: true
date: 2018-06-05 12:53:49
---
Coins，多重背包问题。如果某个硬币的面额乘数量大于m，那么就是完全背包；否则就是01背包。详见本文具体内容  

<!-- more -->

# 题目
Coins  

# 限制
Time Limit: 2000/1000 MS (Java/Others)  
Memory Limit: 32768/32768 K (Java/Others)  

# 描述
Whuacmers use coins. They have coins of value $A_1,A_2,A_3...A_n$ Silverland dollar. One day Hibix opened purse and found there were some coins. He decided to buy a very nice watch in a nearby shop. He wanted to pay the exact price(without change) and he known the price would not more than $m$.But he didn't know the exact price of the watch.  
You are to write a program which reads $n,m,A_1,A_2,A_3...A_n$ and $C_1,C_2,C_3...C_n$ corresponding to the number of Tony's coins of value $A_1,A_2,A_3...A_n$ then calculate how many prices(form $1$ to $m$) Tony can pay use these coins.  

# 输入格式
The input contains several test cases. The first line of each test case contains two integers $n$$(1 \le n \le 100),$ $m$$(m \le 100000)$. The second line contains $2n$ integers, denoting $A_1,A_2,A_3...A_n,$ $C_1,C_2,C_3...C_n$ $(1 \le Ai \le 100000,$ $1 \le Ci \le 1000)$. The last test case is followed by two zeros.  

# 输出格式
For each test case output the answer on a single line.  

# 样本
```
3 10
1 2 4 2 1 1
2 5
1 4 2 1
0 0
```
```
8
4
```
# 思路
多重背包问题。如果某个硬币的面额乘数量大于m，那么就是完全背包；否则就是01背包。注意不能全按照01背包处理，会超时。  
拆01背包时候按照类似2分的样子拆。这样能够保证拆出来之后增加的物品数量最小。  
代码中m是背包容量。v数组是存储的面额，c数组存储的是数量，函数参数中的c是花费，v是价值。  

# 代码
```c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int n, m;
int v[105];
int c[105];
int dp[100005];

void init(int m){
    for(int i = 1; i <= m; i++){
        dp[i] = -1000000000;
    }
    dp[0] = 0;
}

void completepack(int m, int c, int v){
    for(int i = c; i <= m; i++){
        dp[i] = max(dp[i], dp[i-c]+v);
    }
}

void O1pack(int m, int c, int v){
    for(int i = m; i >= c; i--){
        dp[i] = max(dp[i], dp[i-c]+v);
    }
}

void multiplepack(int m, int c, int v, int num){
    if(c*num >= m){
        completepack(m, c, v);
        return ;
    }
    for(int i = 1; i <= num; i*=2){
        O1pack(m, c*i, v*i);
        num -= i;
    }
    if(num){
        O1pack(m, c*num, v*num);
    }
}

int main(){
    while(~scanf("%d%d", &n, &m)){
        if(n == 0 && m == 0) break;
        for(int i = 0; i < n; i++){
            scanf("%d", &v[i]);
        }

        for(int i = 0; i < n; i++){
            scanf("%d", &c[i]);
        }

        init(m);

        if(m > 0){
            for(int i = 0; i < n; i++){
                multiplepack(m, v[i], 1, c[i]);
            }
        }

        int ret = 0;
        for(int i = 1; i <= m; i++){
            if(dp[i] > 0){
                ret++;
            }
        }
        printf("%d\n", ret);
    }
    return 0;
}

```