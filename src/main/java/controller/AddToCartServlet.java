package controller;

import dao.CartDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

import java.io.IOException;

@WebServlet("/add-to-cart")
public class AddToCartServlet
        extends HttpServlet {

    CartDAO cartDAO =
            new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session =
                    request.getSession();

            User user =
                    (User) session.getAttribute("user");

            if(user == null){

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
                        "Đã thêm vào giỏ hàng!"
                );

            } else {

                session.setAttribute(
                        "message",
                        "Acc đã có trong giỏ!"
                );
            }

            response.sendRedirect("products");

        } catch (Exception e){

            e.printStackTrace();

            response.sendRedirect("products");
        }
    }
}