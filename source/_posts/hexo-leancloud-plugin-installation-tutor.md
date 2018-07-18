---
title: Hexo NexT 主题 LeanCloud 插件安装教程
tags: [Hexo, LeanCloud, NexT]
categories: [Hexo]
comments: true
mathjax: false
date: 2018-06-27 21:13:51
---
记录一次大折腾。LeanCLoud这个是记录单篇博文阅读量的一个东西，之前配过一次，没这么难，这次学习了之后，发现这个东西还是挺麻烦的。多配几次就不麻烦了。mark一下。  

<!-- more -->

# LeanCloud
LeanCloud能够给每篇博客统计访问量的工具。  
首先注册，并登陆[LeanCloud](https://leancloud.cn)。  
注意：登陆密码要求还得有大写英文字母，小写英文字母，还有数字。  

# 膜拜大佬
这篇博客是学习两位大佬，[DoubleMine](https://notes.wanghao.work/2015-10-21-%E4%B8%BANexT%E4%B8%BB%E9%A2%98%E6%B7%BB%E5%8A%A0%E6%96%87%E7%AB%A0%E9%98%85%E8%AF%BB%E9%87%8F%E7%BB%9F%E8%AE%A1%E5%8A%9F%E8%83%BD.html#%E9%85%8D%E7%BD%AELeanCloud)和[leaferx](https://leaferx.online/2018/02/11/lc-security/)，的博文之后写的  

# 应用配置
进入控制台后，我们先创建一个应用。点击创建应用  
![创建应用](/images/hexo-leancloud-plugin-installation-tutor/1.png)
然后弹出如下窗口：起名字，选择开发版，之后点击创建按钮  
![创建应用](/images/hexo-leancloud-plugin-installation-tutor/2.png)
创建完之后，我们看到下面这样。然后点击右上角的设置  
![应用设置](/images/hexo-leancloud-plugin-installation-tutor/3.png)
进入之后，我们点击存储，创建Class，弹出的对话框中名字要写`Counter`，必须写Counter是因为需要和NexT主题兼容。然后ACL权限选择无限制，不然容易统计次数不正常。最后点击创建Class按钮。  
![创建Class](/images/hexo-leancloud-plugin-installation-tutor/4.png)
创建Class的时候容易出现这个问题，如下图，刷新几次，就好了。  
![问题](/images/hexo-leancloud-plugin-installation-tutor/5.png)
现在获取应用ID和应用Key。设置，应用key。  
![ID和Key](/images/hexo-leancloud-plugin-installation-tutor/6.png)

# 主题配置
我们把LeanCloud的应用ID和应用Key写到`主题配置文件`中了，注意此时是`主题的配置文件config.yml`，找到文件中对应位置，并修改成如下：  
```yaml
# Show number of visitors to each article.
# You can visit https://leancloud.cn get AppID and AppKey.
leancloud_visitors:
  enable: true
  app_id: 填写
  app_key: 填写
  # Dependencies: https://github.com/theme-next/hexo-leancloud-counter-security
  # If you don't care about security in lc counter and just want to use it directly
  # (without hexo-leancloud-counter-security plugin), set the `security` to `false`.
  security: true
  betterPerformance: true
```
enable写成true。把`app_id`和`app_key`填上去。然后注意下面，如果没有安装hexo-leancloud-counter-security插件的话，security就填写false。betterPerformance是能够让阅读次数加载更快一些，但是显示的实际数值可能不够准确。  
配置完了之后，`hexo d`一下，然后看看是否生效。之前的话应该就能生效了，但是现在好像不行了。如果不能生效请继续看。  

# Counter类未初始化问题
如果你看到这里了，应该就是发现，计数功能无效。可能会出现下面的问题。Counter类未初始化。  
![Counter类未初始化](/images/hexo-leancloud-plugin-installation-tutor/7.png)
然后它提示我们看F12的Console，显示信息如下：  
![F12Console](/images/hexo-leancloud-plugin-installation-tutor/8.png)

# hexo-leancloud-counter-security插件的安装与配置
打开`主题配置文件`，确保刚刚的那个security已经设置为true。如下：  
```yaml
# Show number of visitors to each article.
# You can visit https://leancloud.cn get AppID and AppKey.
leancloud_visitors:
  enable: true
  app_id: 填写
  app_key: 填写
  # Dependencies: https://github.com/theme-next/hexo-leancloud-counter-security
  # If you don't care about security in lc counter and just want to use it directly
  # (without hexo-leancloud-counter-security plugin), set the `security` to `false`.
  security: true
  betterPerformance: true
```
打开CMD，然后切换到博客的根目录。执行下面命令，以安装hexo-leancloud-counter-security插件  
```bash
npm install hexo-leancloud-counter-security --save
```
等待安装结束之后，我们注册一个用户。命令如下：  
```bash
hexo lc-counter r 用户名 密码
```
用户名，密码两处用你自己起好的名字和密码替换。不用和LeanCloud的登陆名和登陆密码一样。这个用于deploy的时候输入。  
然后打开`博客配置文件`。注意是博客的配置文件。  
```yaml
leancloud_counter_security:
  enable_sync: true
  app_id: <<your app id>>
  app_key: <<your app key>
  username: <<your username>> #如留空则将在部署时询问
  password: <<your password>> #建议留空以保证安全性，如留空则将在部署时询问
```
然后在`博客配置文件`中找到`deploy:`，在deploy下边添加一个。如下：  
```yaml
deploy:
  - type: leancloud_counter_security_sync
```
之后去LeanCloud查看_User表中是否已经添加刚才的用户，点击存储，_User，看是否多一条记录，如下：  
![查看用户](/images/hexo-leancloud-plugin-installation-tutor/9.png)
然后对Counter表设置权限，点击存储，Counter，其他，权限设置。如下：  
![设置权限](/images/hexo-leancloud-plugin-installation-tutor/10.png)
然后弹出对话框，点击add_fields，指定用户，输入刚才用户，点击添加，  
![add_fields权限](/images/hexo-leancloud-plugin-installation-tutor/11.png)
添加成功能够看到两处不同，用户ID已经上去了。  
![添加成功](/images/hexo-leancloud-plugin-installation-tutor/12.png)
接下来，我们同样对create进行指定用户。  
![create权限](/images/hexo-leancloud-plugin-installation-tutor/13.png)
然后，对delete指定用户，这个注意，不添加任何用户。然后关闭。  
![delete权限](/images/hexo-leancloud-plugin-installation-tutor/14.png)
这就设置好了。每次运行`hexo d`的时候，会扫描所有的博客，对于新的博客，Counter表里没有记录的时候，会新建一条记录。如果博客的配置文件中username和password那块儿留空的话，hexo d的时候需要手动输入密码。  
然后我们`hexo d`一下。看看效果。  

# 同时部署git和leancloud的问题
如果没出现这个问题，就跳过这一节  
如果你的`博客配置文件`中的deploy已经有一个git的了，那么可能会出现下边的问题。  
```
FATAL bad indentation of a mapping entry at line 86, column 3:
      - type: leancloud_counter_securi ...
      ^
YAMLException: bad indentation of a mapping entry at line 86, column 3:
      - type: leancloud_counter_securi ...
      ^
    at generateError (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:165:10)
    at throwError (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:171:9)
    at readBlockMapping (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1080:7)
    at composeNode (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1332:12)
    at readDocument (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1492:3)
    at loadDocuments (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1548:5)
    at Object.load (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1569:19)
    at Hexo.yamlHelper (E:\code\blog\node_modules\hexo\lib\plugins\renderer\yaml.js:7:15)
    at Hexo.tryCatcher (E:\code\blog\node_modules\bluebird\js\release\util.js:16:23)
    at Hexo.<anonymous> (E:\code\blog\node_modules\bluebird\js\release\method.js:15:34)
    at Promise.then.text (E:\code\blog\node_modules\hexo\lib\hexo\render.js:61:21)
    at tryCatcher (E:\code\blog\node_modules\bluebird\js\release\util.js:16:23)
    at Promise._settlePromiseFromHandler (E:\code\blog\node_modules\bluebird\js\release\promise.js:512:31)
    at Promise._settlePromise (E:\code\blog\node_modules\bluebird\js\release\promise.js:569:18)
    at Promise._settlePromise0 (E:\code\blog\node_modules\bluebird\js\release\promise.js:614:10)
    at Promise._settlePromises (E:\code\blog\node_modules\bluebird\js\release\promise.js:693:18)
    at Async._drainQueue (E:\code\blog\node_modules\bluebird\js\release\async.js:133:16)
    at Async._drainQueues (E:\code\blog\node_modules\bluebird\js\release\async.js:143:10)
    at Immediate.Async.drainQueues (E:\code\blog\node_modules\bluebird\js\release\async.js:17:14)
    at runCallback (timers.js:794:20)
    at tryOnImmediate (timers.js:752:5)
    at processImmediate [as _immediateCallback] (timers.js:729:5)
```
```
FATAL duplicated mapping key at line 86, column 3:
      type: leancloud_counter_security ...
      ^
YAMLException: duplicated mapping key at line 86, column 3:
      type: leancloud_counter_security ...
      ^
    at generateError (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:165:10)
    at throwError (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:171:9)
    at storeMappingPair (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:308:7)
    at readBlockMapping (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1071:9)
    at composeNode (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1332:12)
    at readBlockMapping (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1062:11)
    at composeNode (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1332:12)
    at readDocument (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1492:3)
    at loadDocuments (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1548:5)
    at Object.load (E:\code\blog\node_modules\js-yaml\lib\js-yaml\loader.js:1569:19)
    at Hexo.yamlHelper (E:\code\blog\node_modules\hexo\lib\plugins\renderer\yaml.js:7:15)
    at Hexo.tryCatcher (E:\code\blog\node_modules\bluebird\js\release\util.js:16:23)
    at Hexo.<anonymous> (E:\code\blog\node_modules\bluebird\js\release\method.js:15:34)
    at Promise.then.text (E:\code\blog\node_modules\hexo\lib\hexo\render.js:61:21)
    at tryCatcher (E:\code\blog\node_modules\bluebird\js\release\util.js:16:23)
    at Promise._settlePromiseFromHandler (E:\code\blog\node_modules\bluebird\js\release\promise.js:512:31)
    at Promise._settlePromise (E:\code\blog\node_modules\bluebird\js\release\promise.js:569:18)
    at Promise._settlePromise0 (E:\code\blog\node_modules\bluebird\js\release\promise.js:614:10)
    at Promise._settlePromises (E:\code\blog\node_modules\bluebird\js\release\promise.js:693:18)
    at Async._drainQueue (E:\code\blog\node_modules\bluebird\js\release\async.js:133:16)
    at Async._drainQueues (E:\code\blog\node_modules\bluebird\js\release\async.js:143:10)
    at Immediate.Async.drainQueues (E:\code\blog\node_modules\bluebird\js\release\async.js:17:14)
```
这个问题，很简单，就是博客配置文件中deploy的那个位置，没写明白。如何让git和leancloud同时部署呢，如下：  
```yaml
deploy:
  - 
    type: git
    repository: git@github.com:lmnsyunhao/lmnsyunhao.github.io.git
    branch: master
  -
    type: leancloud_counter_security_sync
```
这样写就行了。具体为啥这样写，简单学习一下YAML语法就好了。不做赘述  

# 部署过程中leancloud过多请求问题
如果没出现这个问题就跳过这一节。  
`deploy d`的过程中，还可能出现这个问题。看描述是请求过多。如下：  
```
ERROR Too many requests. [429 POST https://xtppdvlr.api.lncld.net/1.1/classes/Counter]
Error: Too many requests. [429 POST https://xtppdvlr.api.lncld.net/1.1/classes/Counter]
    at E:\code\blog\node_modules\leancloud-storage\dist\node\request.js:163:17
    at tryCatch (E:\code\blog\node_modules\es6-promise\dist\es6-promise.js:410:12)
    at invokeCallback (E:\code\blog\node_modules\es6-promise\dist\es6-promise.js:425:13)
    at publish (E:\code\blog\node_modules\es6-promise\dist\es6-promise.js:399:7)
    at publishRejection (E:\code\blog\node_modules\es6-promise\dist\es6-promise.js:340:3)
    at flush (E:\code\blog\node_modules\es6-promise\dist\es6-promise.js:128:5)
    at _combinedTickCallback (internal/process/next_tick.js:131:7)
    at process._tickCallback (internal/process/next_tick.js:180:9)
```
> 信息 - Too many requests.
> 含义 - 超过应用的流控限制，即超过每个应用同一时刻最多可使用的工作线程数，或者说同一时刻最多可以同时处理的数据请求。通过 控制台 > 存储 > API 统计 > API 性能 > 总览 可以查看应用产生的请求统计数据，如平均工作线程、平均响应时间等。使用 LeanCloud 商用版或企业版 的用户，如有需要，可以联系我们来调整工作线程数。

以上是LeanCloud官方解释。  
这个就是你第一次部署的时候，你的博文太多了，leancloud那边儿收不过来。  
但是慢慢的我发现，在LeanCloud控制台那边儿所有的博文都已经有对应的记录了，但是每次`hexo d`时候还是报错，那是因为请求太快了。我查看了一下hexo-leancloud-counter-security的源代码，发现源代码中每次请求都会把所有博文的记录逐条查询。所以，我改了改源代码，详见[hexo-leancloud-counter-security过多请求错误](/2018/06/29/hexo-leancloud-counter-security-too-many-requests-error/)  

# 查看记录
这里能够查看记录。  
`time`就是阅读次数。这里可以直接改实现骚操作。  
`title`，`url`和`createdAt`字段不要乱改，不然容易出现问题。  
![查看记录](/images/hexo-leancloud-plugin-installation-tutor/22.png)

# 安全中心保护
点击设置，安全中心，Web安全域名。这个保证只有对应域名传过来的才有效，也就是说，别人用你的应用ID和应用Key是无效的。  
![安全中心保护](/images/hexo-leancloud-plugin-installation-tutor/15.png)

# 云引擎保护
云引擎保护访客数量不被随意篡改。  
点击云引擎，部署，在线编辑。  
![在线编辑](/images/hexo-leancloud-plugin-installation-tutor/16.png)
然后点击创建函数。  
![创建函数](/images/hexo-leancloud-plugin-installation-tutor/17.png)
弹出的框中，选择Hook，beforeUpdate，Counter，函数内填写如下：  
```javascript
var query = new AV.Query("Counter");
if (request.object.updatedKeys.indexOf('time') !== -1) {
    return query.get(request.object.id).then(function (obj) {
        if (obj.get("time") + 1 !== request.object.get("time")) {
            throw new AV.Cloud.Error('Invalid update!');
        }
    })
}
```
然后点击保存。  
![Counter函数定义](/images/hexo-leancloud-plugin-installation-tutor/18.png)
之后，我们能看到已经多了一个函数，然后点击上边的部署。  
![部署](/images/hexo-leancloud-plugin-installation-tutor/19.png)
弹出对话框，点击部署  
![部署确认](/images/hexo-leancloud-plugin-installation-tutor/20.png)
等待，直到部署完成，如下：  
![部署完成](/images/hexo-leancloud-plugin-installation-tutor/21.png)
