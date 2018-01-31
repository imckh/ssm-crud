# 基于SSM的增删改查

## 基础环境搭建

1. 创建一个maven项目, webapp模板
2. 引入项目依赖的jar包
    - spring
    - springMVC
    - MyBatis
    - 数据库连接池, 驱动 JDBC
    - 其他(jstl, servlet-api, junit)
3. 引入bootstrap前端框架
4. 编写SSM整合的关键配置文件
    - web.xml
    - spring, springMVC
    - MyBatis
    - 使用MyBatis逆向工程生成对应的bean以及mapper
5. 测试mapper

## 将页面换为json数据传输(平台为无关性)
1. jackson-databind 导入
2. controller返回包装好的实体类, jackson自动转化为json字符串
3. jquery解析json, 将页面操作变为js

## 新增
1. jquery模态框
2. Ajax请求department数据并展示
3. EmpController.saveEmp()
4. Ajax, POST员工数据至`/emp/{}`添加员工
5. jquery前端校验, ajax用户名校验, 
6. 后端校验(JSR303)唯一约束

### URI
- `/emp/{id}` GET查询员工
- `/emp `     POST保存
- `/emp/{id}` PUT修改员工
- `/emp/{id}` DELETE删除员工

## 前端校验
1. 名字, 邮箱的合法性(jquery)
2. 名字的重复性校验
    - `<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>`
    - 如果保存成功添加属性
    - `<button type="button" class="btn btn-primary" id="emp_save_btn" ajax-validate="error">保存</button>`
    - `<button type="button" class="btn btn-primary" id="emp_save_btn" ajax-validate="success">保存</button>`

3. 新增模态框关闭之后, 表单状态的清空

## Log4j + Mybatis打印输出sql语句
1. `log4j-core`添加到maven
2. 配置log4j2.xml(注意有2)
3. Mybatis配置文件setting中添加`<setting name="logImpl" value="LOG4J2" />`将log的实现方式指定为LOG4J2(注意是2)

## 修改
1. 修改删除按钮分别添加edit/delete的css class
2. 注意, 这两个按钮是在创建页面后创建的, 所以不能用click绑定事件
    1. 创建按钮的时候绑定事件
    2. 用live()绑定单击事件, (jquery新版删除掉live()函数了)
    3. 替换为on()函数
3. 后台加入相应方法 /emp/{id}
4. 取出每个员工的id的办法为在生成时把员工的id信息保存到button的dom元素中去, 取的时候方便查找员工的信息
5. jquery中[val()函数的用法](http://jquery.cuishifeng.cn/val.html)
---

## 问题

### EL表达式失效问题
1. 未引入包`jsp-api`, `jstl-api`
2. 在jsp文件开头加入下边一句
```jsp
    <%@ page isELIgnored="false" %>
    <%--http://blog.csdn.net/wolf_soul/article/details/50388005--%>
    <%--http://blog.csdn.net/Q1059081877Q/article/details/46626669--%>
```

### taglib uri不存在
`<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>`
缺少maven包, `taglibs-standard-impl`, `jstl-api`

### 新增用户校验问题
1. 有些数据是直接保存在dom标签属性中的, 正常的用户是不会关注的, 那么更改了这些信息是否会影响程序错误呢?