---
title: ACM LightOJ 1422 题解 区间DP
tags: [ACM, LightOJ, DP, 区间DP]
categories: [ACM, DP, 区间DP]
comments: true
mathjax: true
date: 2018-06-14 15:19:43
---
Halloween Costumes，区间划分DP。dp[a][b]表示区间[a,b]内最少需要多少件戏服。详见本文内容  

<!-- more -->

# 题目
1422 - Halloween Costumes  

# 限制
Time Limit: 2 second(s)  
Memory Limit: 32 MB  

# 描述
Gappu has a very busy weekend ahead of him. Because, next weekend is Halloween, and he is planning to attend as many parties as he can. Since it's Halloween, these parties are all costume parties, Gappu always selects his costumes in such a way that it blends with his friends, that is, when he is attending the party, arranged by his comic-book-fan friends, he will go with the costume of Superman, but when the party is arranged contest-buddies, he would go with the costume of 'Chinese Postman'.  
Since he is going to attend a number of parties on the Halloween night, and wear costumes accordingly, he will be changing his costumes a number of times. So, to make things a little easier, he may put on costumes one over another (that is he may wear the uniform for the postman, over the superman costume). Before each party he can take off some of the costumes, or wear a new one. That is, if he is wearing the Postman uniform over the Superman costume, and wants to go to a party in Superman costume, he can take off the Postman uniform, or he can wear a new Superman uniform. But, keep in mind that, Gappu doesn't like to wear dresses without cleaning them first, so, after taking off the Postman uniform, he cannot use that again in the Halloween night, if he needs the Postman costume again, he will have to use a new one. He can take off any number of costumes, and if he takes off $k$ of the costumes, that will be the last $k$ ones (e.g. if he wears costume $A$ before costume $B$, to take off $A$, first he has to remove $B$).  
Given the parties and the costumes, find the minimum number of costumes Gappu will need in the Halloween night.  

# 输入格式
Input starts with an integer $T (\le 200)$, denoting the number of test cases.
Each case starts with a line containing an integer $N$ $(1 \le N \le 100)$ denoting the number of parties. Next line contains $N$ integers, where the $i^{th}$ integer $c_i$ $(1 \le c_i \le 100)$ denotes the costume he will be wearing in party $i$. He will attend party 1 first, then party 2, and so on.  

# 输出格式
For each case, print the case number and the minimum number of required costumes.  

# 样本
```
2
4
1 2 1 2
7
1 2 1 1 3 2 1
```
```
Case 1: 3
Case 2: 4
```

# 思路
区间划分DP。dp[a][b]表示区间[a,b]内最少需要多少件戏服。  
对于不同长度的每个区间，dp[a][b]最大是b-a+1，然后对以下情况考虑，选出最小值  
第一，如果区间的两端的戏服是一样的，那么就说明这件戏服在这个区间里可以一直穿着，即dp[a+1][b-1]+1  
第二，对区间进行划分，对于每个划分，选择最小值。min(dp[a][b], dp[a][k]+dp[k+1][b])  
第三，对区间划分的时候，如果中间有个数，等于两端的数。即num[k] == num[b]并且num[k] == num[a]，这种情况下，可以省一件戏服，可以从头穿到尾。所以是dp[a][k]+dp[k+1][b]-1，与dp[a][b]比较，选择最小值  
大概的思路就是这样。  
看下代码，第21行是对区间长度迭代，第22行是对区间起始节点进行迭代，29行是对不同的划分位置进行迭代。  

# 代码
```c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int t;
int n;
int num[105];
int dp[105][105];

int main(){
    while(~scanf("%d", &t)){
        for(int w = 1; w <= t; w++){
            scanf("%d", &n);
            for(int i = 0; i < n; i++){
                scanf("%d", &num[i]);
            }

            memset(dp, 0, sizeof dp);
            for(int i = 0; i < n; i++){
                for(int j = 0; j < n-i; j++){
                    dp[j][j+i] = i+1;

                    if(num[j] == num[j+i]){
                        dp[j][j+i] = min(dp[j][j+i], dp[j+1][j+i-1]+1);
                    }

                    for(int k = j; k < j+i; k++){
                        dp[j][j+i] = min(dp[j][j+i], dp[j][k]+dp[k+1][j+i]);
                        if(k != j && k != j+i && num[k] == num[j] && num[k] == num[j+i]){
                            dp[j][j+i] = min(dp[j][j+i], dp[j][k]+dp[k+1][j+i]-1);
                        }
                    }
                }
            }

            printf("Case %d: %d\n", w, dp[0][n-1]);
        }
    }
    return 0;
}

```