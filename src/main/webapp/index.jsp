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
<!-- 员工修改模态框Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empNameAddInput" class="col-sm-3 control-label">emp name</label>
                        <div class="col-sm-9">
                            <p class="form-control-static" id="empName-update-input"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email-add-input" class="col-sm-3 control-label">email</label>
                        <div class="col-sm-9">
                            <input type="email" name="email" class="form-control" id="email-update-input" placeholder="email@email.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="gender-add-input" class="col-sm-3 control-label">Gender</label>
                        <div class="col-sm-9">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderF-update-input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderM-update-input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept-add-input" class="col-sm-3 control-label">Department</label>
                        <div class="col-sm-4">
                            <%--部门提交部门ID--%>
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

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
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email-add-input" class="col-sm-3 control-label">email</label>
                        <div class="col-sm-9">
                            <input type="email" name="email" class="form-control" id="email-add-input" placeholder="email@email.com">
                            <span class="help-block"></span>
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
            <button class="btn btn-danger" id="empDelAllBtn">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check-all"></th>
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
    var totalRecord, currentPage;

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

    // 创建员工表格
    function build_emps_table(result) {
        // 清空表格
        $('#emps_table tbody').empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td></td>").append($('<input type="checkbox" class="check-item">'));
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

            var editBtn = $('<button></button>').addClass('btn btn-primary edit-btn')
                .append($('<span></span>')).addClass('glyphicon glyphicon-edit')
                .append(' 编辑');
            // 为编辑按钮添加自定义属性, 标识员工id
            editBtn.attr("edit-id", item.empId);

            var deleteBtn = $('<button></button>').addClass('btn btn-danger delete-btn')
                .append($('<span></span>')).addClass('glyphicon glyphicon-trash')
                .append(' 删除');
            // 为删除按钮添加自定义属性, 标识员工id
            deleteBtn.attr("del-id", item.empId);

            var btnGroup = $('<div></div>').addClass('btn-group btn-group-sm').attr('role', 'group')
                .append(editBtn).append(deleteBtn);
            var empBtnGroupTd = $("<td></td>").append(btnGroup);

            // append方法执行完以后还是返回原来的元素
            $("<tr></tr>")
                .append(checkBoxTd)
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
        currentPage = result.extend.pageInfo.pageNum;
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

    // 表单完整重置(数据, 样式)
    function reset_form(ele) {
        // input 内容
        ele[0].reset();
        // 表单样式
        ele.find('*').removeClass("has-error has-success");
        ele.find('.help-block').text('');
    }

    // 点击新增按钮 弹出模态框
    $("#empAddBtn").click(function () {
        // 清除表单数据
        reset_form($('#empAddModal form'));
        // $('#empAddModal form')[0].reset();
        // 清除上次input样式
        //show_validate_msg($('#empName-add-input'), 'clear', '');
        //show_validate_msg($('#email-add-input'), 'clear', '');

        // 发送Ajax请求查出部门信息, 显示在下拉列表中
        getDepts($('#dept_add_select'));

        // 淡出模态框
        $('#empAddModal').modal({
            backdrop: 'static'
        });
    });

    // 查询所有部门信息
    function getDepts(ele) {
        // 清空部门列表
        ele.empty();

        $.ajax({
            url:'${APP_PATH}/depts',
            type:'GET',
            success:function (result) {
                // 显示部门信息, 下拉列表
                $.each(result.extend.depts, function () {
                    var optionEle = $('<option></option>').append(this.deptName).attr('value', this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    // 验证用户名输入
    function validate_add_form_empname(empNameEle) {
        // 1. 拿到要校验的数据
        var empName = empNameEle.val();
        //用户名正则，4到16位（字母，数字，下划线，减号）汉字
        //var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        // 用户想怎么起怎么起 , 只限制长度
        var regName = /^.{2,16}$/;
        return regName.test(empName);
    }

    // 验证邮箱输入
    function validate_add_form_email(emailEle) {
        var email = emailEle.val();
        // 名称允许汉字、字母、数字，域名只允许英文域名
        var emailReg = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]{2,6})+$/;
        return emailReg.test(email);
    }

    // 校验表单信息
    function validate_add_form() {
        var empNameEle = $('#empName-add-input');
        if (!validate_add_form_empname(empNameEle)) {
            show_validate_msg(empNameEle, 'error', '输入用户名长度不对(2-16)');
            return false;
        } else {
            show_validate_msg(empNameEle, 'success', '');
        }

        var emailEle = $('#email-add-input');
        if (!validate_add_form_email(emailEle)) {
            show_validate_msg(emailEle, 'error', '邮箱格式不对');
            return false;
        } else {
            show_validate_msg(emailEle, 'success', '');
        }

        return true;
    }

    // 显示检验信息
    function show_validate_msg(ele, status, msg) {
        var elepapa = ele.parent().parent();

        elepapa.removeClass('has-success has-error');
        ele.next("span").text('');

        if ('success' === status) {
            elepapa.addClass('has-success');
        } else if ('error' == status) {
            elepapa.addClass('has-error');
        } else if ('clear' == status) {
            elepapa.removeClass('has-success has-error');
        }

        ele.next("span").text(msg);
    }

    //校验用户名是否重复
    $('#empName-add-input').change(function () {
        if (!validate_add_form_empname($(this))) {
            show_validate_msg($(this), 'error', '输入用户名长度不对(6-16)');
            return false;
        } else {
            show_validate_msg($(this), 'success', '');
        }

        var empName = this.value;
        $.ajax({
            url:'${APP_PATH}/checkuser',
            data: 'empName=' + empName,
            type: 'POST',
            success: function(result) {
                if(result.code == 200) {
                    // 将结果是否正确保存到dom页面的属性上,
                    $('#emp_save_btn').attr('ajax-validate', 'success');
                    show_validate_msg($('#empName-add-input'), 'success', '用户名可用');
                } else if (result.code == 400) {
                    $('#emp_save_btn').attr('ajax-validate', 'error');
                    show_validate_msg($('#empName-add-input'), 'error', result.extend.validate_msg);
                }
            }
        });
    });

    // 点击保存员工
    // 保存前先对数据进行校验
    $('#emp_save_btn').click(function () {
        if (!validate_add_form()) {
            return false;
        }

        // 判断之前的用户名校验是否成功
        if ($(this).attr('ajax-validate') == 'error') {
            // 成功
            show_validate_msg($('#empName-add-input'), 'error', '用户名不可用');
            return false;
        } else if ($(this).attr('ajax-validate') == 'success'){
            show_validate_msg($('#empName-add-input'), 'success', '用户名可用');
        }

        // 1. 将模态框中的信息提交到服务器
        // 2. 发送Ajax请求保存员工
        $.ajax({
            url:'${APP_PATH}/emp',
            type:'POST',
            data:$('#empAddModal form').serialize(),
            success:function (result) {
                if (result.code == 200) {
                    // 员工保存成功后
                    // 关闭模态框
                    $('#empAddModal').modal('hide');
                    // 跳转到最后一页
                    // 发送Ajax请求显示最后一页
                    // 将总记录数当作页码 传入, 会自动跳转到最后一页,
                    // 防止出现最后一页添加一条记录后新增一页的情况
                    to_page(totalRecord);
                } else if ((result.code == 400)){
                    // 用户校验失败
                    // 有哪个字段的错误信息 就显示那个字段
                    if (undefined != result.extend.errorFields.email) {
                        // 显示邮箱错误信息
                        show_validate_msg($('#email-add-input'), 'error', result.extend.errorFields.email);
                    }

                    if (undefined != result.extend.errorFields.empName) {
                        // 显示员工名字
                        show_validate_msg($('#empName-add-input'), 'error', result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    // 查询员工信息
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/" + id,
            type:"GET",
            success:function (result) {
                // 显示员工数据
                var empData = result.extend.emp;
                $("#empName-update-input").text(empData.empName);
                $("#email-update-input").val(empData.email);
                // 更改单选框 http://jquery.cuishifeng.cn/val.html
                $("#empUpdateModal input[name='gender']").val([empData.gender]);
                // 下拉列表
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    // 点击更新, 更新员工信息
    $("#emp_update_btn").click(function () {
        // 1. 校验邮箱
        var emailEle = $('#email-update-input');
        if (!validate_add_form_email(emailEle)) {
            show_validate_msg(emailEle, 'error', '邮箱格式不对');
            return false;
        } else {
            show_validate_msg(emailEle, 'success', '');
        }

        // 2. 发送Ajax请求, 更新员工
        $.ajax({
            url:'${APP_PATH}/emp/' + $(this).attr('edit-id'),
//            一个是使用HiddenHttpMethodFilter过滤器, 发送的是post请求,但是在data中要带上"&_method=PUT"
//            由HiddenHttpMethodFilter过滤器转为PUT
//            type:'POST',
//            data:$('#empUpdateModal form').serialize() + "&_method=PUT",
//            另一个是使用HttpPutFormContentFilter过滤器, 可以直接使用PUT请求
            type:'PUT',
            data:$('#empUpdateModal form').serialize(),
            success:function (result) {
                //1. 关闭对话框
                $('#empUpdateModal').modal('hide');
                // 2. 回到本页面
                to_page(currentPage);
            }
        });
    });

    // 单个删除按钮绑定事件
    $(document).on('click', '.delete-btn', function () {
        //1. 弹出确认删除对话框
        // 拿到祖先的id
        var empName = $(this).parents('tr').find('td:eq(2)').text();
        var empId = $(this).attr("del-id");
        if (confirm('确认删除[' + empName + ']?')) {
            // 确认, 发送Ajax请求删除
            $.ajax({
                url:'${APP_PATH}/emp/' + empId,
                type:'DELETE',
                success:function (result) {
                    // 回到当前页
                    to_page(currentPage);
                }
            });
        }
    });

    // 因为编辑按钮是在页面加载出来以后动态生成的, 所以这里要用这样的方法绑定
    // 编辑按钮绑定事件
    $(document).on('click', '.edit-btn', function () {
        // 查出部门信息, 并显示部门列表
        getDepts($('#empUpdateModal select'));

        // 查出员工信息, 并显示
        getEmp($(this).attr("edit-id"));

        // 传递员工id传递给模态框的更新按钮
        $('#emp_update_btn').attr('edit-id', $(this).attr('edit-id'));

        // 淡出模态框
        $('#empUpdateModal').modal({
            backdrop: 'static'
        });
    });

    // 全选//全不选
    $('#check-all').click(function () {
        // attr()获取checked是 undefined
        // 因为当时定义选择框的时候并没有定义checked属性
        // 所以这些dom原生属性用prop获取, 而用attr获取自定义属性的值
        // alert($(this).prop('checked'));
        $('.check-item').prop('checked', $(this).prop('checked'));
    });

    //单选(包括选中了全部全选复选框也要相应的改变)
    $(document).on('click', '.check-item', function (){
        // 判断当前选中的元素 是不是当前页的size
        // 匹配选中的选择框 (若选中的选择框的个数==所有选择框的个数)
        var isAllChecked = $('.check-item').length == $('.check-item:checked').length;

        //alert(checkedNum);
        if (isAllChecked) {
            $('#check-all').prop('checked', true);
        } else {
            $('#check-all').prop('checked', false);
        }
    });

    // 点击全部删除, 批量删除
    $('#empDelAllBtn').click(function () {
        // 展示将要删除的员工姓名, 遍历所有选中的
        var empNames = '';
        var delIds = '';
        $.each($('.check-item:checked'), function () {
            // 第三个<td>
            var curEmpName = $(this).parents('tr').find('td:eq(2)').text() + ',';
            empNames += curEmpName;

            // 组装员工id字符串
            delIds += $(this).parents('tr').find('td:eq(1)').text() + '-';
        });

        // 去除最后一个符号
        empNames = empNames.substring(0, empNames.length - 1);
        delIds = delIds.substring(0, delIds.length - 1);

        if (confirm('确认删除[' + empNames + ']?')) {
            $.ajax({
                url:'${APP_PATH}/emp/' + delIds,
                type:'DELETE',
                success:function (result) {
                    alert(result.msg);

                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
