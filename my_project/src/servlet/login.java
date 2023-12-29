package servlet;

import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "login", value = "/login")
public class login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String checkcode = req.getParameter("checkcode"); // 验证码
        String check = req.getParameter("check"); // 确认操作

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        // 进行验证逻辑-首先判断用户的输入是否为空,然后再判断是否正确
        if  (username == null || username.trim().length() == 0 || password == null || password.trim().length() == 0) {
            req.setAttribute("errorMessage", "用户名或密码不能为空");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        String code = (String) session.getAttribute("checkcode");
        if (!code.equals(checkcode)) {
            req.setAttribute("errorMessage", "验证码为空或错误");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }
        // 在数据库中进行查询
        try {
            connection = DBUtil.getCon();
            String sql = "select * from user where username=? and password=?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                // 设置当前的登录用户id
                String sql2 = "select user_id from user where username=?";
                statement = connection.prepareStatement(sql2);
                statement.setString(1, username);
                resultSet = statement.executeQuery();
                int user_id = 0;
                if (resultSet.next()) {
                    user_id = resultSet.getInt("user_id");
                }
                session.setAttribute("currentUser", user_id);
                // 设置登录状态为1
                String sql1 = "update user set islogin=1 where username=?";
                statement = connection.prepareStatement(sql1);
                statement.setString(1, username);
                statement.executeUpdate();
                if ("on".equals(check)) {
                    // 设置新的用户名
                    // 如果在cookie中存在一个用户名而且在数据库中也存在，自动进行登录
                    Cookie[] cookies = req.getCookies();
                    boolean flag = false;
                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            if (cookie.getName().equals("username")) {
                                cookie.setValue(username);
                                cookie.setMaxAge(60 * 60 * 24 * 10);
                                flag = true;
                            }
                        }
                    }
                    if (!flag) { // 说明没有创建过cookie
                        Cookie cookie = new Cookie("username", username);
                        cookie.setMaxAge(60 * 60 * 24 * 10);
                        resp.addCookie(cookie);
                    }
                }
                System.out.println("登录成功");
                // 跳转到商城界面
                resp.addHeader("refresh", "0;URL=http://localhost:8080/my_project_war_exploded/lyb/index.jsp");
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
    }
}