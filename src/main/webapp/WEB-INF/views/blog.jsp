<%@ page import="com.blog.model.Blog" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 2019-03-21
  Time: 19:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0">
    <link href="../static/css/bootstrap.min.css" rel="stylesheet">

    <link href="../static/css/oneui.css" rel="stylesheet">
    <title>${blog == null ? "博客不存在" : blog.title}</title>
</head>
<c:if test="${blog == null}">
    <c:redirect url="../index.jsp"/>
</c:if>
<c:set var="content" scope="page" value="${blog.content}"/>
<body style="background-color: #EEEEEE">
<div class="container">
    <div class="text-right">
        <%--<strong style="font-size: 30px">欢迎你</strong>--%>

        <div class="dropdown">
            <a class="btn btn-default navbar-btn" style="float: left" href="../index.jsp">首页</a>
            <button class="btn btn-success" id="write-blog-button"><i class="fa fa-edit" aria-hidden="true"></i> 发布一篇</button>
            <c:if test="${sessionScope.user == null}">
                <button class="btn btn-primary navbar-btn" data-toggle="modal" data-target="#login-box">登录</button>
                <button class="btn btn-default navbar-btn" data-toggle="modal" data-target="#register-box">注册</button>
            </c:if>
            <c:if test="${sessionScope.user != null}">
                <button class="btn btn-default navbar-btn" id="dLabel" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        ${sessionScope.user.name}
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" style="right: 0; left: auto" aria-labelledby="dLabel">
                    <li><a href="#" data-toggle="modal" data-target="#username-box">用户名</a></li>
                    <li><a href="../index.jsp">所有博客</a></li>
                    <li><a href="../index.jsp?status=1">我发布的</a></li>
                    <li><a href="../index.jsp?status=0">我的草稿</a></li>
                    <li><a href="#" id="login-out">退出登录</a></li>
                </ul>
            </c:if>
        </div>
    </div>
    <div style="background-color: #FFFFFF; padding: 30px">
        <h2 class="text-center">${blog.title}<c:if test="${blog.status == 0}"><small style="font-size: 14px; color: #FF00FF">草稿</small></c:if> </h2>
        <p class="text-center" style="margin-top: 5px"><span style="margin-right: 16px">${blog.pubTime}</span><span>${blog.username}</span></p>
        <hr>
        <div><%out.write(((Blog) request.getAttribute("blog")).getContent());%></div>
    </div>
    <footer class="text-center" style="margin-top: 15px; margin-bottom: 20px">评论功能正在建设...</footer>
</div>

<c:if test="${sessionScope.user == null}">
    <%--登录框--%>
    <div class="modal fade" id="login-box" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exampleModalLabel">登录</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="login-name" class="control-label">账号</label>
                            <input type="text" class="form-control" id="login-name">
                        </div>
                        <div class="form-group">
                            <label for="login-password" class="control-label">密码</label>
                            <input type="password" class="form-control" id="login-password"/>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="login-button" data-loading-text="请稍候">登录</button>
                </div>
            </div>
        </div>
    </div>
    <%--登录框结束--%>
    <%--注册框--%>
    <div class="modal fade" id="register-box" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">注册</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="register-name" class="control-label">账号</label>
                            <input type="text" class="form-control" id="register-name">
                        </div>
                        <div class="form-group">
                            <label for="register-password" class="control-label">密码</label>
                            <input type="password" class="form-control" id="register-password"/>
                        </div>
                        <div class="form-group">
                            <label for="register-password2" class="control-label">确认密码</label>
                            <input type="password" class="form-control" id="register-password2"/>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="register-button" data-loading-text="请稍候">注册</button>
                </div>
            </div>
        </div>
    </div>
    <%--注册框结束--%>

</c:if>
<%--修改用户名框--%>
<div class="modal fade" id="username-box" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改用户名</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="username-text" class="control-label">用户名</label>
                        <input type="text" class="form-control" id="username-text" value="${sessionScope.user.name}">
                        <small id="username-text-error" style="color: #FF0000"></small>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update-username-button" data-loading-text="请稍候">修改</button>
            </div>
        </div>
    </div>
</div>
<%--修改用户名框--%>
</body>
<script src="../static/js/jquery-3.2.1.js"></script>
<script src="../static/js/bootstrap.min.js"></script>
<script src="../static/js/layui/layui.js"></script>
<script>
    layui.use(['layer', 'form'], function () {
        var layer = layui.layer;

        var writeBlogButton = $('#write-blog-button');
        /*  发布事件  */
        writeBlogButton.on('click', function () {
            window.location = '../pages/write_blog.jsp';
        });
        /*  发布事件结束  */

        <c:if test="${sessionScope.user == null}">
        /*  注册事件  */
        $('#register-button').on('click', function () {
            var name = $('#register-name').val();
            var password = $('#register-password').val();
            var password2 = $('#register-password2').val();
            if (name.length < 4) {
                layer.msg('用户名长度不足');
                return;
            }
            if (password.length < 4) {
                layer.msg('密码长度不足');
                return;
            }
            if (password2 !==  password) {
                layer.msg('密码不一致');
                return;
            }
            var $btn = $(this).button('loading');
            $.ajax({
                url: '../user/register.do',
                type: 'post',
                data: {'name': name, 'password': password, 'password2': password2},
                success: function (data) {
                    layer.msg(data.msg);
                },
                complete: function () {
                    $btn.button('reset');
                }
            })
        });
        /*  注册事件结束  */

        /*  登录事件  */
        $('#login-button').on('click', function () {
            var name = $('#login-name').val();
            var password = $('#login-password').val();
            if (name.length < 4) {
                layer.msg('用户名长度不足');
                return;
            }
            if (password.length < 4) {
                layer.msg('密码长度不足');
                return;
            }
            var $btn = $(this).button('loading');
            $.ajax({
                url: '../user/login.do',
                type: 'post',
                data: {'name': name, 'password': password},
                success: function (data) {
                    layer.msg(data.msg);
                    if (data.success) {
                        setTimeout(function () {
                            window.location.reload(true);
                        }, 1000);
                    }
                },
                complete: function () {
                    $btn.button('reset');
                }
            })
        });
        /*  登录事件结束  */
        writeBlogButton.unbind('click');    //未登录，解除之前事件，绑定新的事件
        /*  发布事件  */
        writeBlogButton.on('click', function () {
            $('[data-target="#login-box"]').click();    //未登录，先登录
        });
        /*  发布事件结束  */
        </c:if>
        var name = $('#username-text');
        var error = $('#username-text-error');
        var updateButton = $('#update-username-button');
        name.on('change', function () {
            if ($(this).val().length < 4) {
                error.text('用户名过短');
                updateButton.attr('disabled', 'disabled');
            } else {
                error.text('');
                updateButton.removeAttr('disabled');
            }
        });
        /*  修改用户名事件  */
        updateButton.on('click', function () {
            var $btn = $(this).button('loading');
            $.ajax({
                url: '../user/updateName.do',
                type: 'post',
                data: {'name': name.val()},
                success: function (data) {
                    layer.msg(data.msg);
                    if (data.success) {
                        setTimeout(function () {
                            window.location.reload(true);
                        }, 500);
                    } else {
                        error.text(data.msg);
                    }
                },
                complete: function () {
                    $btn.button('reset');
                }
            })
        });
        /*  修改用户名事件结束  */
        $('#login-out').on('click', function () {
            $.ajax({
                url: '../user/loginOut.do',
                type: 'post',
                success: function (data) {
                    layer.msg(data.msg);
                    if (data.success) {
                        setTimeout(function () {
                            window.location.reload(true);
                        }, 1000)
                    }
                }
            })
        });
    })
</script>
</html>
