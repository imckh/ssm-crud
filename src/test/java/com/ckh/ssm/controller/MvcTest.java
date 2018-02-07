package com.ckh.ssm.controller;

import com.ckh.ssm.model.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import java.util.Arrays;
import java.util.List;

/**
 * 2018/1/24 20:47
 *
 * @author CKH
 *
 * 使用Spring测试模块提供的测试来测试crud请求的正确性
 * Spring测试的时候需要servlet至少3.0的支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
@Rollback(value = true)
@Transactional(transactionManager = "transactionManager")
public class MvcTest {

    // 传入springmvc的ioc
    @Autowired
    WebApplicationContext context;
    // 虚拟mvc
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        // 模拟请求拿到返回值
        MvcResult result = mockMvc.perform(
                MockMvcRequestBuilders.get("/emps").param("pn", "200"))
                .andReturn(); //java.lang.NoSuchMethodError: javax.servlet.http.HttpServletResponse.getStatus()I

        //请求成功后, 请求域中会有model中添加的Attribute
        // 可以取出 数据并验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码" + pageInfo.getPageNum());
        System.out.println("总页码" + pageInfo.getPages());
        System.out.println("总记录数" + pageInfo.getTotal());

        System.out.println("在页面需要连续显示的页码");
        System.out.println(Arrays.toString(pageInfo.getNavigatepageNums()));

        System.out.println("员工数据");
        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println(employee);
        }

        System.out.println(pageInfo);
    }
}
