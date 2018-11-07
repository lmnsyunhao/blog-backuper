---
title: ACM CodeForces 963 B 题解 DFS
tags: [ACM, CodeForces, 搜索, DFS]
categories: [ACM, 搜索]
comments: true
mathjax: true
date: 2018-06-09 22:01:07
---
Destruction of a Tree，dfs的题，具体看本文，有详细的解释。  

<!-- more -->

# 题目
B. Destruction of a Tree  

# 限制
time limit per test: 1 second  
memory limit per test: 256 megabytes  
input: standard input  
output: standard output  

# 描述
You are given a tree (a graph with $n$ vertices and $n-1$ edges in which it's possible to reach any vertex from any other vertex using only its edges).  
A vertex can be destroyed if this vertex has even degree. If you destroy a vertex, all edges connected to it are also deleted.  
Destroy all vertices in the given tree or determine that it is impossible.  

# 输入格式
The first line contains integer $n$ $(1 \le n \le 2 \cdot 10^5)$ — number of vertices in a tree.  
The second line contains $n$ integers $p_1,p_2,...,p_n$ $(0 \le p_i \le n)$. If $p_i \ne 0$ there is an edge between vertices $i$ and $p_i$. It is guaranteed that the given graph is a tree.  

# 输出格式
If it's possible to destroy all vertices, print "YES" (without quotes), otherwise print "NO" (without quotes).  
If it's possible to destroy all vertices, in the next $n$ lines print the indices of the vertices in order you destroy them. If there are multiple correct answers, print any.  

# 样本
```
5
0 1 2 1 2
```
```
YES
1
2
3
5
4
```
```
4
0 1 2 3
```
```
NO
```

# 提示
In the first example at first you have to remove the vertex with index $1$ (after that, the edges $(1, 2)$ and $(1, 4)$ are removed), then the vertex with index $2$ (and edges $(2, 3)$ and $(2, 5)$ are removed). After that there are no edges in the tree, so you can remove remaining vertices in any order.  
![提示图片](http://images.yunhao.space/pica/acm-cf-963b-dfs/note.png)

# 思路
首先我们可以知道，n为偶数的情况下，一定是NO，因为n为偶数，总共有奇数条边，每次消除偶数条边，最后一定剩奇数，所以是NO。  
所以我们只需考虑n是奇数情况。我们发现叶子结点的度一定是奇数，所以要想消除叶子节点，我们需要消除叶子节点的父亲。先消除靠近叶子节点的偶数度点，再往根节点的方向靠近，按此方法能够找到可行解。  
我们消除某个节点的所有偶数度的子节点，剩下奇数度子节点要想消除，必须消除该节点。如果此时该节点的度是偶，那么可以消除，如果是奇数，还要消除该节点的父节点之后，才能消除该节点。这是一个递归的思路。用dfs。  
我们用dfs遍历一棵树，遍历过程中用一个栈stk来保存节点之间的约束情况（某个节点的所有偶数度子节点消除之后，才可以消除当前节点，然后消除所有奇数度子节点。消除当前节点时，如果度为偶数，那么直接消除，否则就要等其父节点消除之后才可消除）。这个栈其实保存了消除过程中的拓扑序。  
![例一](http://images.yunhao.space/pica/acm-cf-963b-dfs/normal.png)
比如上图，有21个节点。dfs过程如下，下面的序列显示的是栈stk的情况，左侧为栈底:  
栈：1,2,5,12,13,14,5  
5节点的所有偶度子节点都已经消除了，剩下的奇度子节点都在栈里。5节点再次入栈是因为保证拓扑序列正确。也就是说除了叶子结点之外的节点都需要，在其子节点遍历完毕之后，二次进栈。  
为了消除12,13,14这几个节点，需要消除5节点，看5节点此时有偶数度。5节点是偶数度。可以消除5，所以5的所有奇度子节点也可以消除了。所以栈中两个5之间的都能输出了。输出顺序5,14,13,12。  
栈：1,2
然后继续  
栈：1,2,6,15,16,17,6  
同理，输出6,17,16,15  
栈：1,2,7,18,19,7  
发现节点7没法消除，那么就留在栈里。  
栈：1,2,7,18,19,7,8,20,21,8,2  
发现节点8没法消除，节点2也没法消除。  
栈：1,2,7,18,19,7,8,20,21,8,2,3,9,3  
发现3,4可以消除，输出3,9  
栈：1,2,7,18,19,7,8,20,21,8,2,4,10,11,4,1  
发现4也没法消除，最后到1遍历结束。然后最后1能消除了。所以按照出栈顺序继续输出。1,4,11,10,2,8,21,20,7,19,18  
这就是结果了。5,14,13,12,6,17,16,15,3,9,1,4,11,10,2,8,21,20,7,19,18  
思路大概就是这样  
需要注意的是最后栈里面的要都输出来。然后注意16行要fa！=0。否则的话对于下图这种根节点只有一个孩子的会误判为叶子结点。  
![例二](http://images.yunhao.space/pica/acm-cf-963b-dfs/special.png)

# 代码
```c++
#include <iostream>
#include <cstring>
#include <cstdio>
#include <vector>

using namespace std;

int n, num;
int stk[400005];
int cur;
int cnt[200005];
vector<int> tr[200005];

void dfs(int idx, int fa){
    stk[cur++] = idx;
    if(tr[idx].size() == 1 && fa != 0) return;

    for(int i = 0; i < tr[idx].size(); i++){
        if(tr[idx][i] == fa) continue;
        dfs(tr[idx][i], idx);
    }

    stk[cur++] = idx;
    if(cnt[idx] % 2 == 0){
        printf("%d\n", idx);
        cnt[idx] = -1;
        cnt[fa]--;
        cur--;

        while(cur && stk[cur-1] != idx){
            if(cnt[stk[cur-1]] != -1){
                printf("%d\n", stk[cur-1]);
                cnt[stk[cur-1]] = -1;
            }
            cur--;
        }
        cur--;
    }
}

int main(){
    while(~scanf("%d", &n)){
        for(int i = 1; i <= n; i++) tr[i].clear();
        memset(cnt, 0, sizeof cnt);
        cur = 0;

        for(int i = 1; i <= n; i++){
            scanf("%d", &num);
            if(num != 0){
                cnt[i]++;
                cnt[num]++;
                tr[i].push_back(num);
                tr[num].push_back(i);
            }
        }

        if(n%2==0){
            printf("NO\n");
        }
        else{
            printf("YES\n");
            dfs(1, 0);
            while(cur){
                if(cnt[stk[cur-1]] != -1){
                    printf("%d\n", stk[cur-1]);
                    cnt[stk[cur-1]] = -1;
                }
                cur--;
            }
        }
    }
    return 0;
}

```