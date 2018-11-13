---
title: hexo-leancloud-counter-security 插件 Too many requests 错误
tags: [Hexo, LeanCloud]
categories: [Hexo]
comments: true
mathjax: false
date: 2018-06-29 13:05:13
---
> 【该问题可能已修复，以下为原文】  

这个插件吧，有点儿不完美，给他改了改，不完美的地方就是，leancloud那边儿没法短时间内接受太多请求。原因是我用的是免费版的，有限制，而hexo-leancloud-counter-security 插件每次发太多无用请求，总是会报429错误，我就给源代码改了改。  

<!-- more -->

# 症状
如果你懒得看解释的话，直接去看修改代码一节。  
每次进行`hexo d`的时候会概率性的出现如下错误：  
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
官方解释如下：  

> 信息 - Too many requests.
> 含义 - 超过应用的流控限制，即超过每个应用同一时刻最多可使用的工作线程数，或者说同一时刻最多可以同时处理的数据请求。通过 控制台 > 存储 > API 统计 > API 性能 > 总览 可以查看应用产生的请求统计数据，如平均工作线程、平均响应时间等。使用 LeanCloud 商用版或企业版 的用户，如有需要，可以联系我们来调整工作线程数。

# 原因
我查看了源代码，`node_modules\hexo-leancloud-counter-security\index.js`这个就是源代码。发现每次进行hexo d的时候，他对每个博文的title和url，向leancloud发送一次查询请求，如果发现leancloud那边儿没有该条记录的话，那么再发送一条插入请求。  
原逻辑如下：  
```javascript
_.forEach(urls, function (x) {
    var query = new AV.Query('Counter');
    query.equalTo('url', x.url);
    query.count().then(function (count) {
        if (count === 0) {
            var counter = new Counter();
            counter.set('url', x.url);
            counter.set('title', x.title);
            counter.set('time', 0);
            counter.save().then(function (obj) {
                log.info(x.title + ' is saved as: ' + obj.id);
            }, function (error) {
                log.error(error);
            });
        }
    }, function (error) {
        log.error(error);
    });
});
```
也就是说，每一次`hexo d`的时候最少的查询次数等于你的博文个数。如果你的leancloud的应用的处理能力不够强大的时候，对于这种高强度的请求，当然会出现Too Many Requests的错误代码。  

# 改进思路
我们要做的就是较少不必要的请求咯。  
本地记录一个title和url的json数组，每次查询这个数组，看看哪些是真正的需要查询的，然后再去查询leancloud。其实可以这样理解，这个本地的数组存储就是leancloud的远程数据库表。  
因为筛除了一些记录，所以每次hexo d时的请求数量仅仅是相比上一次hexo d时候的增量。  

# 修改代码
如果你遇到了问题，看看问题解决一节。  
修改的是`node_modules\hexo-leancloud-counter-security\index.js`这个文件  
hexo-leancloud-counter-security版本是1.3.2  
一共修改下面几处，在代码中已经做了标记。  
代码70-84  
代码87-102  
代码113-117  
代码120-123  
代码126-132  
代码135-138  
代码140-142  
代码225-268  
改完了之后别着急，打开`博客配置文件`找到`skip_render:`这一项，然后加上leancloud_memo.json。不会加的看修改博客配置文件一节。  
```javascript
'use strict';

var _regenerator = require('babel-runtime/regenerator');

var _regenerator2 = _interopRequireDefault(_regenerator);

var _asyncToGenerator2 = require('babel-runtime/helpers/asyncToGenerator');

var _asyncToGenerator3 = _interopRequireDefault(_asyncToGenerator2);

var _stringify = require('babel-runtime/core-js/json/stringify');

var _stringify2 = _interopRequireDefault(_stringify);

var sync = function () {
    var _ref = (0, _asyncToGenerator3.default)( /*#__PURE__*/_regenerator2.default.mark(function _callee() {
        var log, config, APP_ID, APP_KEY, publicDir, UrlsFile, urls, currentUser, userName, passWord, Counter;
        return _regenerator2.default.wrap(function _callee$(_context) {
            while (1) {
                switch (_context.prev = _context.next) {
                    case 0:
                        log = this.log;
                        config = this.config;

                        if (!config.leancloud_counter_security.enable_sync) {
                            _context.next = 19;
                            break;
                        }

                        APP_ID = config.leancloud_counter_security.app_id;
                        APP_KEY = config.leancloud_counter_security.app_key;
                        publicDir = this.public_dir;
                        UrlsFile = pathFn.join(publicDir, 'leancloud_counter_security_urls.json');
                        urls = JSON.parse(fs.readFileSync(UrlsFile, 'utf8'));


                        AV.init({
                            appId: APP_ID,
                            appKey: APP_KEY
                        });

                        currentUser = AV.User.current();

                        if (currentUser) {
                            _context.next = 16;
                            break;
                        }

                        userName = config.leancloud_counter_security.username;
                        passWord = config.leancloud_counter_security.password;

                        if (!userName) {
                            userName = readlineSync.question('Enter your username: ');
                            passWord = readlineSync.question('Enter your password: ', { hideEchoBack: true });
                        } else if (!passWord) {
                            passWord = readlineSync.question('Enter your password: ', { hideEchoBack: true });
                        }
                        _context.next = 16;
                        return AV.User.logIn(userName, passWord).then(function (loginedUser) {
                            log.info('Logined as: ' + loginedUser.getUsername());
                        }, function (error) {
                            log.error(error);
                        });

                    case 16:

                        log.info('Now syncing your posts list to leancloud counter...');
                        Counter = AV.Object.extend('Counter');
                        
                        //----add----
                        urls.sort(cmp);
                        
                        var memoFile = pathFn.join(publicDir, "leancloud_memo.json");
                        if(!fs.existsSync(memoFile)){
                            fs.writeFileSync(memoFile, "[\n]");
                        }
                        var memoData = fs.readFileSync(memoFile, "utf-8").split("\n");
                        var memoIdx = 1;

                        var newData = [];
                        var cnt = 0;
                        var limit = 0;
                        var env = this;
                        //----end----
                        
                        _.forEach(urls, function (x) {
                            //----add----
                            var y = {};
                            y.title = "";
                            y.url = "";
                            
                            var flag = false;
                            while(true){
                                if(memoData[memoIdx] == ']') break;
                                y = JSON.parse(memoData[memoIdx].substring(0, memoData[memoIdx].length-1));
								if(y.url > x.url) break;
                                if(y.url == x.url && y.title == x.title){
                                    flag = true;
                                    break;
                                }
                                memoIdx++;
                            }
                            if(!flag) {
                                log.info("Dealing with record of " + x.title);
                                limit++;
                                //----end----
                                var query = new AV.Query('Counter');
                                query.equalTo('url', x.url);
                                query.count().then(function (count) {
                                    if (count === 0) {
                                        var counter = new Counter();
                                        counter.set('url', x.url);
                                        counter.set('title', x.title);
                                        counter.set('time', 0);
                                        counter.save().then(function (obj) {
                                            log.info(x.title + ' is saved as: ' + obj.id);
                                            //----add----
                                            newData.push(x);
                                            cnt++;
                                            postOperation(env, cnt, limit, newData, memoData);
                                            //----end----
                                        }, function (error) {
                                            log.error(error);
                                            //----add----
                                            cnt++;
                                            postOperation(env, cnt, limit, newData, memoData);
                                            //----end----
                                        });
                                    }
                                    //----add----
                                    else{
                                        newData.push(x);
                                        cnt++;
                                        postOperation(env, cnt, limit, newData, memoData);
                                    }
                                    //----end----
                                }, function (error) {
                                    log.error(error);
                                    //----add----
                                    cnt++;
                                    postOperation(env, cnt, limit, newData, memoData);
                                    //----end----
                                });
                            //----add----
                            }
                            //----end----
                        });

                    case 19:
                    case 'end':
                        return _context.stop();
                }
            }
        }, _callee, this);
    }));

    return function sync() {
        return _ref.apply(this, arguments);
    };
}();

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var AV = require('leancloud-storage');
var _ = require('lodash');
var readlineSync = require('readline-sync');
var packageInfo = require('./package.json');
var pathFn = require('path');
var fs = require('fs');

function generate_post_list(locals) {
    var config = this.config;
    if (config.leancloud_counter_security.enable_sync) {
        var urlsPath = 'leancloud_counter_security_urls.json';
        var urls = [].concat(locals.posts.toArray()).filter(function (x) {
            return x.published;
        }).map(function (x) {
            return { title: x.title, url: '/' + x.path };
        });
        return {
            path: urlsPath,
            data: (0, _stringify2.default)(urls)
        };
    }
}

hexo.extend.generator.register('leancloud_counter_security_generator', generate_post_list);

hexo.extend.deployer.register('leancloud_counter_security_sync', sync);

var commandOptions = {
    desc: packageInfo.description,
    usage: ' <argument>',
    'arguments': [{
        'name': 'register | r <username> <password>',
        'desc': 'Register a new user.'
    }]
};

function commandFunc(args) {
    var log = this.log;
    var config = this.config;

    if (args._.length !== 3) {
        log.error('Too Few or Many Arguments.');
    } else if (args._[0] === 'register' || args._[0] === 'r') {
        var APP_ID = config.leancloud_counter_security.app_id;
        var APP_KEY = config.leancloud_counter_security.app_key;
        AV.init({
            appId: APP_ID,
            appKey: APP_KEY
        });

        var user = new AV.User();
        user.setUsername(String(args._[1]));
        user.setPassword(String(args._[2]));
        user.signUp().then(function (loginedUser) {
            log.info(loginedUser.getUsername() + ' is successfully signed up');
        }, function (error) {
            log.error(error);
        });
    } else {
        log.error('Unknown Command.');
    }
}

hexo.extend.console.register('lc-counter', 'hexo-leancloud-counter-security', commandOptions, commandFunc);

//----add----
function cmp(x, y){
    if(x.url < y.url)
        return -1;
    else if(x.url == y.url)
        return 0;
    else return 1;
}

var postOperation = function (env, cnt, limit, newData, memoData){
    if(cnt == limit){
        var log = env.log;
        newData.sort(cmp);
        var sourceDir = env.source_dir;
        var publicDir = env.public_dir;
        var memoFile = pathFn.join(sourceDir, "leancloud_memo.json");
        fs.writeFileSync(memoFile, "[\n");
        
        var memoIdx = 1;
        for(var i = 0; newData[i]; i++){
            while(true){
                if(memoData[memoIdx] == ']') break;
                var y = JSON.parse(memoData[memoIdx].substring(0, memoData[memoIdx].length-1));
                if(y.url > newData[i].url) break;
                
                fs.writeFileSync(memoFile, memoData[memoIdx] + "\n", {'flag':'a'});
                memoIdx++;
            }
            fs.writeFileSync(memoFile, "{\"title\":\"" + newData[i].title + "\",\"url\":\"" + newData[i].url + "\"},\n", {'flag':'a'});
        }
        while(memoData[memoIdx] != ']'){
            fs.writeFileSync(memoFile, memoData[memoIdx] + "\n", {'flag':'a'});
            memoIdx++;
        }
        fs.writeFileSync(memoFile, memoData[memoIdx], {'flag':'a'});
        
        var srcFile = pathFn.join(sourceDir, "leancloud_memo.json");
        var destFile = pathFn.join(publicDir, "leancloud_memo.json");
        var readStream = fs.createReadStream(srcFile);
        var writeStream = fs.createWriteStream(destFile);
        readStream.pipe(writeStream);
        console.log("leancloud_memo.json successfully updated.");
    }
}
```

# 修改博客配置文件
我们需要将leancloud_memo.json排除，否则的话会被渲染，我那个反正就是被渲染了。  
在`博客配置文件`中找到这个，然后加一项，如下：  
```yaml
skip_render: leancloud_memo.json
```
如果有多个项的话，可以这么加：  
```yaml
skip_render: 
  - 404.html
  - README.md
  - leancloud_memo.json
```

# 关键逻辑
维护memoData和urls数组有序，能够在O(2n)的复杂度内判断出有哪些博文（包括改了题目的，改了文件名的）不在表中。  
最后的memoData和newData也是有序的，产生的新的文件也是有序的。  
详见代码，不做过多解释。  

# 额外代价
分析一下，额外引入的代价。  
时间上的代价：  
* 对urls数组进行排序。O(nlogn)  
* urls数组和memoData数组比较以确定某个记录需要向leancloud查询。O(2n)  
* 排序newData数组。O(nlogn)  
* 将memoData和newData数组整合成一个新的数组。O(2n)  
* 将memoData字符串split成数组一次。  
* 读取memoData一次。  
* 写memoData n次。  
* 拷贝memoData一次。  

空间上的代价：  
* 引入newData数组，O(n)  
* 引入memoData数组，O(n)  
* 引入一个文件leancloud_memo.json  

n是博文的数量，一般的话假设有1万篇，这个额外代价感觉还可以。  

# 最后一行不加注释
为什么不在上面代码最后艺一行加上//----end----？因为加上注释以后会报错。报错如下：  
```
ERROR Plugin load failed: hexo-leancloud-counter-security
E:\code\blog\node_modules\hexo-leancloud-counter-security\index.js:213
}
^

SyntaxError: Unexpected end of input
    at createScript (vm.js:80:10)
    at Object.runInThisContext (vm.js:139:10)
    at fs.readFile.then.script (E:\code\blog\node_modules\hexo\lib\hexo\index.js:230:19)
    at tryCatcher (E:\code\blog\node_modules\bluebird\js\release\util.js:16:23)
    at Promise._settlePromiseFromHandler (E:\code\blog\node_modules\bluebird\js\release\promise.js:512:31)
    at Promise._settlePromise (E:\code\blog\node_modules\bluebird\js\release\promise.js:569:18)
    at Promise._settlePromise0 (E:\code\blog\node_modules\bluebird\js\release\promise.js:614:10)
    at Promise._settlePromises (E:\code\blog\node_modules\bluebird\js\release\promise.js:693:18)
    at Promise._fulfill (E:\code\blog\node_modules\bluebird\js\release\promise.js:638:18)
    at Promise._resolveCallback (E:\code\blog\node_modules\bluebird\js\release\promise.js:432:57)
    at Promise._settlePromiseFromHandler (E:\code\blog\node_modules\bluebird\js\release\promise.js:524:17)
    at Promise._settlePromise (E:\code\blog\node_modules\bluebird\js\release\promise.js:569:18)
    at Promise._settlePromise0 (E:\code\blog\node_modules\bluebird\js\release\promise.js:614:10)
    at Promise._settlePromises (E:\code\blog\node_modules\bluebird\js\release\promise.js:693:18)
    at Promise._fulfill (E:\code\blog\node_modules\bluebird\js\release\promise.js:638:18)
    at E:\code\blog\node_modules\bluebird\js\release\nodeback.js:42:21
    at E:\code\blog\node_modules\graceful-fs\graceful-fs.js:78:16
    at FSReqWrap.readFileAfterClose [as oncomplete] (fs.js:511:3)
ERROR Deployer not found: leancloud_counter_security_sync
```

# 问题解决
如果你在`hexo d`的时候，发现leancloud那边儿没有添加上记录。排除了各种错误之后，还是没有的话。  
你可以把source文件夹下的leancloud_memo.json文件删除，然后重新`hexo clean & hexo g & hexo d`就好了。  