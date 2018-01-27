<%--
  Created by IntelliJ IDEA.
  User: CKH
  Date: 2018/1/26
  Time: 15:04
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap3/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap3/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工添加模态框Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empNameAddInput" class="col-sm-3 control-label">emp name</label>
                        <div class="col-sm-9">
                            <input type="text" name="empName" class="form-control" id="empName-add-input" placeholder="emp name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email-add-input" class="col-sm-3 control-label">email</label>
                        <div class="col-sm-9">
                            <input type="email" name="email" class="form-control" id="email-add-input" placeholder="email@email.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="gender-add-input" class="col-sm-3 control-label">Gender</label>
                        <div class="col-sm-9">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderF-add-input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderM-add-input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept-add-input" class="col-sm-3 control-label">Department</label>
                        <div class="col-sm-4">
                            <%--部门提交部门ID--%>
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary" id="empAddBtn">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>department</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info"></div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav"></div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord;

    <%--页面加载完成以后, 直接去发送一个ajax请求, 得到分页数据--%>
    $(function(){
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/empjson",
            data:"pn=" + pn,
            type:"GET",
            success:function (result) {
                // console.log(result);
                // 1. 解析并显示员工信息
                build_emps_table(result);
                // 2. 解析并显示分页信息
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        // 清空表格
        $('#emps_table tbody').empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empGenderTd = $("<td></td>").append(item.gender === 'M' ? '男' : '女');
            var empEmailTd = $("<td></td>").append(item.email);
            var empDeptNameTd = $("<td></td>").append(item.department.deptName);

            // 按钮
//            <div class="btn-group btn-group-sm" role="group">
//                <button class="btn btn-primary"><span class="glyphicon glyphicon-edit"></span>编辑</button>
//                <button class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span>删除</button>
//            </div>

            var editBtn = $('<button></button>').addClass('btn btn-primary')
                .append($('<span></span>')).addClass('glyphicon glyphicon-edit')
                .append(' 编辑');
            var deleteBtn = $('<button></button>').addClass('btn btn-danger')
                .append($('<span></span>')).addClass('glyphicon glyphicon-trash')
                .append(' 删除');
            var btnGroup = $('<div></div>').addClass('btn-group btn-group-sm').attr('role', 'group')
                .append(editBtn).append(deleteBtn);
            var empBtnGroupTd = $("<td></td>").append(btnGroup);

            // append方法执行完以后还是返回原来的元素
            $("<tr></tr>")
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(empDeptNameTd)
                .append(empBtnGroupTd)
                .appendTo('#emps_table tbody');
        })
    }

    // 分页信息
    function build_page_info(result) {
        // 清空表格
        $('#page_info').empty();

        $('#page_info').append('当前第' + result.extend.pageInfo.pageNum + '页, 总共' + result.extend.pageInfo.pages + '页, 总共' + result.extend.pageInfo.total + '条记录');

        totalRecord = result.extend.pageInfo.total;
    }

    // 分页条, 点击分页能去相应页面
    function build_page_nav(result) {
        // 清空表格
        $('#page_nav').empty();

        var ul = $('<ul></ul>').addClass('pagination');

        // 构建元素
        var firstPageLi = $('<li></li>').append($('<a></a>').append('首页').attr('herf', '#'));
        var prePageLi = $('<li></li>').append($('<a></a>').append('&laquo;').attr('herf', '#')).attr('aria-label', 'Previous');
        // 是否还有上一页
        if (result.extend.pageInfo.hasPreviousPage === false) {
            firstPageLi.addClass('disabled');
            prePageLi.addClass('disabled');
        } else {
            // 为元素添加点击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nxtPageLi = $('<li></li>').append($('<a></a>').append('&raquo;').attr('herf', '#')).attr('aria-label', 'Next');
        var lastPageLi = $('<li></li>').append($('<a></a>').append('尾页').attr('herf', '#'));
        // 是否还有下一页
        if (result.extend.pageInfo.hasNextPage === false) {
            nxtPageLi.addClass('disabled');
            lastPageLi.addClass('disabled');
        } else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nxtPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        // 首页, 上一页
        ul.append(firstPageLi).append(prePageLi);

        // 遍历页码号
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {

            var numLi = $('<li></li>').append($('<a></a>').append(item).attr('herf', '#'));

            if (result.extend.pageInfo.pageNum === item) {
                numLi.addClass('active');
            }

            numLi.click(function () {
                to_page(item);
            });

            ul.append(numLi)
        });

        // 下一页, 末页
        ul.append(nxtPageLi).append(lastPageLi);

        var navEle = $('<nav></nav>').append(ul).attr('aria-label', 'Page navigation');

        navEle.appendTo('#page_nav');
    }

    // 点击新增按钮 弹出模态框
    $("#empAddBtn").click(function () {
        // 发送Ajax请求查出部门信息, 显示在下拉列表中
        getDepts();

        // 淡出模态框
        $('#empAddModal').modal({
            backdrop: 'static'
        });
    });

    function getDepts() {
        // 清空部门列表
        var deptAddSelect = $('#dept_add_select');
        deptAddSelect.empty();

        $.ajax({
            url:'${APP_PATH}/depts',
            type:'GET',
            success:function (result) {
                // 显示部门信息, 下拉列表
                $.each(result.extend.depts, function () {
                    var optionEle = $('<option></option>').append(this.deptName).attr('value', this.deptId);
                    optionEle.appendTo(deptAddSelect);
                });
            }
        });
    }

    $('#emp_save_btn').click(function () {
        // 1. 将模态框中的信息提交到服务器
        // 2. 发送Ajax请求保存员工
        $.ajax({
            url:'${APP_PATH}/emp',
            type:'POST',
            data:$('#empAddModal form').serialize(),
            success:function (result) {
                // 员工保存成功后
                // 关闭模态框
                $('#empAddModal').modal('hide');
                // 跳转到最后一页
                // 发送Ajax请求显示最后一页
                // 将总记录数当作页码 传入, 会自动跳转到最后一页,
                // 防止出现最后一页添加一条记录后新增一页的情况
                to_page(totalRecord);
            }
        });
    });
</script>
</body>
</html>
