package com.blog.service.impl;

import com.blog.dao.BlogDao;
import com.blog.dao.UserDao;
import com.blog.model.Blog;
import com.blog.service.BlogDaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class BlogDaoServiceImpl implements BlogDaoService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private BlogDao blogDao;
    @Override
    public int getCount() {
        return blogDao.getBlogCount();
    }

    @Override
    public List<Blog> getBlogsByLimit(int start, int length) {
        List<Blog> blogs = blogDao.getBlogsByLimit(start, length);
        for (Blog i : blogs) {
            i.setUsername(userDao.getUserName(i.getUserId()));  //存入发布人的用户名
        }
        return blogs;
    }

    @Override
    public boolean insertBlog(int userId, String title, String content, String type, int status) {
        Blog blog = new Blog();
        blog.setUserId(userId);
        blog.setTitle(title);
        blog.setContent(content);
        blog.setType(type);
        blog.setStatus(status);
        blog.setPubTime(SimpleDateFormat.getDateTimeInstance().format(new Date()));
        return blogDao.insertBlog(blog) == 1;
    }

    @Override
    public Blog getBlogById(int id) {
        Blog blog = blogDao.getBlogById(id);
        blog.setUsername(userDao.getUserName(blog.getUserId()));
        return blog;
    }

    @Override
    public List<Blog> getBlogsByLimitAndUserId(int userId, int status, int start, int length) {
        List<Blog> blogs = blogDao.getBlogsByLimitAndUserId(userId, status, start, length);
        for (Blog i : blogs) {
            i.setUsername(userDao.getUserName(i.getUserId()));  //存入发布人的用户名
        }
        return blogs;
    }

    @Override
    public int getCountByUserId(int userId, int status) {
        return blogDao.getBlogCountByUserId(userId, status);
    }

    @Override
    public boolean updateBlog(int id, String title, String content, String type, int status) {
        Blog blog = new Blog();
        blog.setId(id);
        blog.setTitle(title);
        blog.setContent(content);
        blog.setType(type);
        blog.setStatus(status);
        return blogDao.updateBlog(blog) == 1;
    }

    @Override
    public boolean deleteBlog(int userId, int id) {
        return blogDao.deleteBlog(userId, id) == 1;
    }
}
