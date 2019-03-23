<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 2019-03-21
  Time: 20:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0">
    <link href="../static/css/bootstrap.min.css" rel="stylesheet">
    <title>用户中心</title>
</head>
<body style="background-color: #EEEEEE">
<c:if test="${sessionScope.user == null}">
    <c:redirect url="../index.jsp"/>
</c:if>
<div class="container">
    <a class="btn btn-default navbar-btn" href="../index.jsp">首页</a>
    <div style="background-color: #FFFFFF; padding: 20px">
        <div class="row">
            <div class="col-md-1"><label for="user-name-input">用户名</label></div>
            <div class="col-md-10"><input type="text" id="user-name-input" class="form-control" value="${sessionScope.user.name}"></div>
            <div class="col-md-1"><button class="btn btn-primary">修改</button></div>
        </div>
        <hr>
        <small>我发布的</small>
    </div>
</div>
</body>
</html>
