package servlet;

import dao.GoodsDAO;
import pojo.Cart;
import pojo.Good;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CartServlet", value = "/CartServlet")
public class CartServlet extends HttpServlet {
    private String action; // 表示当前的动作是什么，add | sub | show
    private GoodsDAO goodsDAO = new GoodsDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        PrintWriter out = resp.getWriter();
        if (req.getParameter("action") != null) {
            this.action = req.getParameter("action");
            if (action.equals("add")) { // 添加商品到购物车
                System.out.println("将商品添加到购物车！！！");
                if (addToCart(req, resp)) {
                    req.getRequestDispatcher("success.jsp").forward(req, resp);
                } else {
                    req.setAttribute("errorMessage", "添加商品失败！！！");
                    req.getRequestDispatcher("error.jsp").forward(req, resp);
                }
            }
            else if (action.equals("show")) { // 显示购物车
                resp.sendRedirect("http://localhost:8080/my_project_war_exploded/lyb/cart.jsp");
            }
            else if (action.equals("delete")) { // 删除购物车中的商品
                if (deleteFromCart(req, resp)) { // 如果删除成功
                    resp.sendRedirect("http://localhost:8080/my_project_war_exploded/lyb/cart.jsp");
                } else {
                    req.setAttribute("errorMessage", "删除失败！！！");
                    req.getRequestDispatcher("error.jsp").forward(req, resp);
                }
            }
        }
    }

    private boolean addToCart(HttpServletRequest req, HttpServletResponse resp) {
        String id = req.getParameter("id");
        String number = req.getParameter("num");
        Good good = goodsDAO.getGoodById(Integer.parseInt(id));
        Cart cart = null;
        // 判断是否是第一次添加到购物车中，如果是的话先进行创建购物车
        if (req.getSession().getAttribute("cart") == null) {
            cart = new Cart();
            req.getSession().setAttribute("cart", cart);
        } else {
            cart = (Cart) req.getSession().getAttribute("cart");
        }
        if (cart.addGoodsInCart(good, Integer.parseInt(number))) {
            return true;
        } else {
            return false;
        }
    }

    private boolean deleteFromCart(HttpServletRequest req, HttpServletResponse resp) {
        String id = req.getParameter("id");
        Cart cart = (Cart)req.getSession().getAttribute("cart");
        Good good = goodsDAO.getGoodById(Integer.parseInt(id));
        if (cart.removeGoodsFromCart(good)) {
            return true;
        } else {
            return false;
        }
    }
}
