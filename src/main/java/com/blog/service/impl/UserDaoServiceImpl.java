package com.blog.service.impl;

import com.blog.dao.UserDao;
import com.blog.model.User;
import com.blog.service.UserDaoService;
import com.mysql.jdbc.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class UserDaoServiceImpl implements UserDaoService {
    @Autowired
    private UserDao userDao;
    @Override
    public String getUserName(int id) {
        return userDao.getUserName(id);
    }

    @Override
    public boolean insertUser(String name, String password) {
        User user = new User();
        user.setName(name);
        user.setPassword(password);
        user.setRegTime(SimpleDateFormat.getDateTimeInstance().format(new Date()));
        return userDao.insertUser(user) == 1;
    }

    @Override
    public User getUserByName(String name) {
        if (StringUtils.isNullOrEmpty(name)) {
            return null;
        }
        return userDao.getUserByName(name);
    }

    @Override
    public boolean updateName(int id, String name) {
        return userDao.updateName(id, name) == 1;
    }

    @Override
    public User getUserById(int id) {
        return userDao.getUserById(id);
    }
}
