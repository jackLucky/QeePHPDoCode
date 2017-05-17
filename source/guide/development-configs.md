---
title: 修改配置文件
date: 2017-05-09 10:40:12
---
#  修改配置文件
在接下来的开发工作中，我们要借助自动化工具来创建控制器和模型。但这样做的前提是正确修改配置文件，让自动化工具能够读取 todo 应用的数据库信息。
## 修改 database.yaml

configs/database.yaml 是保存数据库连接信息的配置文件，默认内容如下：

```yaml
# devel 模式
devel:
  driver:     mysql
  host:       localhost
  login:      username
  password:   password
  database:   todo_devel_db
  charset:    utf8
  prefix:
 
# test 模式
test:
  driver:     mysql
  host:       localhost
  login:      username
  password:   password
  database:   todo_test_db
  charset:    utf8
  prefix:
 
# deploy 模式
deploy:
  driver:     mysql
  host:       localhost
  login:      username
  password:   password
  database:   todo_db
  charset:    utf8
  prefix:
```

可以看到针对三种运行模式定义了三组连接信息。本教程会一直使用开发模式，所以我们只修改 devel 这一组：

```yaml
# devel 模式
devel:
  driver:     mysql
  host:       localhost
  login:      todo
  password:   todo_db_pass
  database:   todo_db
  charset:    utf8
  prefix:
```
如果你的数据库设置和上面的信息不同，请对照进行修改配置文件。
## 注意
php5.3+ 要求使用Mysqli（PHP MySQL Improved!）面向对象的函数库，如果继续使用老版本面向对象的msql函数库将会报错（`Fatal error: Uncaught Error: Call to undefined function mysql_connect() in qeephp/library/db/adapter/mysql.php:68`）

如果遇到这样的错误我们只需要把数据库配置文件中的驱动（driver）改成`mysqli`即可，例如：

```yaml
# devel 模式
devel:
  driver:     mysqli
  host:       localhost
  login:      username
  password:   password
  database:   todo_devel_db
  charset:    utf8
  prefix:
```

