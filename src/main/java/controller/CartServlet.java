package controller;

import dao.CartDAO;
import dao.ChatDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.GameAccount;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet
        extends HttpServlet {

    CartDAO cartDAO =
            new CartDAO();

    // =========================
    // THÊM CHAT DAO
    // =========================
    ChatDAO chatDAO =
            new ChatDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute("user");

        // =========================
        // CHECK LOGIN
        // =========================
        if(user == null){

            response.sendRedirect("login.jsp");
            return;
        }

        // =========================
        // LOAD CART
        // =========================
        List<GameAccount> cart =
                cartDAO.getCartByUser(
                        user.getId()
                );

        request.setAttribute(
                "cart",
                cart
        );

        // =========================
        // LOAD CHAT
        // =========================
        request.setAttribute(
                "chatList",
                chatDAO.getChatByUser(
                        user.getId()
                )
        );

        // =========================
        // FORWARD JSP
        // =========================
        request.getRequestDispatcher(
                "cart.jsp"
        ).forward(request,response);
    }
}