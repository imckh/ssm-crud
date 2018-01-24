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