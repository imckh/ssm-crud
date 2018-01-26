<%--
  Created by IntelliJ IDEA.
  User: CKH
  Date: 2018/1/24
  Time: 20:18
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%--http://blog.csdn.net/wolf_soul/article/details/50388005--%>
<%--http://blog.csdn.net/Q1059081877Q/article/details/46626669--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <!-- web路径
        不以/开始的相对路径, 找资源, 以当前资源的路径为基准, 经常出现问题
        以/开始的相对路径, 是以服务器的路径为标准的(http://localhost:3306), 需要加上项目名 http://localhost:3306/ssmcrud
    -->

    <script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH }/static/bootstrap3/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH }/static/bootstrap3/js/bootstrap.min.js"></script>
</head>
<body>
    <!--搭建显示页面-->
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>department</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.empId}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.gender=="M" ? "男" :"女"}</td>
                            <td>${emp.email}</td>
                            <td>${emp.department.deptName}</td>
                            <td>
                                <div class="btn-group btn-group-sm" role="group">
                                    <button class="btn btn-primary"><span class="glyphicon glyphicon-edit"></span>编辑</button>
                                    <button class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span>删除</button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6">
                当前第${pageInfo.pageNum}页, 总共${pageInfo.pages}页, 总共${pageInfo.total}条记录
            </div>
            <%--分页条--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${!pageInfo.isFirstPage}">
                            <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                        </c:if>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="pageNums">
                            <c:if test="${pageNums == pageInfo.pageNum}">
                                <li class="active"><a href="#">${pageNums}</a></li>
                            </c:if>
                            <c:if test="${pageNums != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${pageNums}">${pageNums}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${!pageInfo.isLastPage}">
                            <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

</body>
</html>
