---
title: YAML 入门
date: 2017-05-09 10:40:12
---

# YAML 入门
QeePHP 为了方便开发者，大量使用了 YAML 格式的文件来存储配置信息。因此掌握阅读和书写 YAML 格式文档的基本知识是很有必要的。

虽然 YAML 格式本身具有非常强大的表达能力，但在 QeePHP 只用到下列几种：

* **名值对**，例如 key ⇒ value，这和 PHP 中以字符串做键名的数组一样；
* **列表**，例如 value1, value2，这和 PHP 中以数字做键名的数组一样。
## YAML 实例

下面是一个 YAML 文件实例：


```yaml
#### 首页显示设置
homepage:
  # 首页内容缓存时间（秒）
  cached_lifetime: 300
  # 首页上显示多少条最新主题文章
  topics_num: 2
  # 首页上显示多少条最新社区活动
  activities_num: 3
```

这个实例中，所有第一个非空白字符是“#”的行都是注释。而以“:”为结束符的字符串，代表了一个键名，“:”后面是键值。如果“:”后没有内容，则以缩进的后续行内容作为键值。所有以“:”分割的内容都成为“名值对”，也就是“名字”与“值”成对的内容。

上面实例转换为 PHP 数组就是：

```php
array(
    'homepage' => array(
        'cached_lifetime' => 300,
        'topics_num'      => 2,
        'activities_num'  => 3,
    ),
)
```
再来看另一个实例：

```yaml
# 后台管理菜单标签
admin_tabs:
  "首页":
    -
      title: "主题文章"
      udi: "admin::topics/index"
    -
      title: "社区活动"
      udi: "admin::activities/index"
  #
  "项目":
    -
      title: "项目管理"
      udi: "admin::projects/index"
  #
  "应用":
    -
      title: "应用展示管理"
      udi: "admin::cases/index"
```
这个实例不但有名值对，而且有列表。所有第一个非空字符是“-”的行都代表一个列表的开始，并且后续缩进行的内容作为列表内容。该实例对应的 PHP 数组是：

```php
array(
    'admin_tabs' => array(
        '首页' => array(
            array('title' => '主题文章', 'udi' => 'admin::topics/index'),
            array('title' => '社区活动', 'udi' => 'admin::activities/index'),
        ),
        '项目' => array(
            array('title' => '项目管理', 'udi' => 'admin::projects/index'),
        ),
        '应用' => array(
            array('title' => '应用展示管理', 'udi' => 'admin::/cases/index'),
        ),
    ),
)
```
只要仔细比较上述两个实例及其对应的 PHP 数组，相信可以很好的理解 YAML 格式。

## 书写 YAML 文档
在书写 YAML 文档时，最重要的就是注意缩进。YAML 格式要求缩进必须是两个空格，不能是制表字符，也不能是更多的空格。此外对于包含空格、特殊符号或汉字的键名和键值，最好用英文双引号括起来。

在上面第二个实例那样书写多层内容时，务必确保内容间没有空行。如果不希望所有内容都挤在一堆，可以用“#”开头的注释来分割，但要确保注释也有正确的缩进。

总结而言，书写 YAML 文档的要点如下：

* **注意缩进**
缩进只能是两个空格为一级，不能是其他字符。

* **字符串应该用引号**
包含空格、特殊字符以及中文的字符串应该使用英文双引号括起来，不能使用中文引号。

* **多层嵌套要注意缩进**
多层嵌套时，要注意正确的缩进，并且不能有空行。

* **列表的另一种写法**
列表是很常用的数据类型，可以采用一种更简短的写法：

```yaml
name: ["value1", 1234, "cxx, mixed"]
```
YAML 是一种使用很方便的格式。但不幸的是 PHP 对 YAML 的支持很差，许多更有用的特性都存在问题。例如多行文本的书写在 PHP 解析后会出现多余的空格。不过用于存储一般的配置，YAML 有着 XML 和 PHP 数组无法比拟的优点。加上 QeePHP 对 YAML 的缓存能力，性能也不会是问题。

