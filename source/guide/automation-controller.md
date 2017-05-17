---
title: 创建控制器
date: 2017-05-09 10:40:12
---

# 创建控制器
在开发过程中，我们需要创建许多控制器和模型。QeePHP 提供了基于 Web 界面的工具来帮助开发者完成此类日常工作，尽量减少重复劳动。

## 启动 WebSetup
通过浏览器访问 http://localhost/todo/scripts/websetup.php 即可启动 WebSetup 工具。

![](media/14944047321352.png)


## 创建控制器
虽然没有强行要求，但将应用程序的请求响应分散到多个控制器还是很有必要的。每个控制器可以针对一组互相关联的功能，例如任务管理中，与任务有关的功能都放到 tasks 控制器中完成。

下面我们用 WebSetup 创建一个 tasks 控制器，来作为任务管理功能的对外接口。从 WebSetup 中选择“代码生成器 → 列出控制器 –> 创建新控制器”，然后输入控制器名称“Tasks”后点击“创建控制器”按钮即可自动生成控制器的类定义文件。

![](media/14944047750944.png)

![](media/14944047924339.png)

创建好的控制器文件保存为 app/controller/tasks_controller.php，内容如下：


```php
class Controller_Tasks extends Controller_Abstract
{
    function actionIndex()
    {
    }
}
```
同时创建的还有控制器的视图目录 app/view/tasks/，以便在我们在开发过程中添加 tasks 控制器的视图。

