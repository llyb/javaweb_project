<%@ page import="dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: lyb
  Date: 2023-12-26
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>close</title>
  <script>
    function func() {
      <%
        System.out.println("close被执行");
        int user_id = (int) request.getSession().getAttribute("currentUser");
        UserDao userDao = new UserDao();
        System.out.println("修改结果为：" + userDao.setStateById(user_id, 0));
        System.out.println("当前登录用户的userid值为：" + user_id);
        request.getSession().removeAttribute("currentUser"); // 移出当前用户
        System.out.println("currentUser被移出");

//        // 删除用户cookie
//        Cookie[] cookies = request.getCookies();
//        if (cookies != null) {
//          for (Cookie cookie : cookies) {
//            if (cookie.getName().equals("username")) {
//                cookie.setPath("/my_project_war_exploded");
//                cookie.setMaxAge(0);
//                response.addCookie(cookie);
//                System.out.println("cookie被删除了！！！");
//              break;
//            }
//          }
//        }
      %>
    }
  </script>
    <style>
        a {
            text-decoration: none;
            color: #4CAF50;
            font-size: 18px;
            margin-left: 40%;
            margin-top: 10%;
        }
    </style>
</head>
<body onload="func()">
<h1>用户已成功注销！</h1>
<a href="http://localhost:8080/my_project_war_exploded/login.jsp">点击进入登录界面</a>
</body>
</html>
