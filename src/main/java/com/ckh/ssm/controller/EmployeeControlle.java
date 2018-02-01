package com.ckh.ssm.controller;

import com.ckh.ssm.model.Employee;
import com.ckh.ssm.model.Msg;
import com.ckh.ssm.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 2018/1/24 20:14
 * @author CKH
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeControlle {
    @Autowired
    EmployeeService employeeService;

    /**
     * 如果直接发送PUT的Ajax请求, 封装的数据直接除了id全是null
     * 但是请求体(form data)中有数据,但是employee封装不上
     *
     * 原因:
     *  tomcat, 将请求体中的数据封装一个map, 并不能从request.getParameter中得到数据
     *      request.getParameter("empName)就将从这个map中取值
     *      springMVC封装POJO对象的时候, 会将POJO每个属性的值通过request.getParameter("empName)找到
     *
     *  ajax的PUT请求不能直接发
     *      请求体中的数据request.getParamete拿不到数据,
     *      因为Tomcat一看是PUT就不会封装请求体为map, 只有post才会封装为map
     *
     *  org.apache.catalina.connector.Request.parseParameters(); 3111行
     *  只有POST请求才会执行后续的代码 继续往下解析
     *
     *  我们需要能直接支持发送PUT之类的请求, 还要封装请求体中的数据
     *  配置上HiddenHttpMethodFilter
     *  的作用是将请求体中的数据解析并包装成一个Map, request被重新包装
     *  request.getParameter()被重写, 就会从自己的封装体中取出数据
     *
     * 员工更新方法
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee) {
        // If the BATCH executor is in use, the update counts are being lost.
        int i = employeeService.updateEmp(employee);
//        if (i > 0)
            return Msg.success().add("updatesNum", i);
//        return Msg.fail().add("updatesNum", i);
    }

    /**
     * 查询单个ID
     * GET请求员工ID
     * //@PathVariable("id")表示从路径中取出id
     * @param id 要查询的员工ID
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee e = employeeService.getEmp(id);

        return Msg.success().add("emp", e);
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    // 明确表示要取出从页面传来的数据中取出'empName'的值
    public Msg checkUser(@RequestParam("empName") String empName) {
        // 先判断用户名是不是合法表达式
        //用户名正则，4到16位（字母，数字，下划线，减号）汉字
        //var regName = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5}$)";
        // 用户想怎么起怎么起 , 只限制长度
        String  regName = "^.{2,16}$";
        if (!empName.matches(regName)) {
            return Msg.fail().add("validate_msg", "用户名必须是2-16位");
        }

        // 数据库校验
        boolean b = employeeService.checkUser(empName);

        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("validate_msg", "用户名不可用");
        }
    }

    /**
     * 新增员工
     * /emp/{id} GET查询员工
     * /emp POST保存
     * /emp/{id} PUT修改员工
     * /emp/{id} DELETE删除员工
     *
     * 校验
     * 1. 支持JSR303校验
     * 2. 导入Hibernate-Validator
     *
     * @param employee 因为页面上input的name与employee中的属性一致, 所以会自动封装为Employee对象
     * @return
     */
    @RequestMapping(value = "emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            // 校验失败, 应该返回失败, 在模态框中显示检验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();

            for (FieldError fieldError : fieldErrors) {
                System.out.println(fieldError);
                System.out.println("错误字段名:" + fieldError.getField());
                System.out.println("错误信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }

            return Msg.fail().add("errorFields", map);
        } else {
            int i = employeeService.saveEmp(employee);
            return Msg.success().add("changedNum", i);
        }
    }

    /**
     * 查询员工数据(分页查询)
     * @return
     */
    @Deprecated
    @RequestMapping("emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model) {
        // 小于0
        pn = pn < 1 ? 1 : pn;
        // 这不是一个分页查询
        // 引入PageHelper分页插件
        // 在查询之前只需要调用, 传入页码以及分页每页的大小
        PageHelper.startPage(pn, 5);
        // 后边紧跟的查询紧跟的就是一个分页查询
        List<Employee> employees = employeeService.getAll();
        //用PageInfo对结果进行包装, 只需要将pageinfo交给页面
        //PageInfo包含了非常全面的分页属性
        // 分装了详细的分页信息, 包括查询出来的数据, 连续显示的页数
        PageInfo page = new PageInfo(employees, 5);

        model.addAttribute("pageInfo", page);

        return "list";
    }

    @RequestMapping("empjson")
    @ResponseBody
    public Msg getEmpsWithJsoon(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model) {
        pn = pn < 1 ? 1 : pn;
        PageHelper.startPage(pn, 5);
        List<Employee> employees = employeeService.getAll();
        PageInfo page = new PageInfo(employees, 5);

        return Msg.success().add("pageInfo", page);
    }
}
