package com.blog.controller;

import com.blog.Utils.Util;
import com.blog.model.User;
import com.blog.service.UserDaoService;
import com.mysql.jdbc.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping(method = RequestMethod.POST)
public class UserController {

    @Autowired
    private UserDaoService userDaoService;

    @RequestMapping(value = "/user/register.do", params = {"name", "password", "password2"})
    public Map<Object, Object> register(String name, String password, String password2) {
        Map<Object, Object> map = new HashMap<>();
        if (StringUtils.isNullOrEmpty(name) || name.length() < 4) {
            Util.putError(map, "用户名长度过短");
        } else if (StringUtils.isNullOrEmpty(password) || password.length() < 5) {
            Util.putError(map, "密码长度过短");
        } else if (!password.equals(password2)) {
            Util.putError(map, "密码不一致");
        } else {
            if (userDaoService.insertUser(name, password)) {
                Util.putSuccess(map, "注册成功");
            } else {
                Util.putError(map, "注册失败");
            }
        }
        return map;
    }
    @RequestMapping(value = "/user/login.do", params = {"name", "password"})
    public Map<Object, Object> login(String name, String password, HttpServletRequest req) {
        Map<Object, Object> map = new HashMap<>();
        if (StringUtils.isNullOrEmpty(name) || StringUtils.isNullOrEmpty(password)) {
            Util.putError(map, "信息填写不完整");
        } else {
            User user = userDaoService.getUserByName(name);
            if (user == null) {
                Util.putError(map, "用户不存在");
            } else {
                if (password.equals(user.getPassword())) {
                    Util.putSuccess(map, "登陆成功");
                    HttpSession s = req.getSession();
                    s.setAttribute("user", user);
                } else {
                    Util.putError(map, "用户名密码不匹配");
                }
            }
        }
        return map;
    }
    @RequestMapping("/user/loginOut.do")
    public Map<Object, Object> loginOut(HttpServletRequest req) {
        Map<Object, Object> map = new HashMap<>();
        HttpSession session = req.getSession(false);  //获得当前请求的session
        if (session == null || session.getAttribute("user") == null) {
            //session不存在，没有登录
            Util.putError(map, "没有登录");
        } else {
            session.invalidate();
            Util.putSuccess(map, "已退出");
        }
        return map;
    }

    @RequestMapping(value = "/user/updateName.do", params = "name")
    public Map<Object, Object> updateName(String name, HttpServletRequest req) {
        Map<Object, Object> map = new HashMap<>();
        if (name.length() < 4) {
            Util.putError(map, "用户名长度不足");
            return map;
        }
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            Util.putError(map, "请先登录");
            return map;
        }

        User user1 = userDaoService.getUserByName(name);
        if (user1 != null) {
            Util.putError(map, "用户名已存在");
            return map;
        }
        User user = (User) session.getAttribute("user");
        if (userDaoService.updateName(user.getId(), name)) {
            Util.putSuccess(map, "修改成功");
            user1 = userDaoService.getUserById(user.getId());       //更新用户
            session.setAttribute("user", user1);
        } else {
            Util.putSuccess(map, "修改失败");
        }
        return map;
    }
}
