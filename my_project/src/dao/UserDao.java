package dao;

import pojo.User;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    public User SelectUserById(int user_id) {
        try {
            connection = DBUtil.getCon();
            String sql = "select * from user where user_id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, user_id);
            resultSet = statement.executeQuery();
            User user = new User();
            while (resultSet.next()) {
                user.setId(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
            }
            return user;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                DBUtil.closeAll(connection, statement, resultSet);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
    public int selectIdByName(String username) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DBUtil.getCon();
            String sql = "select user_id from user where username = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("user_id");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                DBUtil.closeAll(connection, statement, resultSet);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

    public boolean setStateById(int userId, int islogin) {
        try {
            connection = DBUtil.getCon();
            String sql = "update user set islogin = ? where user_id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, islogin);
            statement.setInt(2, userId);
            int i = statement.executeUpdate();
            return i == 1;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                DBUtil.closeAll(connection, statement, resultSet);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}
