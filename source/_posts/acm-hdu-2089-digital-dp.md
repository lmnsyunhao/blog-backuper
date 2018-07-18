---
title: ACM HDU 2089 题解 数位DP
tags: [ACM, HDU, DP, 数位DP]
categories: [ACM, DP, 数位DP]
comments: true
mathjax: true
date: 2018-06-17 16:34:42
---
不要62，经典数位DP，这是记忆化搜索，从高位向低位dfs。详见本文具体内容  

<!-- more -->

# 题目
不要62  

# 限制
Time Limit: 1000/1000 MS (Java/Others)  
Memory Limit: 32768/32768 K (Java/Others)  

# 描述
杭州人称那些傻乎乎粘嗒嗒的人为62（音：laoer）。  
杭州交通管理局经常会扩充一些的士车牌照，新近出来一个好消息，以后上牌照，不再含有不吉利的数字了，这样一来，就可以消除个别的士司机和乘客的心理障碍，更安全地服务大众。  
不吉利的数字为所有含有4或62的号码。例如：  
62315 73418 88914  
都属于不吉利号码。但是，61152虽然含有6和2，但不是62连号，所以不属于不吉利数字之列。  
你的任务是，对于每次给出的一个牌照区间号，推断出交管局今次又要实际上给多少辆新的士车上牌照了。  

# 输入格式
输入的都是整数对$n,m$$(0 \lt n \le m \lt 1000000)$，如果遇到都是0的整数对，则输入结束。  

# 输出格式
对于每个整数对，输出一个不含有不吉利数字的统计个数，该数值占一行位置。  

# 样本
```
1 100
0 0
```
```
80
```

# 思路
数位DP。这是记忆化搜索，从高位向低位dfs。    
首先s数组中存储数字是从低位到高位存储的，比如100，在s数组中就是[0,0,1]这么存的。len是数的位数  
dp[i][0]表示在第i+1位不是6并且低i位没有限制的情况下，低i位中满足条件的数的个数。  
dp[i][1]表示在第i+1位是6并且低i位没有限制的情况下，低i为中满足条件的数的个数。  
dp数组用于记忆化搜索。  
说一下代码吧。  
这道题是求n到m中（含边界数）满足条件的个数，也就是求m以内的满足条件个数，再减去n-1以内满足条件个数。  
说下dfs。pos是当前位数；lim是当前位数的上限值，-1代表没上限，0到9之间的数字代表有上限；prev是高一位的数字是几。  
首先判断边界，pos<0的情况代表找到了一个数，所以要return 1;这个为啥不return 0?自己想一下，return 0的话结果永远都是0了。  
然后判断是不是没限制，即lim==-1并且，dp对应的位置不是0，即之前求过并存储下来了，那么就直接返回。否则就继续求。  
然后就是循环次数了。up是循环次数。  
for循环的意义是对于pos位是各种数字的情况下，继续dfs pos-1位的情况。  
循环中，如果是4那么跳过；如果是2并且上一位是4直接跳过；如果i和lim相等，即这一位到了上限，那么在继续进行dfs的时候，下一位也要注意上限的问题，免得超了，所以要把s[pos-1]作为参数，不然的话，就直接传-1了。  
循环结束后进行记录，如果当前没有上限，即这个值在之后还有利用价值，那么就计入dp，否则，不计入。然后返回这个tmp，tmp是结果。  

# 代码
```c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int n, m;
int s[10];
int len;
int dp[10][2];

int dfs(int pos, int lim, int prev){
    if(pos < 0) return 1;
    if(lim == -1 && dp[pos][prev == 6] != 0) return dp[pos][prev == 6];

    int up = lim==-1?9:lim;

    int tmp = 0;
    for(int i = 0; i <= up; i++){
        if(i == 4) continue;
        if(i == 2 && prev == 6) continue;
        if(i == lim)
            tmp += dfs(pos-1, s[pos-1], i);
        else
            tmp += dfs(pos-1, -1, i);
    }

    if(lim == -1){
        dp[pos][prev == 6] = tmp;
    }

    return tmp;
}

int solve(int num){
    len = 0;
    memset(s, 0, sizeof s);

    while(num > 0){
        s[len++] = num % 10;
        num /= 10;
    }

    return dfs(len-1, s[len-1], -1);
}

int main(){
    while(~scanf("%d %d", &n, &m)){
        if(n == 0 && m == 0) break;
        memset(dp, 0, sizeof dp);

        printf("%d\n", solve(m)-solve(n-1));
    }
    return 0;
}

```