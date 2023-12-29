<%@ page import="pojo.User" %>
<%@ page import="dao.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="pojo.Orders" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.DBUtil" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.OrderDao" %><%--
  Created by IntelliJ IDEA.
  User: lyb
  Date: 2023-12-25
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单展示</title>
    <style>
        body {
            background-image: url("../images/background.png");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            color: #eeeeee;
        }
        .table {
            display: flex;
            flex-direction: column;
            width: 800px; /* 可根据需要设置表格宽度 */
            border: 1px solid #ccc;
            margin: 10px auto;
        }
        .row {
            display: flex;
            flex-direction: row;
            align-items: center;
            font-size: 18px;

        }
        .header {
            display: flex;
            color: black;
            font-weight: bold;
            font-size: larger;
        }
        .cell {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
        }
        h1 {
            text-align: center;
            margin: 40px 0;
            color: #333;
        }
        .link {
            float: left;
            margin-left: 10px;
            color: #333;
            text-decoration: none;
            font-size: larger;
            font-weight: bold;
            background-color: #eee;
            padding: 5px 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="link"><a href="http://localhost:8080/my_project_war_exploded/lyb/index.jsp">返回首页</a></div>
<h1>当前用户订单展示</h1>
<div class="table">
    <div class="header">
        <div class="cell">订单编号</div>
        <div class="cell">订单总价</div>
        <div class="cell">商品种类数</div>
        <div class="cell">创建时间</div>
        <div class="cell">订单状态</div>
    </div>
<%
    // 查询当前用户的订单记录
    OrderDao orderDao = new OrderDao();
    int user_id = (int) request.getSession().getAttribute("currentUser");
    List<Orders> ordersList = orderDao.findOrdersByUserId(user_id);
    for (Orders order : ordersList) {
%>
    <div class="row">
        <div class="cell"><%=order.getId()%></div>
        <div class="cell"><%=order.getTotal_price()%></div>
        <div class="cell"><%=order.getNum()%></div>
        <div class="cell"><%=order.getTime()%></div>
        <div class="cell">
            <%
                if (order.getState() == 0) {
                    out.print("未发货");
                } else {
                    out.print("已发货");
                }
            %>
        </div>
    </div>
<%
    }
%>
</div>
</body>
</html>
