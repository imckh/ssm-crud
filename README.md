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
6. 方法1, 使用过滤器使用Rest风格的URI 将页面普通的post请求转为指定的delete或put请求`web.xml`中`HiddenHttpMethodFilter` **在data中加一个&_method=PUT**
7. 方法2, 使用Ajax.PUT  解决put请求传不到数据问题
    > 在web.xml中配置`org.springframework.web.filter.HttpPutFormContentFilter`过滤器<br>
    我们需要能直接支持发送PUT之类的请求, 还要封装请求体中的数据<br>
    配置上HiddenHttpMethodFilter<br>
    的作用是将请求体中的数据解析并包装成一个Map, request被重新包装<br>
    request.getParameter()被重写, 就会从自己的封装体中取出数据

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

### 更新时
1. Request method 'POST' not supported `POST http://localhost:8080/ssmcrud/emp/1 405 ()`
2. update操作不返回行数 而是返回-21455221的一个负数
    > 对于mybatis的update、insert的操作，操作成功后会得到一个int类型的影响结果条数，直接在dao层返回就可以得到，可以通过这个返回值做成功与否的操作。
    <br>但是，mybatis官方的讨论列表，这句很关键：“If the BATCH executor is in use, the update counts are being lost. ”  会导致返回为-2147482646，而不是正确就返回条数，失败就返回0
    <br>一般我们都会开启batch的批量操作，所以建议不要通过影响条数进行结果判断
    <br>[参考链接CSDN](http://blog.csdn.net/Mos_wen/article/details/51361078)
3. 如果直接发送PUT的Ajax请求, 封装的数据直接除了id全是null 但是请求体(form data)中有数据,但是employee封装不上
    > 原因:
    tomcat, 将请求体中的数据封装一个map, 并不能从`request.getParameter`中得到数据 <br>
        `request.getParameter("empName)`就将从这个map中取值<br>
        springMVC封装POJO对象的时候, 会将POJO每个属性的值通过`request.getParameter("empName)`找到

    > ajax的PUT请求不能直接发 <br>
        请求体中的数据`request.getParamete`拿不到数据,<br>
        因为Tomcat一看是PUT就不会封装请求体为map, 只有post才会封装为map

    > `org.apache.catalina.connector.Request.parseParameters()`; 3111行<br>
    只有POST请求才会执行后续的代码 继续往下解析