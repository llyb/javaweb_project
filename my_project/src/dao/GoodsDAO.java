package dao;

import pojo.Good;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GoodsDAO {
    // 获得所有商品
    public ArrayList<Good> getAllGoods() {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        ArrayList<Good> list = new ArrayList<Good>();
        try {
            connection = DBUtil.getCon();
            String sql = "select * from goods";
            statement = connection.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                Good good = new Good();
                good.setId(rs.getInt("id"));
                good.setName(rs.getString("name"));
                good.setCity(rs.getString("city"));
                good.setNumber(rs.getInt("number"));
                good.setPrice(rs.getInt("price"));
                good.setPicture(rs.getString("picture"));
                list.add(good);
            }
            System.out.println(list);
            return list;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                DBUtil.closeAll(connection, statement, rs);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public Good getGoodById(int id) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        ArrayList<Good> list = new ArrayList<Good>();
        try {
            connection = DBUtil.getCon();
            String sql = "select * from goods where id = ?;";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            rs = statement.executeQuery();
            if (rs.next()) {
                Good good = new Good();
                good.setId(rs.getInt("id"));
                good.setName(rs.getString("name"));
                good.setCity(rs.getString("city"));
                good.setNumber(rs.getInt("number"));
                good.setPrice(rs.getInt("price"));
                good.setPicture(rs.getString("picture"));
                return good;
            } else {
                return null;
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                DBUtil.closeAll(connection, statement, rs);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    // 得到最近浏览的5条记录的信息
    public ArrayList<Good> getViewList(String list) {
        ArrayList<Good> list1 = new ArrayList<Good>();
        int count = 5;
        if (list != null && list.length() > 0) {
            String[] arr = list.split(",");
            for (int i = arr.length - 1; i >= Math.max(0, arr.length - count); i --) {
                list1.add(getGoodById(Integer.parseInt(arr[i])));
            }
            return list1;
        }
        else {
            return null;
        }
    }
}
