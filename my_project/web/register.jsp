<%--
  Created by IntelliJ IDEA.
  User: lyb
  Date: 2023-12-24
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>登录界面</title>
  <style>
    body {
      background-image: url("images/background.png");
      background-size: cover;
      background-repeat: no-repeat;
      background-position: center;
      color: #eeeeee;
    }
    form {
      width: 400px;
      height: 350px;
      margin: 100px auto;
      background-color: rgba(255, 255, 255, 0.5);
      border-radius: 10px;
      padding: 20px;
    }
    input {
      width: 200px;
      height: 30px;
      margin: 10px auto;
      border-radius: 5px;
    }
    .check {
      width: 100px;
      height: 30px;
      margin: 10px auto;
      border-radius: 5px;
    }
    h1 {
      text-align: center;
    }
  </style>
</head>
<body>
<form action="register" method="post">
  <h1>用户注册界面</h1>
  <div class="content">
    用户名：<input style="margin-left: 20px" type="text" name="username"><br>
    密码：<input style="margin-left: 34px" type="password" name="password"><br>
    确认密码：<input style="margin-left: 5px" type="password" name="Confirmedpassword"><br>
    <input style="margin-left: 100px;" type="submit" value="注册">
  </div>
</form>
</body>
</html>
