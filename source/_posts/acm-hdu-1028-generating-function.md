---
title: ACM HDU 1028 题解 母函数 生成函数
tags: [ACM, HDU, 组合数学, 母函数]
categories: [ACM, 组合数学, 母函数]
comments: true
mathjax: true
date: 2018-06-05 13:29:48
---
Ignatius and the Princess III，普通母函数题，也叫生成函数。整数拆分。打表做。详见本文具体内容  

<!-- more -->

# 题目
Ignatius and the Princess III  

# 限制
Time Limit: 2000/1000 MS (Java/Others)  
Memory Limit: 65536/32768 K (Java/Others)  

# 描述
"Well, it seems the first problem is too easy. I will let you know how foolish you are later." feng5166 says.  
"The second problem is, given an positive integer $N$, we define an equation like this:  
$N=a[1]+a[2]+a[3]+...+a[m];$  
$a[i]>0,$$1<=m<=N;$  
My question is how many different equations you can find for a given $N$.  
For example, assume $N$ is $4$, we can find:  
$4 = 4;$  
$4 = 3 + 1;$  
$4 = 2 + 2;$  
$4 = 2 + 1 + 1;$  
$4 = 1 + 1 + 1 + 1;$  
so the result is $5$ when $N$ is $4$. Note that "$4 = 3 + 1$" and "$4 = 1 + 3$" is the same in this problem. Now, you do it!"

# 输入格式
The input contains several test cases. Each test case contains a positive integer $N$$(1 \le N \le 120)$ which is mentioned above. The input is terminated by the end of file.  

# 输出格式
For each test case, you have to output a line contains an integer $P$ which indicate the different equations you have found.  

# 样本
```
4
10
20
```
```
5
42
627
```

# 思路
普通母函数题，也叫生成函数。整数拆分。打表做。先打出0到120的表。然后直接输出。  
应用到的母函数公式  
$$G(x)=(1+x+x^2+...)(1+x^2+x^4+...)(1+x^3+x^6+...)...(1+x^n+x^{2n}+...)$$  
母函数公式如何套用，详见本人博客母函数详解  

# 代码
```c++
#include <cstdio>
#include <cstring>

using namespace std;

int n;
int num1[125];
int num2[125];

int main(){
    memset(num1, 0, sizeof num1);
    memset(num2, 0, sizeof num2);
    for(int i = 0; i < 125; i++){
        num1[i] = 1;
    }
    for(int i = 2; i <= 120; i++){
        for(int j = 0; j <= 120; j++){
            for (int k = 0; k+j <= 120; k += i){
                num2[k+j] += num1[j];
            }
        }
        for(int j = 0; j <= 120; j++){
            num1[j] = num2[j];
            num2[j] = 0;
        }
    }
    while(~scanf("%d", &n)){
        printf("%d\n", num1[n]);
    }
}

```