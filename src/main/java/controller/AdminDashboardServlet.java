package controller;

import dao.OrderDAO;
import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

import java.io.IOException;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet
        extends HttpServlet {

    private final UserDAO userDAO =
            new UserDAO();

    private final OrderDAO orderDAO =
            new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // =========================
        // CHECK SESSION
        // =========================

        if(session == null){

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        // =========================
        // CHECK ADMIN
        // =========================

        if(user == null
                ||
                user.getRole() == null
                ||
                !user.getRole()
                        .equalsIgnoreCase("ADMIN")){

            response.sendRedirect("products");
            return;
        }

        // =========================
        // LOAD DATA
        // =========================

        request.setAttribute(
                "totalUsers",
                userDAO.getTotalUsers()
        );

        request.setAttribute(
                "totalRevenue",
                orderDAO.getTotalRevenue()
        );

        request.setAttribute(
                "totalSold",
                orderDAO.getTotalSold()
        );

        // =========================
        // FORWARD
        // =========================

        request.getRequestDispatcher(
                "admin-dashboard.jsp"
        ).forward(request,response);
    }
}

