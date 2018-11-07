---
title: ACM POJ 2342 题解 树形DP
tags: [ACM, POJ, DP, 树形DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-06-10 00:31:47
---
Anniversary party，树形DP。就是在树上做DP。详见本文具体内容  

<!-- more -->

# 题目
Anniversary party  

# 限制
Time Limit: 1000MS  
Memory Limit: 65536K  

# 描述
There is going to be a party to celebrate the 80-th Anniversary of the Ural State University. The University has a hierarchical structure of employees. It means that the supervisor relation forms a tree rooted at the rector V. E. Tretyakov. In order to make the party funny for every one, the rector does not want both an employee and his or her immediate supervisor to be present. The personnel office has evaluated conviviality of each employee, so everyone has some number (rating) attached to him or her. Your task is to make a list of guests with the maximal possible sum of guests' conviviality ratings.  

# 输入格式
Employees are numbered from $1$ to $N$. A first line of input contains a number $N$. $1 \le N \le 6000$. Each of the subsequent $N$ lines contains the conviviality rating of the corresponding employee. Conviviality rating is an integer number in a range from $-128$ to $127$. After that go $N – 1$ lines that describe a supervisor relation tree. Each line of the tree specification has the form:   
L K  
It means that the K-th employee is an immediate supervisor of the L-th employee. Input is ended with the line  
0 0  

# 输出格式
Output should contain the maximal sum of guests' ratings.  

# 样本
```
7
1
1
1
1
1
1
1
1 3
2 3
6 4
7 4
4 5
3 5
0 0
```
```
5
```

# 思路
树形DP。就是在树上做DP。  
dp[i][0]代表以i节点为根的子树，在不取i节点的情况下，能够得到的最大的欢乐值。  
dp[i][1]代表以i节点为根的子树，在取i节点的情况下，能够得到的最大的欢乐值。  
最后输出根节点的dp[root][0]和dp[root][1]的最大值。以哪个节点开始遍历树，哪个节点就是根节点。  

# 代码
```c++
#include <iostream>
#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

int n, l, k;
int val[6005];
vector<int> tr[6005];
int dp[6005][2];

void dfs(int idx, int fa){
    dp[idx][0] = 0;
    dp[idx][1] = val[idx];

    if(tr[idx].size() == 1 && fa != 0) return;

    for(int i = 0; i < tr[idx].size(); i++){
        if(tr[idx][i] == fa) continue;
        dfs(tr[idx][i], idx);
    }

    for(int i = 0; i < tr[idx].size(); i++){
        if(tr[idx][i] == fa) continue;
        dp[idx][0] += max(dp[tr[idx][i]][0], dp[tr[idx][i]][1]);
        dp[idx][1] += dp[tr[idx][i]][0];
    }
}

int main(){
    while(~scanf("%d", &n)){
        for(int i = 1; i <= n; i++) tr[i].clear();
        memset(dp, 0, sizeof dp);

        for(int i = 1; i <= n; i++){
            scanf("%d", &val[i]);
        }
        while(scanf("%d %d", &l, &k)){
            if(l == 0 && k == 0) break;
            tr[l].push_back(k);
            tr[k].push_back(l);
        }

        dfs(1, 0);
        printf("%d\n", max(dp[1][0], dp[1][1]));
    }
    return 0;
}

```