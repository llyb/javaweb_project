package dao;

import pojo.Orders;
import pojo.OrdersItem;
import pojo.User;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    // 将订单信息保存到数据库表中
    public void addOrders(Orders orders, User user) {
        try {
            connection = DBUtil.getCon();
            connection.setAutoCommit(false);
            String sql = "insert into orders(id, total_price, num, time, user_id, state) values(?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, orders.getId());
            statement.setDouble(2, orders.getTotal_price());
            statement.setInt(3, orders.getNum());
            statement.setString(4, orders.getTime());
            statement.setInt(5, user.getId());
            statement.setInt(6, orders.getState());
            statement.executeUpdate();
            List<OrdersItem> items = orders.getItems();
            System.out.println("订单项为：" + items);
            if (items != null && items.size() > 0) {
                String sql1 = "insert into ordersitem(id,num,price,good_id,order_id) values(?, ?, ?, ?, ?)";
                statement = connection.prepareStatement(sql1);
                for (OrdersItem item : items) {
                    statement.setString(1, item.getId());
                    statement.setInt(2, item.getNum());
                    statement.setDouble(3, item.getPrice());
                    statement.setInt(4, item.getGood().getId());
                    statement.setString(5, orders.getId());
                    statement.executeUpdate();
                }
            }
            connection.commit();
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
    }

    // 根据用户id查询订单信息
    public List<Orders> findOrdersByUserId(int id) {
        try {
            connection = DBUtil.getCon();
            String sql = "select * from orders where user_id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            List<Orders> ordersList = new ArrayList<>();
            UserDao userDao = new UserDao();
            while (resultSet.next()) {
                Orders orders = new Orders();
                orders.setId(resultSet.getString("id"));
                orders.setUser(userDao.SelectUserById(resultSet.getInt("user_id")));
                orders.setNum(resultSet.getInt("num"));
                orders.setTotal_price(resultSet.getFloat("total_price"));
                orders.setState(resultSet.getInt("state"));
                orders.setTime(resultSet.getString("time"));
                ordersList.add(orders);
            }
            return ordersList;
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
}
