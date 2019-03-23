package com.blog.service;

import com.blog.model.Blog;

import java.util.List;

public interface BlogDaoService {
    int getCount();
    List<Blog> getBlogsByLimit(int start, int length);
    boolean insertBlog(int userId, String title, String content, String type, int status);
    Blog getBlogById(int id);
    List<Blog> getBlogsByLimitAndUserId(int userId, int status, int start, int length);
    int getCountByUserId(int userId, int status);
    boolean updateBlog(int id, String title, String content, String type, int status);
    boolean deleteBlog(int userId, int id);
}
