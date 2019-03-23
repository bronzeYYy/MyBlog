<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0">
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/oneui.css" rel="stylesheet">
<title>简易博客</title>
<body style="background-color: #EEEEEE">

<div class="container">
    <div class="text-right">
        <%--<strong style="font-size: 30px">欢迎你</strong>--%>

        <div class="dropdown">
            <label style="float: left; margin-top: 15px" class="control-label" id="now-status">全部</label>
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
                <li><a href="index.jsp">所有博客</a></li>
                <li><a href="index.jsp?status=1">我发布的</a></li>
                <li><a href="index.jsp?status=0">我的草稿</a></li>
                <li><a href="#" id="login-out">退出登录</a></li>
            </ul>
        </c:if>
        </div>
    </div>
    <%--<div class="form-group" style="background-color: #FFFFFF; padding: 5px 30px 20px 30px; cursor: pointer"  data-toggle="tooltip" title="查看全文">
        <h2 class="text-center" style="margin-bottom: 15px">标题</h2>
        <div class="lead" style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical">部分内fdshfudsfuiguifdigidddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddfjdsoijfoisd容</div>
        <hr>
        <small><span>发布人</span>发布时间</small>
    </div>--%>
    <%--<hr>
    <p class="text-center"><span style="margin-right: 20px">第</span><a style="margin-right: 10px">1</a><a style="margin-right: 20px">2</a><span>页</span></p>--%>
</div>
<c:if test="${sessionScope.user == null}">
    <%--登录框--%>
    <div class="modal fade" id="login-box" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">登录</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="login-name" class="control-label">账号</label>
                            <input type="text" class="form-control" id="login-name" placeholder="用户名">
                        </div>
                        <div class="form-group">
                            <label for="login-password" class="control-label">密码</label>
                            <input type="password" class="form-control" id="login-password" placeholder="密码">
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
                            <input type="text" class="form-control" id="register-name" placeholder="用户名">
                        </div>
                        <div class="form-group">
                            <label for="register-password" class="control-label">密码</label>
                            <input type="password" class="form-control" id="register-password" placeholder="密码">
                        </div>
                        <div class="form-group">
                            <label for="register-password2" class="control-label">确认密码</label>
                            <input type="password" class="form-control" id="register-password2" placeholder="确认密码">
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
<script src="static/js/jquery-3.2.1.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/layui/layui.js"></script>

<script>
    layui.use(['layer', 'form'], function () {
        var layer = layui.layer;
        var statusText = $('#now-status');
        <c:choose>
        <c:when test="${param.status == 0}">
        statusText.text('我的草稿');
        <c:if test="${sessionScope.user == null}">
        layer.msg('没有登录');
        setTimeout(function () {
            window.location = 'index.jsp'
        }, 1000);
        </c:if>
        </c:when>
        <c:when test="${param.status == 1}">
        statusText.text('我发布的');
        <c:if test="${sessionScope.user == null}">
        layer.msg('没有登录');
        setTimeout(function () {
            window.location = 'index.jsp'
        }, 1000);
        </c:if>
        </c:when>
        <c:otherwise>
        statusText.text('全部');
        </c:otherwise>
        </c:choose>
        var start = ${param.page == null ? 0 : param.page - 1};      //页数
        var length = 8;     //每页显示8个
        var status = ${param.status == null ? -1 : param.status};    //状态，是否为获取用户的博客，0 用户草稿  1 用户博客  其他 显示所有
        var writeBlogButton = $('#write-blog-button');
        /*  发布事件  */
        writeBlogButton.on('click', function () {
            window.location = 'pages/write_blog.jsp';
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
                url: 'user/register.do',
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
                url: 'user/login.do',
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
                url: 'user/updateName.do',
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
                url: 'user/loginOut.do',
                type: 'post',
                success: function (data) {
                    layer.msg(data.msg);
                    if (data.success) {
                        setTimeout(function () {
                            window.location.reload(true);
                        }, 500)
                    }
                }
            })
        });
        /*  获取博客  */
        var getBlogs = function () {
            $.ajax({
                url: 'blog/getBlogs.do',
                type: 'post',
                data: {'start': start, 'length': length, 'status': status},
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var div = $('<div>', {
                            class: 'form-group',
                            style: 'background-color: #FFFFFF; padding: 20px 30px 20px 30px',
                            'data-toggle': 'tooltip'
                        });
                        //添加标题
                        div.append($('<h3>', {
                            text: data[i].title,
                            class: 'text-center',
                            style: 'margin-bottom: 15px; cursor: pointer',
                            title: '查看全文',
                            name: data[i].id,
                            click: function () {
                                window.location = 'blog/' + $(this).attr('name') + '.html';
                            }
                        }));
                        var html = getText(data[i].content);

                        //添加预览
                        div.append($('<p>', {
                            text: html,
                            class: 'lead',
                            style: 'font-size: 17px; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; cursor: pointer',
                            title: '查看全文',
                            name: data[i].id,
                            click: function () {
                                window.location = 'blog/' + $(this).attr('name') + '.html';
                            }
                        }));
                        div.append($('<hr>'));
                        var time = data[i].pubTime;
                        //脚步
                        var footer = $('<div>');
                        footer.append($('<small>', {
                            text: data[i].username + "发表于" + time.substr(0, time.length - 5)
                        }));
                        <c:if test="${param.status == 0 || param.status == 1}">
                        var fDiv = $('<div>', {
                            style: 'float: right'
                        });
                        //编辑按钮
                        fDiv.append($('<button>', {
                            text: '编辑',
                            class: 'btn btn-primary',
                            style: 'margin-right: 5px',
                            name: data[i].id,
                            click: function () {
                                window.location = 'updateBlog/' + $(this).attr('name') + '.html'
                            }
                        }));
                        //删除按钮
                        fDiv.append($('<button>', {
                            text: '删除',
                            class: 'btn btn-danger',
                            name: data[i].id,
                            click: function () {
                                var blogId = $(this).attr('name');
                                layer.confirm('确定删除？删除后不可恢复', {btn: ['删除', '取消'], title: '警告'},
                                    function () {
                                    $.ajax({
                                        url: 'blog/deleteBlog.do',
                                        type: 'post',
                                        data: {'id': blogId},
                                        success: function (data) {
                                            layer.msg(data.msg);
                                            if (data.success) {
                                                setTimeout(function () {
                                                    window.location.reload(true);
                                                }, 500)
                                            }
                                        }
                                    })
                                })
                            }
                        }));
                        footer.append(fDiv);
                        </c:if>

                        div.append(footer);
                        $('.container').append(div);

                    }
                    /*  设置页数  */
                    $.ajax({
                        url: 'blog/count.do',
                        type: 'post',
                        data: {'status': status},
                        success: function (data) {
                            /* 添加导航 */
                            var nav_p = $('<p>', {
                                class: 'text-center',
                                style: 'margin-bottom: 40px'
                            });
                            nav_p.append($('<span>', {
                                text: '第',
                                style: 'margin-right: 20px'
                            }));
                            for (var i = 0; i < Math.ceil(data.n / 10); i++) {

                                if (i === start) {
                                    nav_p.append($('<span>', {
                                        style: 'margin-right: 10px',
                                        text: i + 1
                                    }));
                                } else {
                                    nav_p.append($('<a>', {
                                        style: 'margin-right: 10px',
                                        text: i + 1,
                                        href: 'index.jsp?page=' + Math.floor(i + 1) + '&status=' + status
                                    }));
                                }
                            }
                            nav_p.append($('<span>', {
                                text: '页',
                                style: 'margin-left: 10px'
                            }));
                            nav_p.appendTo($('.container'));
                            /* 添加导航结束 */
                        }
                    });
                    /*  设置页数结束  */
                }
            });
        };
        getBlogs();

        var getText = function removeHTMLTag(str) {

            str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
            str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
            //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
            str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
            str=str.replace(/\s/g,''); //将空格去掉
            return str;
        }
    })
</script>

</html>
