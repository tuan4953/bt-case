
        package controller;

import dao.CartDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

import java.io.IOException;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    private final CartDAO cartDAO =
            new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        try {

            User user =
                    (User) session.getAttribute("user");

            if(user == null){

                session.setAttribute(
                        "error",
                        "⚠ Vui lòng đăng nhập!"
                );

                response.sendRedirect("login.jsp");
                return;
            }

            int accountId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            boolean success =
                    cartDAO.addToCart(
                            user.getId(),
                            accountId
                    );

            if(success){

                session.setAttribute(
                        "message",
                        "🛒 Đã thêm vào giỏ hàng!"
                );

            } else {

                session.setAttribute(
                        "error",
                        "⚠ Acc đã tồn tại trong giỏ!"
                );
            }

        } catch (Exception e){

            e.printStackTrace();

            session.setAttribute(
                    "error",
                    "❌ Thêm giỏ hàng thất bại!"
            );
        }

        response.sendRedirect("products");
    }
}

