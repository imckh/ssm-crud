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

    /**
     * 查询员工
     * @param id 员工ID
     * @return
     */
    public Employee getEmp(Integer id) {
        // 这里只需要带上部门ID, 不需要部门详细信息
        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 员工更新
     * @param employee
     */
    public int updateEmp(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 员工删除
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除
     * @param ids 将要删除的员工id列表
     */
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        // delete from xxx where emp_id in (1, 2,3 ...)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
