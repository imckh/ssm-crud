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