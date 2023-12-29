import dao.GoodsDAO;
import pojo.Good;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class test {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        //1 加载驱动 反射 类加载---静态代码块 java程序知道使用了哪种数据库
        Class.forName("com.mysql.cj.jdbc.Driver");
        //链接字符串 其中test是数据库的名称
        String url="jdbc:mysql://localhost:3306/shopping?useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&serverTimezone=GMT";
        String username="root";
        String password="lyb1235118";//密码是安装配置mysql时的密码。
        //2 获得链接
        Connection connection= DriverManager.getConnection(url, username, password);
        if (connection!=null)
            System.out.println(connection);
        //3 通过Connection对象获得Statement对象
        Statement statement= connection.createStatement();
        //4 执行sql语句省略
        ArrayList<Good> list = new ArrayList<>();
        GoodsDAO goodsDAO = new GoodsDAO();
        list = goodsDAO.getAllGoods();
        System.out.println(list);
        //6 关闭资源
        connection.close();
    }
}
