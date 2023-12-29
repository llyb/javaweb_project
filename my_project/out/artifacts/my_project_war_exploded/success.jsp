<%--
  Created by IntelliJ IDEA.
  User: lyb
  Date: 2023-12-23
  Time: 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>success</title>
  <style>
    p {
      font-size: 20px;
      font-family: "Microsoft YaHei";
      color: #333333;
      text-align: center;
      margin-top: 50px;
      margin-bottom: 50px;
    }
    a {
      font-size: 20px;
      font-family: "Microsoft YaHei";
      color: #333333;
      margin-top: 50px;
      margin-bottom: 50px;
    }
  </style>
</head>
<body>
  <img src="images/add_cart_success.jpg">
  <hr>
  <%
    String id = request.getParameter("id");
    String number = request.getParameter("num");
  %>
  <p>您已经成功加入购物车：商品的件数为：<%=number%>，编号为：<%=id%></p>
  <a href="http://localhost:8080/my_project_war_exploded/lyb/goodDetail.jsp?id=<%=id%>">点击返回继续购买</a>
  <br>
  <br>
  <br>
</body>
</html>
