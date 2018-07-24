---
title: ACM CodeForces 1006 B 题解 贪心
tags: [ACM, 贪心, CodeForces]
categories: [ACM, 贪心]
comments: true
mathjax: true
date: 2018-07-24 18:47:59
---
这是一道简单的贪心，在输入的时候记录下前k个最大数。然后在顺序扫一遍序列，将这k个数找出来。每找到一个，就立即划分一组，找到最后一个时，如果后边还有没遍历完的。那么就将剩下的数并到最后一组。  

<!-- more -->

# 题目
B. Polycarp's Practice  

# 限制
time limit per test: 2 seconds  
memory limit per test: 256 megabytes  
input: standard input  
output: standard output  

# 描述
Polycarp is practicing his problem solving skill. He has a list of $n$ problems with difficulties $a_1,a_2,…,a_n$, respectively. His plan is to practice for exactly $k$ days. Each day he has to solve at least one problem from his list. Polycarp solves the problems in the order they are given in his list, he cannot skip any problem from his list. He has to solve all $n$ problems in exactly $k$ days.  
Thus, each day Polycarp solves a contiguous sequence of (consecutive) problems from the start of the list. He can't skip problems or solve them multiple times. As a result, in $k$ days he will solve all the $n$ problems.  
The profit of the $j^{th}$ day of Polycarp's practice is the maximum among all the difficulties of problems Polycarp solves during the $j^{th}$ day (i.e. if he solves problems with indices from $l$ to $r$ during a day, then the profit of the day is $max_{l \le i \le r} a_i$). The total profit of his practice is the sum of the profits over all $k$ days of his practice.  
You want to help Polycarp to get the maximum possible total profit over all valid ways to solve problems. Your task is to distribute all $n$problems between $k$ days satisfying the conditions above in such a way, that the total profit is maximum.  
For example, if $n=8,k=3$ and $a=[5,4,2,6,5,1,9,2]$, one of the possible distributions with maximum total profit is: $[5,4,2],[6,5],[1,9,2]$. Here the total profit equals $5+6+9=20$.  

# 输入格式
The first line of the input contains two integers $n$ and $k$ $(1 \le k \le n \le 2000)$ — the number of problems and the number of days, respectively.  
The second line of the input contains $n$ integers $a_1,a_2,…,a_n$ $(1 \le a_i \le 2000)$ — difficulties of problems in Polycarp's list, in the order they are placed in the list (i.e. in the order Polycarp will solve them).  

# 输出格式
In the first line of the output print the maximum possible total profit.  
In the second line print exactly $k$ positive integers $t_1,t_2,…,t_k$ ($t_1+t_2+⋯+t_k$ must equal $n$), where $t_j$ means the number of problems Polycarp will solve during the $j^{th}$ day in order to achieve the maximum possible total profit of his practice.  
If there are many possible answers, you may print any of them.  

# 样本
```
8 3
5 4 2 6 5 1 9 2
```
```
20
3 2 3
```
```
5 1
1 1 1 1 1
```
```
1
5
```
```
4 2
1 2000 2000 2
```
```
4000
2 2
```

# 提示
The first example is described in the problem statement.  
In the second example there is only one possible distribution.  
In the third example the best answer is to distribute problems in the following way: $[1,2000],[2000,2]$. The total profit of this distribution is $2000+2000=4000$.  

# 思路
这是一道简单的贪心，在输入的时候记录下前k个最大数。然后在顺序扫一遍序列，将这k个数找出来。每找到一个，就立即划分一组，找到最后一个时，如果后边还有没遍历完的。那么就将剩下的数并到最后一组。  
简单说下代码，cnt[i]最开始表示i这个数在序列中出现了几次。第21-36行，minval存的是前k个最大数中最小的那个数。然后这个时候，ret就跟着计算出来了。并且这个时候cnt数组的含义就变了。cnt[i](i>=minval)含义是i这个数还剩几个没找到。这个找没找到是用在后边划分组用的。res数组是用来存储各组的数的个数的。  

# 代码
```c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int n, k;
int num[2010];
int cnt[2010];
int res[2010];

int main(){
    scanf("%d%d", &n, &k);
    memset(cnt, 0, sizeof cnt);
    memset(res, 0, sizeof res);
    for (int i = 0; i < n; i++){
        scanf("%d", &num[i]);
        cnt[num[i]]++;
    }

    int minval = 0;
    int tmp = 0;
    int cur = 2000;
    int ret = 0;
    while(tmp < k){
        while(!cnt[cur])
            cur--;
        tmp += cnt[cur];
        if(tmp >= k){
            cnt[cur] -= tmp-k;
            minval = cur;
        }
        ret += cur*cnt[cur];
        cur--;
    }
    printf("%d\n", ret);

    int rescur = 0;
    for(int i = 0; i < n; i++){
        if(num[i] >= minval && cnt[num[i]]){
            cnt[num[i]]--;
            res[rescur]++;
            if(rescur < k-1)
                rescur++;
        }
        else{
            res[rescur]++;
        }
    }
    for(int i = 0; i <= rescur; i++){
        printf("%d", res[i]);
        i == rescur ? printf("\n") : printf(" ");
    }
    return 0;
}
```