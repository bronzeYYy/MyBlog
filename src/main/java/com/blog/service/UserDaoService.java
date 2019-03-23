package com.blog.service;

import com.blog.model.User;

public interface UserDaoService {
    String getUserName(int id);
    boolean insertUser(String name, String password);
    User getUserByName(String name);
    User getUserById(int id);
    boolean updateName(int id, String name);
}
