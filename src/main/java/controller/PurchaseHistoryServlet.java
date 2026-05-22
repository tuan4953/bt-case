package controller;

import dao.ChatDAO;
import dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.GameAccount;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/purchase-history")
public class PurchaseHistoryServlet
        extends HttpServlet {

    private final OrderDAO orderDAO =
            new OrderDAO();

    private final ChatDAO chatDAO =
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
        // LOAD HISTORY
        // =========================

        List<GameAccount> history =
                orderDAO.getHistory(
                        user.getId()
                );

        request.setAttribute(
                "history",
                history
        );

        // =========================
        // TOTAL PURCHASED
        // =========================

        request.setAttribute(
                "totalPurchased",
                orderDAO.getTotalPurchased(
                        user.getId()
                )
        );

        // =========================
        // TOTAL SPENT
        // =========================

        request.setAttribute(
                "totalSpent",
                orderDAO.getTotalSpent(
                        user.getId()
                )
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
                "purchase-history.jsp"
        ).forward(request,response);
    }
}

