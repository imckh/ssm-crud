package com.ckh.ssm.dao;

import com.ckh.ssm.model.Department;
import com.ckh.ssm.model.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层
 * spring的项目就可以使用Spring的单元测试
 * 1. 导入SpringTest模块
 * 2. @ContextConfiguration指定spring配置的位置
 * 3. 直接autowired即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD() {
        // 1. 创建springIOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        // 2. 从容器中获取mapper
//        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        //System.out.println(departmentMapper);

        //1. 插入几个部门
        //Department department = new Department(null, "开发部");
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));

        // 2. 插入员工
        //employeeMapper.insertSelective(new Employee(null, "ckh", "M", "123456@qq.com", 1));

        //3. 批量插入 使用可以批量执行操作的SQLSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@ckh.com", 2));
        }

        System.out.println("批量执行完成");
    }
}
