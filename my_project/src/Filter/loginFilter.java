package Filter;

import dao.UserDao;
import util.DBUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebFilter(filterName = "LoginFilter",
        value = "/lyb/*"
)

public class loginFilter implements javax.servlet.Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
        httpServletRequest.setCharacterEncoding("utf-8");
        Cookie[] cookies = httpServletRequest.getCookies();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        // 能访问当前页面的方式有两种：
        // 1. 在cookie中设置了免密登录
        // 2. 当前用户已经登录
        // 每次要进行注销才行，否则下次还是能直接进入，这个可以添加一个注销按钮，每次将数据库中用户的状态全部设置为0
        boolean flag = false;
        for (Cookie cookie : cookies) {
            if ("username".equals(cookie.getName())) {
                try {
                    connection = DBUtil.getCon();
                    String sql = "select * from user where username=?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, cookie.getValue());
                    resultSet = statement.executeQuery();
                    if (resultSet.next()) { // 如果存在当前用户就能访问当前界面即免密登录
                        String sql1 = "update user set islogin=1 where username=?";
                        // 同时修改用户的登录状态
                        statement = connection.prepareStatement(sql1);
                        statement.setString(1, cookie.getValue());
                        statement.executeUpdate();
                        flag = true;
                        System.out.println("cookie中的值为：" + cookie.getValue());
                        System.out.println("过滤器：username");
                        // 同时设置session中的用户id
                        UserDao userDao = new UserDao();
                        httpServletRequest.getSession().setAttribute("currentUser", userDao.selectIdByName(cookie.getValue()));
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
        // 当前用户已经登录，直接放行
        if (httpServletRequest.getSession().getAttribute("currentUser") != null) {
            flag = true;
    }

        System.out.println("当前过滤器中的值为：" + flag);
        // 否则重定向到登录界面进行登录
        // 这里的重定向有点笨
        if (!flag) {
            httpServletResponse.sendRedirect("http://localhost:8080/my_project_war_exploded/login.jsp");
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {
    }
}
