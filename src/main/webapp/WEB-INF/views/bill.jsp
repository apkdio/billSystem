<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>账单查看</title>
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #31c59e 0%, #15d3dd 100%);
            min-height: 100vh;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .user-icon {
            font-size: 1.2rem;
            color: #70beff;
        }

        .bill-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            padding: 25px;
            margin-top: 20px;
        }

        .user-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }


        .table-container {
            overflow-x: auto;
        }

        .table th {
            background-color: #f8f9fa;
            color: #495057;
            font-weight: 600;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.05);
        }

        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 25px;
        }

        .page-title {
            color: white;
            text-align: center;
            margin-bottom: 20px;
            font-weight: 600;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
<div class="main-container">
    <h1 class="page-title">账单查看</h1>

    <div class="bill-card">
        <div class="user-info">
            <div class="user-icon">
                <i class="fas fa-user-circle"></i>
                ${sessionScope.user}
                <a class="btn btn-outline-primary"
                   style="--bs-btn-font-size: .75rem;--bs-btn-padding-y: 0px"
                   href="${pageContext.request.contextPath}/information">返回</a>
            </div>
            <div style="margin-right: 60px">
                <div>总收入:${requestScope.income}</div>
                <div>总支出:${requestScope.outcome}</div>
            </div>
            <div>
                <span class="badge bg-primary">账单总数: ${requestScope.totalBill}</span>
            </div>
        </div>
        <div class="table-container">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">账单ID</th>
                    <th scope="col">类型</th>
                    <th scope="col">金额</th>
                    <th scope="col">时间</th>
                    <th scope="col">备注</th>
                    <th scope="col">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty data}">
                        <c:forEach items="${data}" var="bill">
                            <tr>
                                <td>${bill.bill_id}</td>
                                <td>${bill.type}</td>
                                <td>${bill.money}</td>
                                <td>${bill.time}</td>
                                <td>${bill.comment}</td>
                                <td>
                                    <a class="btn btn-outline-primary" data-bs-target="#billEdit" data-bs-toggle="modal"
                                       onclick="edit_data(${bill.bill_id})">编辑</a>
                                    <a class="btn btn-outline-danger" onclick="delete_data(id=${bill.bill_id})">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td>无数据</td>
                            <td>无数据</td>
                            <td>无数据</td>
                            <td>无数据</td>
                            <td>无数据</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <div class="pagination-container">
            <nav aria-label="账单分页">
                <ul class="pagination">
                    <li class="page-item disabled">
                        <c:set var="currentPage"
                               value="${not empty requestScope.currentPage ? requestScope.currentPage : 1}"/>
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/bill?page=${currentPage-1}"
                        ${currentPage <= 1 ? 'aria-disabled="true"' : ''}>
                            上一页
                        </a>
                    </li>
                    </li>
                    <li class="page-item">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/bill?page=${currentPage+1}">下一页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
<div class="modal fade" id="billEdit" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">编辑账单</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="makeBillForm">
                    <div class="form-group mb-3">
                        <label class="form-label">类型</label>
                        <select id="select" class="form-select" aria-label="Default select example">
                            <option id="select_0" value="0">收入</option>
                            <option id="select_1" value="1">支出</option>
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
                <button type="button" class="btn btn-primary" onclick="update()">提交</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script>
    function edit_data(id) {
        localStorage.setItem("editID", id);
        fetch("${pageContext.request.contextPath}/billEdit?bid=" + id, {method: "GET"})
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    const bill = data.success;
                    if (bill.type === "收入") {
                        document.getElementById("select_0").selected = true;
                    } else if (bill.type === "支出") {
                        document.getElementById("select_1").selected = true;
                    } else {
                        alert("无法获取账单类型原数据！")
                        window.location.reload();
                    }
                    document.getElementById("money").value = bill.money;
                    document.getElementById("comment").value = bill.comment;
                    document.getElementById("date").value = bill.time;
                } else {
                    alert("原数据数据拉取出错！")
                    window.location.reload();
                }
            })
    }

    function update() {
        const id = localStorage.getItem("editID");
        const number_error = document.getElementById('number_error');
        const date_error = document.getElementById('time_error');
        number_error.innerText = "";
        date_error.innerText = "";
        var type = document.getElementById('select').value;
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
        if (type === "0") {
            type = "收入"
        } else if (type === "1") {
            type = "支出"
        } else {
            alert("类型数据有误！")
            return
        }
        data.set('date', date);
        data.set('money', money);
        data.set('type', type);
        data.set('comment', comment);
        fetch("${pageContext.request.contextPath}/billEdit?bid=" + id, {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: data
        }).then((response) => response.text())
            .then(data => {
                if (data === "success") {
                    alert("数据更新成功!")
                    window.location.reload();
                } else {
                    alert("更新失败！请重试!")
                }
            })
    }

    function formatDateTime(date) {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        return year + '-' + month + '-' + day + 'T' + hours + ':' + minutes;
    }

    function delete_data(id) {
        if (confirm("确定删除此数据？")) {
            fetch("${pageContext.request.contextPath}/billDelete?bid="+id, {method: "GET"})
                .then((response) => response.text())
                .then(data => {
                    if (data === "success") {
                        alert("删除成功！")
                        window.location.reload();
                    } else {
                        alert("删除失败！")
                    }
                })
        }
    }
</script>
</body>
</html>