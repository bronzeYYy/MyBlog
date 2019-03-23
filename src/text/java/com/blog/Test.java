package com.blog;

import com.blog.service.BlogDaoService;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-mybatis.xml", "classpath:spring.xml"})
public class Test {
    @Resource
    private BlogDaoService blogDaoService;
    @org.junit.Test
    public void test() {
        System.out.println(blogDaoService.getBlogsByLimitAndUserId(1, 1, 0, 2).size());
    }
}
