<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人记账系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #31c59e 0%, #15d3dd 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-card {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            padding: 2rem;
            max-width: 500px;
            width: 90%;
            margin: 0 auto;
            transition: transform 0.3s ease;
        }


        .user-info {
            text-align: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid #eee;
            margin-bottom: 1.5rem;
        }

        .user-icon {
            font-size: 3rem;
            color: #70beff;
        }

        .username {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .welcome-text {
            color: #666;
            font-size: 1rem;
        }

        .btn-custom {
            padding: 0.8rem 1.5rem;
            font-size: 1.1rem;
            border-radius: 10px;
            margin: 0.5rem;
            transition: all 0.3s ease;
            font-weight: 500;
            width: 200px;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 1.5rem;
        }

        @media (min-width: 768px) {
            .button-container {
                flex-direction: row;
                justify-content: center;
            }
        }

        .hitokoto {
            background: linear-gradient(#2aabd2, #5eb95e, #e38d13);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
    <script>
        fetch('https://v1.hitokoto.cn/',
            {method: "GET"})
            .then(response => response.json())
            .then(data => {
                const hitokoto = document.getElementById('hitokoto')
                hitokoto.innerText = data.hitokoto
                const from = document.getElementById('from')
                from.innerText = "《" + data.from + "》"
            })
            .catch(error => {
                const hitokoto = document.getElementById('hitokoto');
                hitokoto.innerText = 'hitokoto API 好像出了一些小问题...';
            })
    </script>
</head>
<body>
<div class="container">
    <div class="main-card">
        <p id="hitokoto" class="hitokoto"
           style="padding: 0;margin-bottom: 0;font-family: 方正粗圆_GBK;font-size:large;"></p>
        <p id="from" align="right" class="hitokoto"
           style="font-family: 黑体;padding-top: 5px;font-size:larger;font-weight: bold"></p>
        <div class="user-info">
            <div class="user-icon">
                <i class="fas fa-user-circle"></i>
            </div>
            <div class="username">
                ${sessionScope.user}
            </div>
            <div class="welcome-text">欢迎使用个人记账系统</div>
        </div>

        <div class="button-container">
            <button type="button" href="" class="btn btn-custom btn-primary" data-bs-target="#makeBill"
                    data-bs-toggle="modal">
                <i class="fas fa-pen-alt me-2"></i>记账
            </button>
            <a href="${pageContext.request.contextPath}/bill" class="btn btn-custom btn-secondary">
                <i class="fas fa-search-dollar me-2"></i>查账
            </a>
            <a href="<c:url value="/logout"/>" class="btn btn-custom btn-danger">
                <i class="fas fa-sign-out me-2" ></i>退出
            </a>
        </div>
    </div>
</div>
<div class="modal fade" id="makeBill" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">记账</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="makeBillForm">
                    <div class="form-group mb-3">
                        <label class="form-label">类型</label>
                        <select id="select" class="form-select" aria-label="Default select example">
                            <option selected value="0">收入</option>
                            <option value="1">支出</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">金额</label>
                        <input type="number" id="money" class="form-control" placeholder="0.00">
                        <span id="number_error" style="color: red"></span>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">日期</label>
                        <input type="datetime-local" max="" id="date" class="form-control" placeholder="">
                        <span id="time_error" style="color: red"></span>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">备注</label>
                        <input type="text" id="comment" class="form-control" placeholder="请输入备注">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="makeBill()">提交</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script>
    function formatDateTime(date) {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        return year + '-' + month + '-' + day + 'T' + hours + ':' + minutes;
    }
</script>
<script>
    function makeBill() {
        const number_error = document.getElementById('number_error');
        const date_error = document.getElementById('time_error');
        number_error.innerText = "";
        date_error.innerText = "";
        const type = document.getElementById('select').value;
        const money = document.getElementById('money').value;
        const date = document.getElementById('date').value;
        const comment = document.getElementById('comment').value;
        if (!date) {
            date_error.innerHTML = '请选择时间!';
            return
        }
        const now = new Date();
        const max = formatDateTime(now)
        if (date > max) {
            date_error.innerHTML = "时间不合法！";
            return
        }
        if (!money) {
            number_error.innerHTML = '金额不能为0!';
            return
        } else {
            if (money < 0) {
                number_error.innerHTML = '金额不能小于0!';
                return
            }
        }
        const data = new URLSearchParams();
        data.set('date', date);
        data.set('money', money);
        data.set('type', type);
        data.set('comment', comment);
        fetch("${pageContext.request.contextPath}/makeBill", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: data
        }).then((response) => response.text())
            .then(data => {
                if (data === "success") {
                    alert("添加成功!")
                    bootstrap.Modal.getInstance(document.getElementById('makeBill')).hide();
                } else {
                    alert("添加失败！请重试!")
                }
            })
    }
</script>

</body>
</html>