package controller;

import dao.CartDAO;
import dao.GameAccountDAO;
import dao.OrderDAO;
import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.GameAccount;
import model.User;

import java.io.IOException;

@WebServlet("/buy-now")
public class BuyNowServlet extends HttpServlet {

    private final GameAccountDAO gameDAO =
            new GameAccountDAO();

    private final UserDAO userDAO =
            new UserDAO();

    private final OrderDAO orderDAO =
            new OrderDAO();

    private final CartDAO cartDAO =
            new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setContentType(
                "text/html;charset=UTF-8"
        );

        HttpSession session =
                request.getSession();

        try {

            User user =
                    (User) session.getAttribute("user");

            // =========================
            // CHECK LOGIN
            // =========================

            if(user == null){

                session.setAttribute(
                        "error",
                        "⚠ Vui lòng đăng nhập!"
                );

                response.sendRedirect("login.jsp");
                return;
            }

            int id =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            GameAccount game =
                    gameDAO.getProductById(id);

            // =========================
            // PRODUCT NOT FOUND
            // =========================

            if(game == null){

                session.setAttribute(
                        "error",
                        "❌ Sản phẩm không tồn tại!"
                );

                response.sendRedirect("products");
                return;
            }

            // =========================
            // SOLD
            // =========================

            if("SOLD".equalsIgnoreCase(
                    game.getStatus()
            )){

                session.setAttribute(
                        "error",
                        "⚠ Acc đã được bán!"
                );

                response.sendRedirect("products");
                return;
            }

            // =========================
            // NOT ENOUGH MONEY
            // =========================

            if(user.getBalance()
                    < game.getPrice()){

                session.setAttribute(
                        "error",
                        "💸 Không đủ số dư!"
                );

                response.sendRedirect("products");
                return;
            }

            // =========================
            // UPDATE BALANCE
            // =========================

            double newBalance =
                    user.getBalance()
                            - game.getPrice();

            userDAO.updateBalance(
                    user.getId(),
                    newBalance
            );

            user.setBalance(newBalance);

            session.setAttribute(
                    "user",
                    user
            );

            // =========================
            // UPDATE SOLD
            // =========================

            gameDAO.updateStatus(
                    game.getId(),
                    "SOLD"
            );

            // =========================
            // CREATE ORDER
            // =========================

            orderDAO.createOrder(
                    user,
                    game
            );

            // =========================
            // REMOVE CART
            // =========================

            cartDAO.removeCart(
                    user.getId(),
                    game.getId()
            );

            // =========================
            // SUCCESS
            // =========================

            session.setAttribute(
                    "message",
                    "🎉 Mua acc thành công!"
            );

        } catch (Exception e){

            e.printStackTrace();

            session.setAttribute(
                    "error",
                    "❌ Mua acc thất bại!"
            );
        }

        response.sendRedirect("products");
    }
}

