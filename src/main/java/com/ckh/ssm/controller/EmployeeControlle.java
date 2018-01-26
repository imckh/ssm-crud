package com.ckh.ssm.controller;

import com.ckh.ssm.model.Employee;
import com.ckh.ssm.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

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
     * 查询员工数据(分页查询)
     * @return
     */
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
}
