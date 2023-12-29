package servlet;

import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "register", value = "/register")
public class register extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String Confirmedpassword = req.getParameter("Confirmedpassword");
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String sql = "select * from user where username = ?";

        if (username == null || username.equals("") || password == null || password.equals("") || Confirmedpassword == null || Confirmedpassword.equals("")) {
            req.setAttribute("errorMessage", "用户名或密码不能为空");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }

        String regex = "[a-zA-Z]{3,16}$"; // 用户名只包含字母
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(username);
        if (matcher.matches() == false) {
            req.setAttribute("errorMessage", "用户名格式错误");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }

        String regex2 = "[0-9]{3,16}$"; // 密码只包含字母和数字
        Pattern pattern1 = Pattern.compile(regex2);
        Matcher matcher1 = pattern1.matcher(password);
        if (matcher1.matches() == false) {
            req.setAttribute("errorMessage", "密码格式错误");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }

        // 判断用户名是否已经存在
        try {
            connection = DBUtil.getCon();
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                req.setAttribute("errorMessage", "用户名已存在");
                req.getRequestDispatcher("error.jsp").forward(req, resp);
            } else if (!password.equals(Confirmedpassword)) {
                req.setAttribute("errorMessage", "两次输入的密码不一致");
                req.getRequestDispatcher("/error.jsp").include(req, resp);
            } else { // 注册成功返回登录界面
                String sql1 = "insert into user(username,password) values(?,?)";
                statement = connection.prepareStatement(sql1);
                statement.setString(1, username);
                statement.setString(2, password);
                statement.executeUpdate();
                resp.sendRedirect("login.jsp");
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