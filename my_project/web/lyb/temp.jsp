<%@ page import="pojo.Cart" %>
<%@ page import="pojo.Good" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="pojo.Orders" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="util.IdUtils" %>
<%@ page import="pojo.OrdersItem" %>
<%@ page import="dao.UserDao" %>
<%@ page import="dao.OrderDao" %><%--
  Created by IntelliJ IDEA.
  User: lyb
  Date: 2023-12-26
  Time: 19:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>temp</title>
    <script>
      function func() {
        <%
    System.out.println("当前的代码被执行了！！！");
    if (request.getSession().getAttribute("cart") != null) {
      Cart cart1 = (Cart) request.getSession().getAttribute("cart");
      HashMap<Good, Integer> goods = cart1.getGoods(); // 得到购物车
      Set<Good> goodSet = goods.keySet(); // 得到键：商品
      Iterator<Good> iterator = goodSet.iterator();
      Orders orders = new Orders();

      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
      String currentFormattedDate = dateFormat.format(new java.util.Date());
      orders.setTime(currentFormattedDate);
      orders.setId(IdUtils.genId());
      orders.setNum(goodSet.size());
      int total_price = 0;
      while (iterator.hasNext()) { // 遍历所有的商品
        Good good = iterator.next(); // 得到购物车中的每件物品的信息
        // 将当前信息的信息分别保存到订单表和订单详情表中
        OrdersItem ordersItem = new OrdersItem();
        ordersItem.setOrder_id(orders.getId()); // 当前订单项的所属订单
        ordersItem.setNum(goods.get(good)); // 当前商品的购买数量
        total_price += good.getPrice() * goods.get(good); // 累加所有商品的价格
        ordersItem.setPrice(good.getPrice() * goods.get(good)); // 当前订单项的总价
        System.out.println("当前商品的单价为：" + good.getPrice() + "\n" + "当前商品的数量为：" + goods.get(good) + "\n");
        ordersItem.setGood_id(good.getId()); // 商品的id
        ordersItem.setGood(good); // 商品
        ordersItem.setId(IdUtils.genId());
        orders.getItems().add(ordersItem); // 将当前订单项放入订单中
      }
      orders.setTotal_price(total_price);
      UserDao userDao = new UserDao();
      OrderDao orderDao = new OrderDao();
      System.out.println("当前用户的id为：" + (int) request.getSession().getAttribute("currentUser"));
      System.out.println("当前用户为：" + userDao.SelectUserById((int) request.getSession().getAttribute("currentUser")));
      orderDao.addOrders(orders, userDao.SelectUserById((int) request.getSession().getAttribute("currentUser")));
      request.getSession().removeAttribute("cart"); // 删除session
      response.sendRedirect("http://localhost:8080/my_project_war_exploded/lyb/cart.jsp"); // 然后在重定向到当前页面
    }
  %>
      }
    </script>
</head>
<body onload="func()">

</body>
</html>
