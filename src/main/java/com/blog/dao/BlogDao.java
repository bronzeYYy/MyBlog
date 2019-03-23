package com.blog.dao;

import com.blog.model.Blog;

import java.util.List;

public interface BlogDao {
    List<Blog> getBlogsByLimit(int start, int length);
    int getBlogCount();
    int getBlogCountByUserId(int userId, int status);
    int insertBlog(Blog blog);
    Blog getBlogById(int id);
    List<Blog> getBlogsByLimitAndUserId(int userId, int status, int start, int length);
    int updateBlog(Blog blog);
    int deleteBlog(int userId, int id);
}
