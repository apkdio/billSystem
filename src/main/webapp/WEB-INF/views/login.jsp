<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="zh-CN">
<head>
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录</title>
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-card {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="card login-card">
                <div class="card-header text-center bg-primary text-white">
                    <h4 class="mb-0">登录</h4>
                </div>
                <div class="card-body p-4">
                    <form action="login" method="post">
                        <div class="form-floating mb-3">
                            <input type="text" name="username" class="form-control" id="username" placeholder="请输入用户名">
                            <label for="username" class="form-label">用户名</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input name="password" type="password" class="form-control" id="password" placeholder="请输入密码">
                            <label for="password" class="form-label">密码</label>
                            <c:if test="${not empty error}">
                            <span id="error" style="color: red"><c:out value="${error}"/></span>
                            </c:if>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">登录</button>
                        </div>
                        <div class="text-center mt-3">
                            <a href="<c:url value="/register"/>" class="text-decoration-none">没有账号?去注册！</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</di


<link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script></div>
</body>
</html>