<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String path = request.getParameter("path");
  if (path == null || path.isEmpty()) {
    path = application.getRealPath("/");
  }

  File currentDir = new File(path);
  File[] files = currentDir.listFiles();

  // 安全限制：只允许查看应用内的目录
  String appBasePath = application.getRealPath("/");
  if (!path.startsWith(appBasePath)) {
    response.sendError(403, "无权访问该目录");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>目录列表 - <%= currentDir.getName() %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
  <h2>目录: <%= path %></h2>

  <nav aria-label="breadcrumb" class="my-3">
    <ol class="breadcrumb">
      <%
        String[] pathParts = path.substring(appBasePath.length()).split("[\\\\/]");
        String currentPath = appBasePath;
      %>
      <li class="breadcrumb-item">
        <a href="?path=<%= java.net.URLEncoder.encode(appBasePath, "UTF-8") %>">根目录</a>
      </li>
      <%
        for (String part : pathParts) {
          if (!part.isEmpty()) {
            currentPath = currentPath + File.separator + part;
      %>
      <li class="breadcrumb-item">
        <a href="?path=<%= java.net.URLEncoder.encode(currentPath, "UTF-8") %>"><%= part %></a>
      </li>
      <%
          }
        }
      %>
    </ol>
  </nav>

  <div class="table-responsive">
    <table class="table table-striped table-hover">
      <thead>
      <tr>
        <th>名称</th>
        <th>类型</th>
        <th>大小</th>
        <th>修改时间</th>
      </tr>
      </thead>
      <tbody>
      <% if (files != null) {
        for (File file : files) {
      %>
      <tr>
        <td>
          <% if (file.isDirectory()) { %>
          <a href="?path=<%= java.net.URLEncoder.encode(file.getAbsolutePath(), "UTF-8") %>">
            <strong><%= file.getName() %></strong>/
          </a>
          <% } else { %>
          <%= file.getName() %>
          <% } %>
        </td>
        <td>
          <% if (file.isDirectory()) { %>
          <span class="badge bg-primary">目录</span>
          <% } else { %>
          <span class="badge bg-secondary">文件</span>
          <% } %>
        </td>
        <td>
          <% if (file.isFile()) { %>
          <%= String.format("%,d bytes", file.length()) %>
          <% } else { %>
          -
          <% } %>
        </td>
        <td>
          <%= new java.util.Date(file.lastModified()) %>
        </td>
      </tr>
      <% }
      } else { %>
      <tr>
        <td colspan="4" class="text-center">无法读取目录或目录为空</td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>