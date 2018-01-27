package com.ckh.ssm.service;

import com.ckh.ssm.dao.EmployeeMapper;
import com.ckh.ssm.model.Employee;
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
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存
     * @param employee
     */
    public int saveEmp(Employee employee) {

        return employeeMapper.insertSelective(employee);
    }
}
