---
title: ACM HDU 4745 题解 区间DP
tags: [ACM, HDU, DP, 区间DP]
categories: [ACM, DP]
comments: true
mathjax: true
date: 2018-06-10 20:47:42
---
Two Rabbits，在一个长度是n的环形序列上，找一个不连续的回文序列的最大长度。详见具体内容  

<!-- more -->

# 题目
Two Rabbits  

# 限制
Time Limit: 10000/5000 MS (Java/Others)  
Memory Limit: 65535/65535 K (Java/Others)  

# 描述
Long long ago, there lived two rabbits Tom and Jerry in the forest. On a sunny afternoon, they planned to play a game with some stones. There were $n$ stones on the ground and they were arranged as a clockwise ring. That is to say, the first stone was adjacent to the second stone and the n-th stone, and the second stone is adjacent to the first stone and the third stone, and so on. The weight of the i-th stone is ai.  
The rabbits jumped from one stone to another. Tom always jumped clockwise, and Jerry always jumped anticlockwise.  
At the beginning, the rabbits both choose a stone and stand on it. Then at each turn, Tom should choose a stone which have not been stepped by itself and then jumped to it, and Jerry should do the same thing as Tom, but the jumping direction is anti-clockwise.  
For some unknown reason, at any time , the weight of the two stones on which the two rabbits stood should be equal. Besides, any rabbit couldn't jump over a stone which have been stepped by itself. In other words, if the Tom had stood on the second stone, it cannot jump from the first stone to the third stone or from the n-the stone to the 4-th stone.  
Please note that during the whole process, it was OK for the two rabbits to stand on a same stone at the same time.   
Now they want to find out the maximum turns they can play if they follow the optimal strategy.  

# 输入格式
The input contains at most $20$ test cases.  
For each test cases, the first line contains a integer $n$ denoting the number of stones.  
The next line contains $n$ integers separated by space, and the i-th integer $a_i$ denotes the weight of the i-th stone.$(1 \le n \le 1000, 1 \le a_i \le 1000)$  
The input ends with $n = 0$.  

# 输出格式
For each test case, print a integer denoting the maximum turns.  

# 样本
```
1
1
4
1 1 2 1
6
2 1 1 2 1 3
0
```
```
1
4
5
```

# 提示
For the second case, the path of the Tom is $1, 2, 3, 4$, and the path of Jerry is $1, 4, 3, 2$.  
For the third case, the path of Tom is $1,2,3,4,5$ and the path of Jerry is $4,3,2,1,5$.  

# 思路一
两个人一个顺时针蹦，一个逆时针蹦。不能超过一圈。每次蹦到的数字都得相同。  
为了保证最大跳数，二人走的路径是重合的。不难证明，如果假设二人走的路不重合，那么就会发现一条新的路径，比原来的路径更长，并且这条路径是重合的。所以二人走的路径是重合的。  
因为二人走的路径是重合的。并且二人是按照相反方向跳的。所以这条路径是回文的。  
这道题转化为，在一个长度是n的环形序列上，找一个不连续的回文序列的最大长度。  
我们先说一种常用的思路，倍增。将序列拷贝一份到后面。变成2n的序列。然后区间DP。dp[a][b]是区间[a,b]内的最长回文子串的长度。dp[a][b]的最长回文子串的长度是从dp[a+1][b],dp[a][b-1]中的最大值。如果num[a]和num[b]相等，那么前面得到的最大值还需要与dp[a+1][b-1]+2比较一下，dp[a][b]取最大值。  
最后的结果是，以0到n-1开头且长度为n的最长回文子序列中，找最大值。找的过程中需要注意一点，就是如果最开始两个兔子不在同一点出发，那么长度就是dp[i][i+n-1]。如果从同一点出发，长度就是dp[i][i+n-2]+1。所以要考虑到从同一点出发，和不同点出发两种情况，找出最大值。  
解释一下代码，20行是对不同的区间长度进行迭代，21行是对区间起始节点进行迭代。33行是对所有的起始节点迭代，然后长度锁定在n-1，34行是从不同节点出发的情况，35行是从同一个节点出发的情况。  

# 代码一
```c++
#include <cstdio>
#include <cstring>
#include <iostream>

using namespace std;

int n;
int num[2005];
int dp[2005][2005];

int main(){
    while(~scanf("%d", &n)){
        if(!n) break;
        for(int i = 0; i < n; i++){
            scanf("%d", &num[i]);
            num[i+n] = num[i];
        }
        memset(dp, 0, sizeof dp);

        for(int i = 0; i < 2*n; i++){
            for(int j = 0; j < 2*n-i; j++){
                if(i == 0) dp[j][j+i] = 1;
                else{
                    dp[j][j+i] = max(dp[j+1][j+i], dp[j][j+i-1]);
                    if(num[j] == num[j+i]){
                        dp[j][j+i] = max(dp[j][j+i], dp[j+1][j+i-1]+2);
                    }
                }
            }
        }

        int res = 0;
        for(int i = 0; i < n; i++){
            res = max(res, dp[i][i+n-1]);
            res = max(res, dp[i][i+n-2]+1);
        }
        printf("%d\n", res);
    }
    return 0;
}

```

# 思路二
题目就是在长度为n的环上，求一个最长的回文子序列的长度。题目是如何转为为这个问题的，请见思路一。  
这个思路主要是划分区间。即，把序列划分成2段。分别求两段的最长回文子序列。这两段回文子序列能够组成一个大的回文子序列。1...2...2...1 | 3...4...4...3...假设前段的最长回文子序列是1221，后段的最长回文子序列是3443。组成的大的回文子序列是43122134。这就是两个兔子跳的路径  
结果就是在n-1个不同划分中，两段最长回文子序列的长度和中，找最大值。  
dp[a][b]是区间[a,b]内的最长回文子串的长度。注意状态转移。dp[a][b]的最长回文子串的长度是从dp[a+1][b],dp[a][b-1]中的最大值。如果num[a]和num[b]相等，那么前面得到的最大值还需要与dp[a+1][b-1]+2比较一下，dp[a][b]取最大值。  
这种结果中已经考虑到了两个兔子从不同出发点出发，相同出发点出发。考虑某个回文串长度是奇数。12321 | 4554，路径可以是541232145，两个回文串都是奇数长度，12321 | 454，路径可以使54123214。这个就是从同一点出发的情况。  
为什么划分成两段，而不是三段，因为三段没法组成大的回文子序列。  
解释一下代码，19行是对不同的区间长度进行迭代，20行是对区间起始节点进行迭代，32行是对不同的划分点进行迭代。  

# 代码二
```c++
#include <cstdio>
#include <cstring>
#include <iostream>

using namespace std;

int n;
int num[1005];
int dp[1005][1005];

int main(){
    while(~scanf("%d", &n)){
        if(!n) break;
        for(int i = 0; i < n; i++){
            scanf("%d", &num[i]);
        }
        memset(dp, 0, sizeof dp);

        for(int i = 0; i < n; i++){
            for(int j = 0; j < n-i; j++){
                if(i == 0) dp[j][j+i] = 1;
                else{
                    dp[j][j+i] = max(dp[j+1][j+i], dp[j][j+i-1]);
                    if(num[j] == num[j+i]){
                        dp[j][j+i] = max(dp[j][j+i], dp[j+1][j+i-1]+2);
                    }
                }
            }
        }

        int res = 1;
        for(int i = 0; i < n-1; i++){
            res = max(res, dp[0][i] + dp[i+1][n-1]);
        }
        printf("%d\n", res);
    }
    return 0;
}

```