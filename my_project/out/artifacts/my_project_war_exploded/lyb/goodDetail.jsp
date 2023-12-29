<%@ page language="java" contentType="text/html; charset=utf-8"
  import="dao.GoodsDAO,pojo.Good" %>
  <%@ page import="java.util.*" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
    function subNum() {
        let input = document.querySelector(".number");
        let t = parseInt(input.value) - 1;
        t = Math.max(0, t);
        input.value = t.toString();
    }
    function addNum() {
        let input = document.querySelector(".number");
        let t = parseInt(input.value);
        t += 1;
        input.value = t.toString();
    }
    function addToCart(id) {
        let num = document.querySelector(".number").value;
        window.location.href = "http://localhost:8080/my_project_war_exploded/CartServlet?action=add&id=" + id + "&num=" + num;
    }
</script>
 <style type="text/css">
	   div{
	      float:left;
	      margin-left: 30px;
	      margin-right:30px;
	      margin-top: 5px;
	      margin-bottom: 5px;
	   }
	   div dd{
	      margin:0px;
	      font-size:10pt;
	   }
	   div dd.dd_name
	   {
	      color:blue;
	   }
	   div dd.dd_city
	   {
	      color:#000;
	   }
       a {
           text-decoration: none;
       }
       body {
           background-image: url("../images/background.png");
           background-size: cover;
           background-repeat: no-repeat;
           background-position: center;
           color: #eeeeee;
       }
       h1 {
           font-size: 20pt;
           text-align: center;
           color: #a00d0d;
       }
       link {
           color: #a00d0d;
           float: left;
           border: 1px solid red;
       }
       </style>
</head>
<body>
 <h1>商品详情</h1>
 <div class="link"><a style="text-decoration: none;" href="http://localhost:8080/my_project_war_exploded/lyb/index.jsp">返回首页</a></div>
 <button ></button>
    <hr>
    <center>
      <table width="750" height="60" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <!-- 商品详情 -->
          <%
              GoodsDAO goodsDAO = new GoodsDAO();
              Good good = goodsDAO.getGoodById(Integer.parseInt(request.getParameter("id")));
              if (good != null) {
          %>
          <td width="70%" valign="top">
             <table style="margin-left: 30px">
               <tr>
                 <td rowspan="4"><img src="../images/<%=good.getPicture()%>" width="200" height="160"/></td>
               </tr>
               <tr>
                 <td><B><%=good.getName() %></B></td>
               </tr>
               <tr>
                 <td>产地：<%=good.getCity()%></td>
               </tr>
               <tr>
                 <td>价格：<%=good.getPrice() %>￥</td>
               </tr>
                <tr>
                    <td style="font-size: larger">购买数量：<button class="sub" onclick="subNum()">-</button><input class="number" name="number" value="1" size="2"><button class="add" onclick="addNum()">+</button></td>
                </tr>
             </table>
              <%--立即购买--%>
              <div id="cart">
                  <%--添加当前id的商品到购物车的按钮--%>
                  <%--href="CartServlet?action=add&id=<%=good.getId()%>&num='++'"--%>
                  <a href="javascript:addToCart(<%=good.getId()%>)">
                      <img src="../images/in_cart.png">
                  </a>
                  <%--展示购物车中的内容--%>
                  <a href="http://localhost:8080/my_project_war_exploded/CartServlet?action=show">
                      <img src="../images/view_cart.jpg">
                  </a>
              </div>
          </td>
          <% 
            }
          %>
          <%
              //从客户端获得Cookies集合
              String list = "";
              Cookie[] cookies = request.getCookies();
              if (cookies != null && cookies.length > 0) {
                  //遍历这个Cookies集合"ListViewCookie"
                  for (Cookie cookie : cookies) {
                      if (cookie.getName().equals("ListViewCookie")) {
                          list = URLDecoder.decode(cookie.getValue());
                      }
                  }
              }
              //加上刚刚浏览的这个商品的id
              list += request.getParameter("id") + ",";
              //如果浏览记录超过100条，清零.
              String [] arr = list.split(",");
              if (arr != null && arr.length >= 100) {
                  list = "";
              }
             //写回到cookie中
              Cookie cookie = new Cookie("ListViewCookie", URLEncoder.encode(list));
              response.addCookie(cookie);
          %>
          <!-- 浏览过的商品 -->
          <td width="30%" bgcolor="#EEE" align="center">
             <br>
             <h1>您浏览过的商品</h1><br>
             <!-- 循环开始 -->
             <%
                 ArrayList<Good> goodArrayList = goodsDAO.getViewList(list);
                 if (goodArrayList != null && goodArrayList.size() > 0) {
                    for (Good g : goodArrayList) {
             %>
             <div>
             <dl>
               <dt>
                 <a href="goodDetail.jsp?id=<%=g.getId()%>"><img src="../images/<%=g.getPicture()%>" width="120" height="90" border="1"/></a>
               </dt>
               <dd class="dd_name"><%=g.getName()%></dd>
               <dd class="dd_city">产地:&nbsp;<%=g.getCity()%>&nbsp;价格: ￥<%=g.getPrice()%> </dd>
             </dl>
             </div>
             <%
                   }
                }
             %>
             <!-- 循环结束 -->
          </td>
        </tr>
      </table>
    </center>
</body>
</html>