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

### URI
- `/emp/{id}` GET查询员工
- `/emp `     POST保存
- `/emp/{id}` PUT修改员工
- `/emp/{id}` DELETE删除员工

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