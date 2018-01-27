package com.ckh.ssm.service;

import com.ckh.ssm.dao.DepartmentMapper;
import com.ckh.ssm.model.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 2018/1/26 19:51
 *
 * @author CKH
 */
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        List<Department> departments = departmentMapper.selectByExample(null);

        return departments;
    }
}
