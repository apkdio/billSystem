<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册</title>
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
                    <h4 class="mb-0">注册</h4>
                </div>
                <div class="card-body p-4">
                    <form id="register_from">
                        <div class="form-floating mb-3">
                            <input type="text" name="username" class="form-control" id="username"
                            placeholder="请输入用户名">
                            <label for="username" class="form-label">用户名</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input name="password" type="password" class="form-control" id="password"
                            placeholder="请输入密码">
                            <label for="password" class="form-label">密码</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input name="con_password" type="password" class="form-control" id="con_password"
                            placeholder="再次输入密码">
                            <label for="password" class="form-label">确认密码</label>
                        </div>
                        <span id="error" style="color: red"></span>
                        <div class="d-grid">
                            <button class="btn btn-primary" type="button" onclick="check()">注册</button>
                        </div>
                        <div class="text-center mt-3">
                            <a href="<c:url value="/login"/>" class="text-decoration-none">有账号?去登录！</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function check() {
        const username = document.getElementById("username").value;
        const pass = document.getElementById("password").value;
        const con_pass = document.getElementById("con_password").value;
        error_inf = document.getElementById("error");
        error_inf.innerHTML = "";
        if (!username || !pass || !con_pass) {
            error_inf.innerHTML = "存在空字段！";
        } else {
            const data = new URLSearchParams();
            data.set("username", username);
            data.set("password", pass);
            if (pass === con_pass) {
                fetch("${pageContext.request.contextPath}/register",
                    {
                        method: "POST",
                        headers: {"Content-Type": "application/x-www-form-urlencoded"},
                        body: data,
                    })
                    .then(res => res.json())
                    .then(data => {
                        if (data.success) {
                            alert("注册成功！")
                            window.location.href = "${pageContext.request.contextPath}/login";
                        } else {
                            error_inf.innerHTML = data.error;
                        }
                    })
            } else {
                error_inf.innerHTML = "两次密码不一致！";
            }
        }
    }
</script>

<link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>