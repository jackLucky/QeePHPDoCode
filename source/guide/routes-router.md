---
title: URL 路由是什么
date: 2017-05-09 10:40:12
---

# URL 路由是什么
正如我们看到的，todo 应用现在产生的 URL 地址都很丑陋，既不便于记忆，也不便于被搜索引擎收录。所以我们需要对 URL 进行美化。

传统的做法是通过编写 .htaccess 这样的文件来添加大量规则实现 URL 的美化，例如 Discuz 的 .htaccess 内容：


```
RewriteRule ^/bbs/archiver/((fid|tid)-[\w\-]+\.html)$ /bbs/archiver/index.php?$1 [L]
RewriteRule ^/bbs/forum-([0-9]+)-([0-9]+)\.html$ /bbs/forumdisplay.php?fid=$1&page=$2 [L]
RewriteRule ^/bbs/thread-([0-9]+)-([0-9]+)-([0-9]+)\.html$ /bbs/viewthread.php?tid=$1&extra=page\%3D$3&page=$2 [L]
RewriteRule ^/bbs/space-(username|uid)-(.+)\.html$ /bbs/space.php?$1=$2 [L]
RewriteRule ^/bbs/tag-(.+)\.html$ /bbs/tag.php?name=$1 [L]
RewriteRule ^/bbs/(.*)$ /bbs/$1 [L]
```


这样做的主要坏处有几个：

1. 应用程序内部生成的地址还是不友好，例如 Discuz 即便启用了 URL 重写，发表一篇新主题后的 URL 仍然会变成传统地址
2. 如果将 URL 地址硬编码到应用程序中，一旦修改了规则，则相应的代码、模板都要修改
3. 如果应用要兼容不支持 URL 重写的服务器环境，那工作量简直是一种噩梦


## 革命性的 URL 路由
QeePHP 是全世界第一个实现 URL 路由完全双向解析的开发框架。

开发者利用这项独一无二的能力，完全不用在编码时考虑 URL 的美化问题。只要启用 URL 路由功能，并写好路由规则，一切就由 QeePHP 框架来完成了。

* 在支持 URL 重写或 PATHINFO 的服务器环境中，基于 QeePHP 的应用能够获得美化后的 URL 地址
* 在不支持 URL 重写和 PATHINFO 的服务器环境中，QeePHP 会自动生成传统的 URL 地址，保证应用程序正常运行

也就是说，服务器环境的变化只需要我们改一下配置文件（只改一行）就可以适应了。而在编码和创建视图时，根本不需要为不同环境下的 URL 地址问题操心。

实现这种幸福状态的关键就是 QeePHP 的 URL 路由双向解析。

## 正向解析
通过浏览器访问诸如 http://qeephp.com/projects/qeephp 这样的 URL 时，实际访问的是 projects 控制器的 show 动作，并且附带了参数 name=qeephp。

将这样一个 URL 解析为 MVC 模式需要的控制器名和动作名参数的过程称为正向解析。这个功能在大多数框架中都具备，只是强弱问题。

## 反向解析
在前面章节中反复出现的一个函数 url() 是专门用来自动创建 URL 地址的函数。这个函数接受两个参数：UDI 和可选参数。UDI 用一种规范的形式指定了这个 URL 将要调用的控制器、动作，而可选参数则会附加在 URL 中进行传递。

在应用程序的 URL 路由没有启动时，url() 的效果如下：


```php
url('tasks/create')
// 结果为 index.php?controller=tasks&action=create
 
url('tasks/edit', array('task_id' => 2))
// 结果为 index.php?controller=tasks&action=edit&task_id=2
```
而启用 URL 路由后，url() 的效果如下：


```php
url('tasks/create')
// 结果为 /tasks/create
 
url('tasks/edit', array('task_id' => 2))
// 结果为 /tasks/edit/2
```


如果我们修改了路由规则，则效果可能是：

```php
url('tasks/create')
// 结果为 /create-new-tasks
 
url('tasks/edit', array('task_id' => 2))
// 结果为 /edit-my-task/2
```

也就是说 url() 函数的结果取决于应用程序的配置和路由规则。

这带来的好处包括：

* 在不同环境下，只需要启用或关闭 URL 路由，就能保证应用程序正常工作
* 修改路由规则表就可以获得不同的 URL 地址，完全不需要修改代码和视图

从 url() 指定参数获得 URL 的过程就是“反向解析”。目前只有 QeePHP 能够做到全自动的反向解析，其他框架都需要通过在生成 URL 时指定要使用的具体路由规则，否则只能创建默认样式的 URL 地址。

