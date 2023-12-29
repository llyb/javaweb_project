<%@ page language="java" contentType="text/html; charset=utf-8"
  import="dao.GoodsDAO,pojo.Good" %>
  <%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
	   div{
	      float:left;
	      margin: 10px;
	   }
	   div dd{
	      margin:0px;
	      font-size:10pt;
	   }
	   div dd.dd_name
	   {
	      color:white;
           font-weight: bold;
	   }
	   div dd.dd_city
	   {
	      color:white;
           font-weight: bold;
	   }
       body {
           background-image: url("../images/background.png");
           background-size: cover;
           background-repeat: no-repeat;
           background-position: center;
           color: #eeeeee;
       }
       h1 {
           color: #ffffff;
           text-shadow: 0 0 10px #000000;
           text-align: center;
           font-family: 'Lobster', cursive;
           font-size: 48px;
           text-decoration: underline;
       }
       tr {
           font-size: 20px;
           font-family: 'Lobster', cursive;
           color: #ffffff;
           text-shadow: 0 0 10px #000000;
           border: 1px solid #000000;
       }
       .good {
           display: flex;
           flex-direction: column;
           align-items: center;
           justify-content: center;
           width: 200px;
           border: 1px solid #000000;
           margin: 10px;
           padding: 10px;
           background-color: rgba(0, 0, 0, 0.5);
           color: #ffffff;
           text-shadow: 0 0 10px #000000;
           font-family: 'Lobster', cursive;
           font-size: 20px;
       }
       .imgBox{
           border-top: 2px solid cadetblue;
           width: 100%;
           height: 250px;
           margin: 50px auto;
       }
       .imgBox img{
           width: 60%;
           height: 250px;
           margin: 0 auto;
           padding: 30px;
       }

       .img1{
           display: block;
       }

       .img2{
           display: none;
       }

       .img3{
           display: none;
       }
       .totop {
           position: fixed;
           right: 30px;
           bottom: 20px;
           z-index: 99;
           border: none;
           text-decoration: none;
           outline: none;
           color: #ffffff;
           /*默认是隐藏的*/
           display: none;
           cursor: pointer;
           width: 30px;
           height: 30px;
       }
        .close {
            cursor: pointer;
            float: right;
            font-size: 21px;
            font-weight: 700;
            line-height: 1;
            color: #000;
            text-shadow: 0 1px 0 #fff;
            opacity: 0.2;
        }
	</style>
    <script type="text/javascript">
        var index=0;
        //效果
        function ChangeImg() {
            index++;
            var a=document.getElementsByClassName("img-slide");
            if(index>=a.length) index=0;
            for(var i=0;i<a.length;i++) {
                a[i].style.display='none';
            }
            a[index].style.display='block';
        }
        //设置定时器，每隔两秒切换一张图片
        setInterval(ChangeImg,3000);

        window.onscroll = () => {
            if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                document.querySelector(".totop").style.display = "block";
            } else {
                document.querySelector(".totop").style.display = "none";
            }
        }

        function toTop() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }

        function Close() {
            console.log("close被执行");
            window.location.href = "http://localhost:8080/my_project_war_exploded/lyb/close.jsp";
        }
    </script>
</head>
<body>
    <button class="close" onclick="Close()">注销</button>
    <img class="totop" onclick="toTop()" src="../images/totop.png">
    <h1>商品展示</h1>
    <%--  实现轮播图效果  --%>
    <div class="imgBox">
        <img class="img-slide img1" src="../images/001.jpg" alt="1">
        <img class="img-slide img2" src="../images/002.jpg" alt="2">
        <img class="img-slide img3" src="../images/003.jpg" alt="3">
    </div>
    <br>
    <center>
    <table width="1000" height="60" cellpadding="0" cellspacing="0" border="1px solid white">
      <tr>
        <td>
          <!-- 商品循环开始 -->
            <%
                ArrayList<Good>list = new ArrayList<Good>();
                GoodsDAO goodsDAO = new GoodsDAO();
                list = goodsDAO.getAllGoods();
                if (list != null) {
                    for (int i = 0; i < list.size(); i ++) {
                        Good good = list.get(i);
            %>
          <div class="good">
             <dl>
               <dt>
                 <a href="goodDetail.jsp?id=<%=good.getId()%>"><img src="../images/<%=good.getPicture()%>" width="120" height="90" border="1"/></a>
               </dt>
               <dd class="dd_name">商品名称：<%=good.getName() %></dd>
               <dd class="dd_city">产地:&nbsp;<%=good.getCity()%>&nbsp;价格:￥<%=good.getPrice()%> </dd>
             </dl>
          </div>
          <!-- 商品循环结束 -->
          <%
                  }
              }
          %>
        </td>
      </tr>
    </table>
    </center>
</body>
</html>