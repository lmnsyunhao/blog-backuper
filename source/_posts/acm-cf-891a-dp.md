---
title: ACM CodeForces 891 A 题解 DP
tags: [ACM, CodeForces, DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-06-06 11:28:19
---
Pride，DP题，本题关键就是找到一段最短区间[l,r]，该区间的gcd是1。详见本文内容  

<!-- more -->

# 题目
A. Pride  

# 限制
time limit per test: 2 seconds  
memory limit per test: 256 megabytes  
input: standard input  
output: standard output  

# 描述
You have an array $a$ with length $n$, you can perform operations. Each operation is like this: choose two __adjacent__ elements from $a$, say $x$ and $y$, and replace one of them with $gcd(x,y)$, where gcd denotes the greatest common divisor.  
What is the minimum number of operations you need to make all of the elements equal to $1$?  

# 输入格式
The first line of the input contains one integer $n$$(1 \le n \le 2000)$ — the number of elements in the array.  
The second line contains $n$ space separated integers $a_1,a_2,...,a_n$ $(1 \le a_i \le 10^9)$ — the elements of the array.  

# 输出格式
Print $-1$, if it is impossible to turn all numbers to $1$. Otherwise, print the minimum number of operations needed to make all numbers equal to $1$.  

# 样本
```
5
2 2 3 4 6
```
```
5
```
```
4
2 4 6 8
```
```
-1
```
```
3
2 6 9
```
```
4
```

# 提示
In the first sample you can turn all numbers to 1 using the following 5 moves:  
* $[2,2,3,4,6]$  
* $[2,1,3,4,6]$  
* $[2,1,3,1,6]$  
* $[2,1,1,1,6]$  
* $[1,1,1,1,6]$  
* $[1,1,1,1,1]$  

We can prove that in this case it is not possible to make all numbers one using less than 5 moves.  

# 思路
如果序列中有1的话，结果是n减去1的个数。  
本题关键就是找到一段最短区间[l,r]，该区间的gcd是1，结果是r-l+n-1。r-l是这个区间变出一个1的步数，n-1是变出了一个1之后，将剩余的n-1个数都变成1的步数  
代码中dp[i][j]存储的是区间[i,j]的gcd。dp[i][i]存储的是序列中的数。  
dp数组中只有右上半个数组实际被用到。第25行的i是循环的区间长度，从1到n-1。第26行的j循环的是区间的起始元素。  
递推公式是dp[j][j+i] = gcd(dp[j][j+i-1], dp[j+i][j+i])  
`__gcd(a, b)`是`algorithm`库中的函数  

# 代码
```c++
#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

int n;
int dp[2005][2005];

int main(){
    while(~scanf("%d", &n)){
        memset(dp, 0, sizeof dp);
        int cnt = 0;
        for (int i = 0; i < n; i++){
            scanf("%d", &dp[i][i]);
            if(dp[i][i] == 1){
                cnt++;
            }
        }
        if(cnt > 0){
            printf("%d\n", n-cnt);
        }
        else{
            int ans = 0;
            bool flag = false;
            for (int i = 1; i < n; i++){
                for (int j = 0; j+i < n; j++){
                    dp[j][j+i] = __gcd(dp[j][j+i-1], dp[j+i][j+i]);
                    if(dp[j][j+i] == 1){
                        flag = true;
                        ans = i;
                        break;
                    }
                }
                if(flag) break;
            }
            if(flag)
                printf("%d\n", n-1+ans);
            else
                printf("-1\n");
        }
    }
    return 0;
}

```