package util;

import java.sql.*;

public class DBUtil {
    private static Connection connection;
    public static Connection getCon() throws ClassNotFoundException, SQLException {
        // 加载驱动
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url="jdbc:mysql://localhost:3306/shopping?useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=utf8&serverTimezone=GMT";
        String username = "root";
        String password = "lyb1235118";
        // 获得连接
        connection = DriverManager.getConnection(url, username, password);
        return connection;
    }
    public static void closeAll(Connection connection, PreparedStatement statement, ResultSet rs) throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (connection != null) {
            connection.close();
        }
    }
}