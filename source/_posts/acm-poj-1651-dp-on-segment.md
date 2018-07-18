---
title: ACM POJ 1651 题解 区间DP
tags: [ACM, POJ, DP, 区间DP]
categories: [ACM, DP, 区间DP]
comments: true
mathjax: true
date: 2018-06-11 13:33:38
---
Multiplication Puzzle，划分区间DP。无条件划分区间。详见本文具体内容  

<!-- more -->

# 题目
Multiplication Puzzle  

# 限制
Time Limit: 1000MS  
Memory Limit: 65536K  

# 描述
The multiplication puzzle is played with a row of cards, each containing a single positive integer. During the move player takes one card out of the row and scores the number of points equal to the product of the number on the card taken and the numbers on the cards on the left and on the right of it. It is not allowed to take out the first and the last card in the row. After the final move, only two cards are left in the row.   
The goal is to take cards in such order as to minimize the total number of scored points.   
For example, if cards in the row contain numbers 10 1 50 20 5, player might take a card with 1, then 20 and 50, scoring  
$$10 \times 15 \times 0 + 50 \times 20 \times 5 + 10 \times 50 \times 5 = 500+5000+2500 = 8000$$  
If he would take the cards in the opposite order, i.e. 50, then 20, then 1, the score would be   
$$1 \times 50 \times 20 + 1 \times 20 \times 5 + 10 \times 1 \times 5 = 1000+100+50 = 1150$$  

# 输入格式
The first line of the input contains the number of cards $N$ $(3 \le N \le 100)$. The second line contains $N$ integers in the range from $1$ to $100$, separated by spaces.  

# 输出格式
Output must contain a single integer - the minimal score.  

# 样本
```
6
10 1 50 50 20 5
```
```
3650
```

# 思路
划分区间DP。无条件划分区间。dp[a][b]是区间[a,b]的最小的分值。  
举个例子。序列$1,2,3,4,5$，这就是取$2,3,4$这三个，一共有$6$种组合方式：  

* $2,3,4: \quad 1 \times 2 \times 3+1 \times 3 \times 4+1 \times 4 \times 5$  
* $2,4,3: \quad 1 \times 2 \times 3+3 \times 4 \times 5+1 \times 3 \times 5$  
* $3,2,4: \quad 2 \times 3 \times 4+1 \times 2 \times 4+1 \times 4 \times 5$  
* $3,4,2: \quad 2 \times 3 \times 4+2 \times 4 \times 5+1 \times 2 \times 5$  
* $4,2,3: \quad 3 \times 4 \times 5+1 \times 2 \times 3+1 \times 3 \times 5$  
* $4,3,2: \quad 3 \times 4 \times 5+2 \times 3 \times 5+1 \times 2 \times 5$  

也就是说$1,2,3,4,5$的最小分值是从这$6$个组合方式中计算出的。  
现在考虑区间划分。  
第一，划分成$[1,2],[2,3,4,5]$两段，$[1,2]$序列中没法计算最小分值，所以考虑序列$[2,3,4,5]$，这个区间的最小分值是从下面这两个序列中计算出来的。  
$3,4: \quad 2 \times 3 \times 4+2 \times 4 \times 5$  
$4,3: \quad 3 \times 4 \times 5+2 \times 3 \times 5$  
与原序列相比，2这个数字还没有移除，我们在后边加上2移除时候的值，得到：  
$3,4,2: \quad 2 \times 3 \times 4+2 \times 4 \times 5+1 \times 2 \times 5$  
$4,3,2: \quad 3 \times 4 \times 5+2 \times 3 \times 5+1 \times 2 \times 5$  
  
第二，划分成$[1,2,3][3,4,5]$两段，$[1,2,3]$序列的最小分值就是将2移除时的分值，$[3,4,5]$序列的最小分值就是将4移除时的分值。所以，我们可以得到这样两个式子：  
$2,4: \quad 1 \times 2 \times 3+3 \times 4 \times 5$  
$4,2: \quad 3 \times 4 \times 5+1 \times 2 \times 3$  
与原序列相比，3这个数字还没有移除，我们在后边再加上3移除时候的值，得到：  
$2,4,3: \quad 1 \times 2 \times 3+3 \times 4 \times 5+1 \times 3 \times 5$  
$4,2,3: \quad 3 \times 4 \times 5+1 \times 2 \times 3+1 \times 3 \times 5$  
  
第三，划分成$[1,2,3,4][4,5]$两段，同理，我们可以得到下面两个：  
$2,3: \quad 1 \times 2 \times 3+1 \times 3 \times 4$  
$3,2: \quad 2 \times 3 \times 4+1 \times 2 \times 4$  
与原序列相比，4还没移除，将4移除。
$2,3,4: \quad 1 \times 2 \times 3+1 \times 3 \times 4+1 \times 4 \times 5$  
$3,2,4: \quad 2 \times 3 \times 4+1 \times 2 \times 4+1 \times 4 \times 5$  
  
可以看出，拆成了小区间之后，两个小区间的情况再加上边界的数移除的值，就是大区间的所有情况。  
大概就是这样，我们能看到了整体和局部的关系。这样的话，就可以用划分区间DP了。大区间的解可以从小区间的解中推到出来。上面的例子说明了，大区间求最小值可以拆成小区间，从小区间的最小值中构造出来。  
解释一下代码，18行对区间长度进行迭代，19行对区间起始节点进行迭代，20行对一个区间的不同划分点进行迭代。转移规则就是在所有划分中取最小值，对于某一个划分的值等于，两个小区间的dp值再加上边界数移除的值。  
代码中dp默认赋值为0, 所以22行要直接赋值一下，不然最小值永远都是0了，因为序列中所有的数是整数，最小值一定比0大。  

# 代码
```c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

int n;
int num[105];
int dp[105][105];

int main(){
    while(~scanf("%d", &n)){
        for(int i = 0; i < n; i++){
            scanf("%d", &num[i]);
        }
        memset(dp, 0, sizeof dp);

        for(int i = 2; i < n; i++){
            for(int j = 0; j < n-i; j++){
                for(int k = j+1; k < j+i; k++){
                    if(dp[j][j+i] == 0)
                        dp[j][j+i] = dp[j][k]+dp[k][j+i]+num[j]*num[k]*num[j+i];
                    else
                        dp[j][j+i] = min(dp[j][j+i], dp[j][k]+dp[k][j+i]+num[j]*num[k]*num[j+i]);
                }
            }
        }

        printf("%d\n", dp[0][n-1]);
    }
    return 0;
}

```