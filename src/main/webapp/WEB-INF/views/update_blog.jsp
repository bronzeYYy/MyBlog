<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 2019-03-21
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0">
    <link href="../static/css/bootstrap.min.css" rel="stylesheet">

    <link href="../static/css/oneui.css" rel="stylesheet">
    <title>修改博客</title>
</head>
<c:if test="${blog == null}">
    <h2 class="text-center">${msg}</h2>
    <script>
        setTimeout(function () {
            window.location = '../index.jsp'
        }, 500)
    </script>
</c:if>
<body style="background-color: #EEEEEE">

<div class="container">
    <div class="text-right">
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

    <div style="background-color: #FFFFFF; padding: 10px 15px 15px 15px;">
        <h2 class="text-center" style="margin-bottom: 15px">修改博客</h2>
        <div class="form-group">
            <label for="blog-title" class="control-label">标题</label>
            <input type="text" class="form-control" id="blog-title" value="${blog.title}">
        </div>
        <div class="form-group">
            <label for="blog-type" class="control-label">类型</label>
            <input type="text" class="form-control" id="blog-type" value="${blog.type}">
        </div>
        <div class="form-group">
            <label for="blog-content" class="control-label">内容</label>
            <div id="blog-content-menu" style="border: 1px solid #ccc"></div>
            <div id="blog-content" style="height: 600px; border: 1px solid #ccc">

            </div>
        </div>
        <div class="form-group">
            <button class="btn btn-primary" style="width: 35%" id="post-blog-button" data-loading-text="请稍候">发布</button>
            <button class="btn btn-default" style="width: 25%" id="save-blog-button" data-loading-text="正在保存">存为草稿</button>
        </div>
    </div>
</div>
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
<script src="../static/js/wangEditor.min.js"></script>
<script src="../static/js/layui/layui.js"></script>
<script>
    var E = window.wangEditor;
    var editor = new E('#blog-content-menu', '#blog-content');
    editor.customConfig.uploadImgShowBase64 = true;
    editor.customConfig.zIndex = 0;
    editor.create();
    editor.txt.html('${blog.content}');
    $('#post-blog-button').on('click', function () {
        var $btn = $(this).button('loading');
        postOrSave(1);
        $btn.button('reset');
    });
    $('#save-blog-button').on('click', function () {
        var $btn = $(this).button('loading');
        postOrSave(0);
        $btn.button('reset');
    });
    var postOrSave;
    layui.use(['layer', 'form'], function () {
        var layer = layui.layer;
        postOrSave = function (status) {
            var title = $('#blog-title').val();
            var content = editor.txt.html();
            var type = $('#blog-type').val();
            if (title.length < 4) {
                layer.msg('标题太短');
                return;
            }
            if (editor.txt.text().length < 10) {
                layer.msg('内容太短');
                return;
            }
            if (type.length < 2) {
                layer.msg('类型太短');
                return;
            }
            if (content.length < 14) {
                layer.msg('内容太短');
                return;
            }
            $.ajax({
                url: '../blog/updateBlog.do',
                type: 'post',
                data: {'id': ${blog.id}, 'title': title, 'content': content, 'type': type, 'status': status},
                success: function (data) {
                    layui.layer.msg(data.msg);
                }
            })
        };
        var writeBlogButton = $('#write-blog-button');
        /*  发布事件  */
        writeBlogButton.on('click', function () {
            window.location = '../pages/write_blog.jsp';
        });
        /*  发布事件结束  */
        <c:if test="${sessionScope.user == null}">
        writeBlogButton.unbind('click');    //未登录，解除之前事件，绑定新的事件
        /*  发布事件  */
        writeBlogButton.on('click', function () {
            $('[data-target="#login-box"]').click();    //未登录，先登录
        });
        </c:if>
        var username = $('#username-text');
        var error = $('#username-text-error');
        var updateButton = $('#update-username-button');
        username.on('change', function () {
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
                data: {'name': username.val()},
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

    });

</script>
</html>
