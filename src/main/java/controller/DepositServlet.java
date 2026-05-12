package controller;

import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

import java.io.IOException;

@WebServlet("/deposit")
public class DepositServlet extends HttpServlet {

    UserDAO userDAO =
            new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request,
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

            double amount =
                    Double.parseDouble(
                            request.getParameter("amount")
                    );

            if(amount <= 0){

                session.setAttribute(
                        "message",
                        "Số tiền không hợp lệ!"
                );

                response.sendRedirect("products");
                return;
            }

            double newBalance =
                    user.getBalance() + amount;

            boolean check =
                    userDAO.updateBalance(
                            user.getId(),
                            newBalance
                    );

            if(check){

                user.setBalance(newBalance);

                session.setAttribute(
                        "user",
                        user
                );

                session.setAttribute(
                        "message",
                        "Nạp tiền thành công!"
                );

            } else {

                session.setAttribute(
                        "message",
                        "Nạp tiền thất bại!"
                );
            }
            response.sendRedirect("products");

        } catch (Exception e){

            e.printStackTrace();

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "message",
                    "Có lỗi xảy ra!"
            );

            response.sendRedirect("products");
        }
    }
}