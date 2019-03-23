package com.blog.controller;

import com.blog.Utils.Util;
import com.blog.model.Blog;
import com.blog.model.User;
import com.blog.service.BlogDaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(method = RequestMethod.POST)
public class BlogController {
    @Autowired
    private BlogDaoService blogDaoService;

    @RequestMapping(value = "/blog/getBlogs.do", params = {"start", "length", "status"})
    @ResponseBody
    public List<Blog> getBlog(int start, int length, int status, HttpServletRequest req) {
        if (status != 0 && status != 1) {
            return blogDaoService.getBlogsByLimit(start, length);
        }
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            return null;
        }
        User user = (User) session.getAttribute("user");
        return blogDaoService.getBlogsByLimitAndUserId(user.getId(), status, start, length);
    }

    @RequestMapping(value = "/blog/saveBlog.do", params = {"title", "content", "status", "type"})
    @ResponseBody
    public Map<Object, Object> saveBlog(HttpServletRequest req, String title, String content, int status, String type) {
        Map<Object, Object> map = new HashMap<>();
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            Util.putError(map, "请先登录");
        } else if (title.length() < 4) {
            Util.putError(map, "标题长度不足");
        } else if (content.length() < 14) {
            Util.putError(map, "内容长度不足");
        } else if (status != 0 && status != 1) {
            Util.putError(map, "状态不正确");
        } else if (type.length() < 2) {
            Util.putError(map, "类型长度不足");
        } else {
            User user = (User) session.getAttribute("user");
            if (blogDaoService.insertBlog(user.getId(), title, content, type, status)) {
                if (status == 1) {
                    Util.putSuccess(map, "发布成功");
                }
                if (status == 0) {
                    Util.putSuccess(map, "存为草稿成功");
                }
            }
        }
        return map;
    }

    @RequestMapping(value = "/blog/{id}.html", method = RequestMethod.GET)
    public String showBlog(@PathVariable int id, Model model, HttpServletRequest req) {
        Blog blog = blogDaoService.getBlogById(id);
        if (blog.getStatus() != 0) {
            model.addAttribute("blog", blog);   //博客已发布，不是草稿
            return "blog";
        }
        //草稿只给发布者显示
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            model.addAttribute("msg", "没有权限");   //博客已发布，不是草稿
            return "blog";
        }
        User user = (User) session.getAttribute("user");
        if (blog.getUserId() != user.getId()) {             //非发布者登录
            model.addAttribute("msg", "没有权限");   //博客已发布，不是草稿
            return "blog";
        }
        model.addAttribute("blog", blog);
        return "blog";
    }
    @RequestMapping(value = "/updateBlog/{id}.html", method = RequestMethod.GET)
    public String updateBlog(@PathVariable int id, Model model, HttpServletRequest req) {
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            model.addAttribute("msg", "未登录");
            return "update_blog";
        }
        User user = (User) session.getAttribute("user");
        Blog blog = blogDaoService.getBlogById(id);
        if (blog.getUserId() != user.getId()) {
            model.addAttribute("msg", "没有登录");
            return "update_blog";
        }
        model.addAttribute("blog", blog);
        return "update_blog";
    }

    @RequestMapping(value = "/blog/updateBlog.do", params = {"id", "title", "content", "status", "type"})
    @ResponseBody
    public Map<Object, Object> updateBlog(HttpServletRequest req, int id, String title, String content, int status, String type) {
        Map<Object, Object> map = new HashMap<>();
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            Util.putError(map, "请先登录");
        } else if (title.length() < 4) {
            Util.putError(map, "标题长度不足");
        } else if (content.length() < 14) {
            Util.putError(map, "内容长度不足");
        } else if (status != 0 && status != 1) {
            Util.putError(map, "状态不正确");
        } else if (type.length() < 2) {
            Util.putError(map, "类型长度不足");
        } else {
            User user = (User) session.getAttribute("user");
            Blog blog = blogDaoService.getBlogById(id);
            if (blog.getUserId() != user.getId()) {
                Util.putError(map, "没有权限");
                return map;
            }
            if (blogDaoService.updateBlog(id, title, content, type, status)) {
                if (status == 1) {
                    Util.putSuccess(map, "发布成功");
                }
                if (status == 0) {
                    Util.putSuccess(map, "存为草稿成功");
                }
            }
        }
        return map;
    }


    @RequestMapping("/blog/count.do")
    @ResponseBody
    public Map<Object, Object> getCount(int status, HttpServletRequest req) {
        Map<Object, Object> map = new HashMap<>();
        if (status != 0 && status != 1) {
            map.put("n", blogDaoService.getCount());
            return map;
        }
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            return null;
        }
        User user = (User) session.getAttribute("user");

        map.put("n", blogDaoService.getCountByUserId(user.getId(), status));
        return map;
    }

    @RequestMapping(value = "/blog/deleteBlog.do", params = "id")
    @ResponseBody
    public Map<Object, Object> deleteBlog(int id, HttpServletRequest req) {
        Map<Object, Object> map = new HashMap<>();
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            Util.putError(map, "未登录");
            return map;
        }
        User user = (User) session.getAttribute("user");
        if (blogDaoService.deleteBlog(user.getId(), id)) {
            Util.putSuccess(map, "删除成功");
        } else {
            Util.putSuccess(map, "删除失败");
        }
        return map;
    }

}
