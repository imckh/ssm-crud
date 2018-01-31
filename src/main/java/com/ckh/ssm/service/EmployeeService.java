package com.ckh.ssm.service;

import com.ckh.ssm.dao.EmployeeMapper;
import com.ckh.ssm.model.Employee;
import com.ckh.ssm.model.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 2018/1/24 20:20
 *
 * @author CKH
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有
     * @return
     */
    public List<Employee> getAll() {
        // 添加order by emp_id
        EmployeeExample example = new EmployeeExample();
        example.setOrderByClause("`emp_id`");

        return employeeMapper.selectByExampleWithDept(example);
    }

    /**
     * 员工保存
     * @param employee
     */
    public int saveEmp(Employee employee) {

        return employeeMapper.insertSelective(employee);
    }

    /**
     * 检查用户名是否重复
     * (复杂查询的使用XxxExample)
     * @param empName 用户名
     * @return Boolean true代表当前姓名可用
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);

        return employeeMapper.countByExample(example) == 0;
    }
}
