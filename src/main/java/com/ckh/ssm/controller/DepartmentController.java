package com.ckh.ssm.controller;

import com.ckh.ssm.model.Department;
import com.ckh.ssm.model.Msg;
import com.ckh.ssm.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 2018/1/26 19:50
 *
 * @author CKH
 *
 * 处理部门有关请求
 */

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有部门信息
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {
        List<Department> depts = departmentService.getDepts();

        return Msg.success().add("depts", depts);
    }
}
