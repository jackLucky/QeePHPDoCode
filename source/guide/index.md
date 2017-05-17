---
title: 准备开发环境
date: 2017-05-09 10:40:12
---

# 准备开发环境
本教程假定读者使用 Windows 环境，并且具备 PHP5 和 MySQL 的基本知识。如果要运行本教程的代码，需要有能够正常运行的 Apache2、PHP5 和 MySQL5 环境。对于初学者我们推荐[Wamp](http://www.wampserver.com/en/)集成环境包

## 环境需求
* PHP >= 5.5.9 (其实你不必惊讶，PHP 7 的时代了)
* Apache Rewrite 模块

## 使用Wamp环境包
WampServer 　Wamp就是Windows Apache Mysql PHP集成安装环境，即在window下的apache、php和mysql的服务器软件。PHP扩展、Apache模块，开启/关闭鼠标点点就搞定，再也不用亲自去修改配置文件了，WAMP它会去做。再也不用到处询问php的安装问题了，[Wamp](http://www.wampserver.com/en/)一切都搞定了，这个软件在win平台上使用的较多。

下载Wamp软件后双击安装，可以选择安装任意目录，这里我们选择安装在D盘，安装D:/wamp64/www这个目录就是我们的根目录。
## 安装QeePHP
从https://github.com/jackLucky/qeephp> 下载最新版本的 QeePHP 框架源代码，解压缩放置到可以通过浏览器访问的目录中即可。

例如 http://localhost/ 对应 d:/wamp64/www 目录，那么将 QeePHP 放置在 d:/wamp64/www/qeephp 目录中就可以通过 http://localhost/qeephp/ 访问到 QeePHP 的文件。



