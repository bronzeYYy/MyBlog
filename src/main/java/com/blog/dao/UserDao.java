package com.blog.dao;

import com.blog.model.User;

public interface UserDao {
    String getUserName(int id);
    int insertUser(User user);
    User getUserByName(String name);
    User getUserById(int id);
    int updateName(int id, String name);
}
