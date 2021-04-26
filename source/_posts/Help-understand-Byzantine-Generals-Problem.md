---
title: 如何理解拜占庭将军问题
date: 2021-04-25 13:37:38
tags:
---

# 介绍
拜占庭将军问题是一个很经典的问题, 但是原论文有一些地方讲解的不够详细, 理解起来比较有难度.

网上有很多对于拜占庭将军进行讨论的文章, 但大多也都不好理解. 

甚至有的时候, 看了文章之后误以为自己懂了, 其实自己根本就没懂.

于是我写下了这篇文章, 解释下我对拜占庭将军问题的理解.

建议看完原论文和其他的解释, 如果还不懂的情况下, 再来阅读这一篇文章. 

# 其他链接

- https://marknelson.us/posts/2007/07/23/byzantine.html
- https://www.doc.ic.ac.uk/~jnm/DistrAlg/Notes/Byzantine-4up-final.pdf
- http://www.mianquan.net/project/alan2lin-byzantine_demo

# 首要目的
- 所有忠臣都能达成一致
- 少数的叛徒不会影响忠臣达成好的决策

# 问题转化
作者将上面的问题给转化为了一个司令和多个部下的问题. 
- 部下里面属于忠臣的所有人都要一致
- 如果司令是忠臣, 那么部下里面属于忠臣的人也要和司令一致

# 口头算法

里面要用到一个迭代, 这个地方很难理解. 下面来解释一下

# 算法解读
- 当OM(0)的时候
> 也就是没有叛徒, 这个时候任何人说的任何事情都可以相信.
比如这个时候当n=10, 1个司令, 9个部下. 司令和9个部下发出命令进攻, 9个部下知道司令不会说谎, 就相信他了. 最后所有人达成了一致, 都去进攻.
- 当OM(1)的时候
> 有1个叛徒. 这个时候有一个人比如司令告诉自己了一个事情的时候, 还不可以相信他, 因为他可能就是那个叛徒. 这个时候要去问问其他人, 司令都和他们说的啥. 最后我就可以拿着手上我这的情报(司令告诉我的信息, 和其他人告诉我的司令告诉他们的信息), 来从中取一个majority作为最终的决定. 
比如一共4个人, 司令是叛徒, 我是个部下. 司令告诉我要进攻, 告诉其他人要撤退. 我通过和其他人的沟通之后, 我手上有的情报就是: 司令告诉我要进攻, 其他2个人都说司令告诉他们要撤退. 我拿着这样的情报就认为那我也撤退吧. 最后3个部下(都是忠臣)都认为要撤退, 也就达成了一致. 
-  当OM(2)的时候
> 有2个叛徒, 假设我是个部下, 并且是个忠臣. 站在忠臣的角度上来看, 当司令告诉了自己一个事情的时候, 还不可以详细那他, 因为司令可能是叛徒. 这个时候就要去问问其他人司令和他们说了什么. 但是这样还不够, 因为有两个叛徒, 所以要再多质疑一层.  
比如一共7个人, 一个司令P1是忠臣, 部下分别是P2, P3, P4, P5, P6, P7. 其中P6和P7是叛徒, 其他部下是忠臣. 司令告诉所有人要进攻(A), 我是P2. 那么我首先搜集了情报就是所有人说的司令说他们要干啥, 得到的信息为(P1->P2 : A, P1->P3 : A, P1-> P4 : A,  P1-> P5 : A, P1 -> P6 : X, P1 -> P7 : Y). 这面`P1-> P3: A`的意思是P3告诉我(P2), P1告诉P3的内容为A. 针对这条(P1->P3)的情报, 我不能就这么相信, 这一条情报P3也告诉了其他的人(P3,P4,P5,P6,P7). 那么我就也问问他们, P3是怎么告诉你的P1->P3这个情报的. 我在这新的一轮里收集到的情报是(P1->P3->P2: A, P1->P3->P4: A, P1-> P4->P5: A, P1->P3->P6 : X, P1->P3->P7: X). 我对这个情报取majority, 我最终认为P1->P3的内容确实是A. 同理我可以确认(P1->P2 : A, P1->P3 : A, P1-> P4 : A,  P1-> P5 : A, P1 -> P6 : X, P1 -> P7 : Y)的情报, 我再从中取majority, 也可以得到结论P1的提案是A. 那么我就用方案A. 同理其他的忠臣也可以得到相同的结论. 获得了一致性.

- 为什么会有迭代
> 我们可以知道当有0个叛徒的时候, 我们需要1轮交互, n-1次人与人的沟通. 
当有1个叛徒的时候, 我们需要2轮交互, 第一轮需要n-1次沟通, 第二轮对于n-1的每个人都需要n-2次沟通, 第二轮一共需要(n-1)\*(n-2)次沟通.
当有2个叛徒的时候, 需要3轮交互, 第一轮要n-1次沟通, 第二轮需要(n-1)\*(n-2)次沟通, 第三轮需要(n-1)\*(n-2)\*(n-3)次交互
第i轮交互的目的是让每一个忠臣能确定信息链(P1->P2-> ... ->Pi )的到底是什么值.
比如如果P1是司令, 我是P2, 一共有n个将军, 4个叛徒. 那么需要5轮交互.
第1轮交互的时候我收到信息(P1) (P1信息链: 代表P1告诉我他说了啥)
第2轮交互的时候我收到信息(P1->P2, P1->P3, P1->P4, ...) (P1->P3信息链 : P3告诉我, P1和他说了啥)
为了验证P1->P3这个信息究竟怎样, 在第3轮我收到信息(P1->P3->P2, P1->P3->P4 ...) (P1->P3->P4信息链, P4告诉我的, P4说P3说P1说了啥)
为了验证P1->P3->P4这个信息究竟是怎样的, 第4轮我收到信息(P1->P3->P4->P5 ...)
为了验证P1->P3->P4->P5这个信息究竟怎样, 第5轮我收到信息(P1->P3->P4->P5->P6 , ...)
发生前四轮交互的时候, 我收到的这些信息链, 我都不能相信, 也就是说我还不知道这些信息链到底应该相信什么值. 而第五轮沟通之后, 我通过第5轮的信息, 取majority可以确定第四轮的P1->P3->P4->P5的值, 第四轮的都确定了, 我就又可以再取majority确定第三轮的P1->P3->P4的值, 第三轮的确定后我再取majority确定第二轮的值 P1->P3, 第二轮的也确定后, 我就可以再取majority确定P1的值. 这个就是我最后会决定使用的值.

# 举例子










 















