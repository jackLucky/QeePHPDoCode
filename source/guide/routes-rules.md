---
title: 添加路由规则
date: 2017-05-09 10:40:12
---

# 添加路由规则
打开文件 configs/routes.yaml 文件，可以看到目前的默认路由规则：


```yaml
_default_:
  pattern: /:controller/:action/*
  defaults:
    controller: default
    action: index
```

## 路由的正向解析
上面的规则中，“_default_”是规则的名称，每一条规则必须有一个唯一的名称。

pattern 表示该规则是一个基于模式的规则，如果是 regx 则是基于正则的规则。同一条规则只能两者之中选一种，不同规则可以不同的类型。defaults 则指定各个变量的默认值。

>基于正则的路由适合非常复杂的情况。限于篇幅这里我们只大概说明一下基于模式的路由规则。

pattern 的值就是要解析或最终生成的 URL 地址样式。这个 URL 用“/”符号分割为多个部分。而每一个以“:”开头的部分都是一个变量。例如“/:controller/:action/*”这个模式就由三个部分，其中前两个部分都是变量，而最后的则是通配符（关于通配符稍后再详细说明）。

现在来看看这个模式怎么用于正向解析。

* **"/projects"**

解析时，首先用“/”将 URL 地址分割为多个部分，然后与分割后的模式依次比对。

1. 模式的第一部分是 :controller 变量。而这个变量是一个内置变量，用于匹配的正则表达式是“([a-z][a-z0–9_])”，也就是说必须是“以字母开头，并且由字母、数字和下划线组成”。由于 project 完全符合这个要求，因此比对成功。

2. 模式的第二部分是 :action 变量。:action 与 :controller 一样都是内置变量，比对规则也一样。但显然要比对的 URL 中已经没有第二部分了。但是我们看前面写的路由规则中已经通过 defaults 为 action 变量指定了默认值。所以比对成功。

3. 模式的第三部分是“”通配符。“”通配符可以匹配任意数量成对出现的参数，由于 URL 中并没有多余参数，最终该路由规则的三个部分都比对成功。

4. 比对成功后，projects 将会作为 :controller 变量的值，而 :action 变量使用了默认值。因此这个 URL 最后会被导向 projects 控制器的 index 动作。


* **"/docs/show/id/2“**

这个 URL 分割后有 4 个部分，按照前面的过程，前两个部分都会比对成功。而通配符则比对成功最后的“id”和“2”两个部分，最终将 URL 导向 docs 控制器的 show 动作，并且附带参数 id=2。

再看一个复杂一点的例子:


```yaml
projects_download:
  pattern: "/projects/:name/download/:file"
  defaults:
    controller: "projects"
    action: "download"
  config:
    name: "[a-z0-9]+"
    file: "[0-9]+"
```

* **"/projects/qeephp/download/2“**

这个 URL 一共四个部分，依次比对的结果是：

1. 模式的第一部分不是变量，则以字符串方式和 URL 相同位置的部分进行比较。project 与 project 相同，因此比对通过。

2. 模式的第二部分是 :name 变量。由于这个变量不是内置变量，因此需要通过 configs 来指定比对规则。:name 的比对规则是“[a-z0–9]+”（也是一个正则），和 qeephp 相比对，结果通过。

3. 模式第三部分还是字符串，同样比对通过。

4. 与 :name 变量类似，“2”完全符合 :file 变量的比对规则。至此比对全部通过，最终 URL 会被导向到 projects 控制器的 download 动作（两者都通过 defaults 指定），并且附带参数 name=qeephp 和 file=2。

在比对过程中，必须所有部分都比对成功才算通过，否则一律算作比对失败。一条规则比对失败，就会用下一条规则来比对，直到找到可以匹配的规则。如果所有规则都失败，那么会按照 /key/value 形式把 URL 转换为参数对。

所以匹配范围更低的规则应该放在更前面。这样才能确保不会因为一个规则比另一个规则具有更大的匹配范围，而把匹配范围更小那个规则忽略了。

## 路由的反向解析
与正向解析相比，反向解析复杂得多。因为反向解析是用参数来比对的，而不是 URL 地址。

```php
array(
    'controller' => 'projects',
    'action'     => 'download',
    'name'       => 'qeephp',
    'file'       => 2,
)
```
上面是生成 URL 的参数，用于匹配的规则有：

```yaml
docs_page:
  pattern: "/docs/:name/:file"
  defaults:
    controller: "docs"
    action: "page"
    file: "index"
  config:
    name: "[a-z0-9\-]+"
    file: "[a-z0-9\-]+"
 
projects_show:
  pattern: "/projects/:name"
  defaults:
    controller: "projects"
    action: "show"
  config:
    name: "[a-z0-9]+"
 
projects_download_all:
  pattern: "/projects/:name/download"
  defaults:
    controller: "projects"
    action: "download"
  config:
    name: "[a-z0-9]+"
 
projects_download:
  pattern: "/projects/:name/download/:file"
  defaults:
    controller: "projects"
    action: "download"
  config:
    name: "[a-z0-9]+"
    file: "[0-9]+"
```


首先看第一个规则 docs_page 的比对过程：

* **"docs_page"**

首先确定 docs_page 规则需要的变量，包括 :controller、:action、:file 和 :name。其中前三个变量都具有默认值。

比对第一个变量 :controller。这个变量在 docs_page 中指定为 docs。而提供的参数中 :controller 的值是 projects。此时就要检查 :controller 是否在 configs 中指定了比对规则。如果指定了比对规则，那么 defaults 中为 :controller 指定的就是一个“建议值”。只要 :controller 符合比对规则也算通过。但现在 configs 并没有指定 :controller 的规则，因此比对失败。

* **"projects_show"**

参考 docs_page 的比对过程，:controller 变量可以通过，但 :action 变量却比对失败。

* **"projects_download_all"**

:controller、:action 变量都通过了比对。在比对 :name 时，按照 configs 中为 :name 指定的规则，:name 也通过了比对。接下来该路由规则已经没有更多变量了，但参数中却还有一个 file，因此算作比对失败。


* **"projects_download"**

这个规则的四个变量和参数完全符合，因此比对通过。比对通过后，将生成 /projects/qeephp/download/2 这样的 URL。而这个 URL 在正向解析时又符合同一条规则，最终实现了 url() 方法生成 URL 地址导向到正确控制器和动作的目的。

## 添加路由规则
在实际应用中，大多数 URL 使用默认的路由规则就足够了。少数 URL 可以进行适当的美化。例如 /tasks/edit/task_id/1 应该美化为 /tasks/edit/1。为了实现这个目的，我们修改 configs/routes.yaml，在默认规则**前**添加一条规则：


```yaml
tasks_edit:
  pattern: /tasks/edit/:task_id
  defaults:
    controller: tasks
    action: edit
  configs:
    task_id: "[0-9]+"
```

刷新浏览器后，再点击任务标题可以看到 URL 地址已经改变为预期的形式：


```
http://localhost/todo/public/tasks/edit/1
```

将把 /tasks/index/page/3 改写为 /tasks/page/3。

读者朋友们可以尝试各种写法，找到适合自己的使用方式。更复杂的基于正则的路由，请参考开发指南。


