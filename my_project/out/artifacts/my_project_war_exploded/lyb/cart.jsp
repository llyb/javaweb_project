<%@ page import="pojo.Cart" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="pojo.Good" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Set" %>
<%@ page import="javax.websocket.Session" %>
<%@ page import="pojo.OrdersItem" %>
<%@ page import="pojo.Orders" %>
<%@ page import="util.IdUtils" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dao.OrderDao" %>
<%@ page import="dao.UserDao" %><%--
  Created by IntelliJ IDEA.
  User: lyb
  Date: 2023-12-23
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>cart</title>
    <script type="text/javascript">
        function delconfirm() {
            if (!confirm("确认删除？")) {
                window.event.returnValue = false;
            }
        }
        function tackle() {
            if (!confirm("确认提交订单？")) {
                window.event.returnValue = false;
                return;
            }
            // 解决js函数中自动执行java代码的问题
            window.location.href = "http://localhost:8080/my_project_war_exploded/lyb/temp.jsp";
            alert("提交成功！");
        }
    </script>
    <style>
        body {
            background-image: url("../images/background.png");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            color: #eeeeee;
        }
        table{
            width: 100%;
            border-collapse: collapse;
        }

        table caption{
            font-size: 2em;
            font-weight: bold;
            margin: 1em 0;
        }

        th,td{
            border: 1px solid #999;
            text-align: center;
            padding: 20px 0;
        }

        table thead tr{
            background-color: #008c8c;
            color: #fff;
        }

        table tbody tr:nth-child(odd){
            background-color: #eee;
        }

        table tbody tr:hover{
            background-color: #ccc;
        }

        table tbody tr td:first-child{
            color: #f40;
        }

        table tfoot tr td{
            text-align: right;
            padding-right: 20px;
        }

        .link>a {
            text-decoration: none;
            color: #000;
        }
        .link {
            display: inline-block;
            margin: 20px;
            padding: 10px;
            border: 1px solid #000;
            border-radius: 10px;
            background-color: #008c8c;
            color: #fff;
            font-size: 1.5em;
            text-align: center;
            text-decoration: none;
        }
        .total {
            margin: 20px;
            padding: 10px;
            border: 1px solid #000;
            border-radius: 10px;
            background-color: #008c8c;
            color: #fff;
            font-size: 1.5em;
            text-align: center;
            text-decoration: none;
        }
        .goodImg {
            width: 100px;
            height: 100px;
        }
        button {
            float: right;
            margin-top: 10px;
            margin-right: 10px;
            font-size: 1.2em;
            padding: 10px 20px;
            background-color: #008c8c;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
  <div class="link"><a href="http://localhost:8080/my_project_war_exploded/lyb/index.jsp">返回首页</a></div>
  <div id="shopping">
      <form action="" method="">
          <table>
              <caption>购物车展示</caption>
              <thead>
                  <tr>
                      <th>商品名称</th>
                      <th>商品单价</th>
                      <th>购买数量</th>
                      <th>总价格</th>
                      <th>操作</th>
                  </tr>
              </thead>
                <%--循环的开始--%>
              <%
                    if (request.getSession().getAttribute("cart") != null) {
                        Cart cart = (Cart) request.getSession().getAttribute("cart");
                        System.out.println("购物车为：" + cart);
                        HashMap<Good, Integer> goods = cart.getGoods();
                        Set<Good>  goodSet = goods.keySet();
                        Iterator<Good> iterator = goodSet.iterator();
                        while (iterator.hasNext()) {
                            Good good = iterator.next();
              %>
              <tbody>
                  <tr class="product">
                      <td>
                          <img class="goodImg" src="../images/<%=good.getPicture()%>" alt="图片无法显示">
                          <div style="font-size: medium; color: black;"><%=good.getName()%>></div>
                      </td>
                      <%--每件商品的单价--%>
                      <td class="number" style="color: black"><%=good.getPrice()%></td>
                      <%--购买的数量--%>
                      <td class="number" style="color: black">
                          <%=goods.get(good)%>
                      </td>
                      <%--总价--%>
                      <td class="price" style="color: black">
                          <span><%=good.getPrice() * goods.get(good)%></span>
                      </td>
                      <td class="delete">
                          <a onclick="delconfirm()" href="http://localhost:8080/my_project_war_exploded/CartServlet?action=delete&id=<%=good.getId()%>">删除</a>
                      </td>
                  </tr>
              </tbody>
                <%--循环的结束--%>
              <%
                        }
              %>
              <div class="total">
                  <span class="toatal">总金额：<%=cart.calTotalPrice()%></span>
              </div>
              <%
                  }
              %>
          </table>
          <button onclick="tackle()" style="margin-right: 10px">提交订单</button>
          <button><a style="text-decoration: none; color: white" href="http://localhost:8080/my_project_war_exploded/lyb/orderShow.jsp">查看订单</a></button>
      </form>
  </div>
</body>
</html>
