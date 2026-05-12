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

    GameAccountDAO gameDAO =
            new GameAccountDAO();

    UserDAO userDAO =
            new UserDAO();

    OrderDAO orderDAO =
            new OrderDAO();

    CartDAO cartDAO =
            new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setContentType(
                "text/html;charset=UTF-8"
        );

        response.setCharacterEncoding("UTF-8");

        try {

            HttpSession session =
                    request.getSession();

            User user =
                    (User) session.getAttribute("user");

            // chưa login
            if(user == null){

                response.sendRedirect("login.jsp");
                return;
            }

            int id =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            GameAccount game =
                    gameDAO.getProductById(id);

            // không tồn tại
            if(game == null){

                session.setAttribute(
                        "message",
                        "Sản phẩm không tồn tại!"
                );

                response.sendRedirect("products");
                return;
            }

            // đã bán
            if("SOLD".equals(game.getStatus())){

                session.setAttribute(
                        "message",
                        "Acc đã được bán!"
                );

                response.sendRedirect("products");
                return;
            }

            // không đủ tiền
            if(user.getBalance() < game.getPrice()){

                session.setAttribute(
                        "message",
                        "Không đủ tiền!"
                );

                response.sendRedirect("products");
                return;
            }

            // trừ tiền
            double newBalance =
                    user.getBalance()
                            - game.getPrice();

            // update DB users
            userDAO.updateBalance(
                    user.getId(),
                    newBalance
            );

            // update session
            user.setBalance(newBalance);

            session.setAttribute(
                    "user",
                    user
            );

            // update SOLD
            gameDAO.updateStatus(
                    game.getId(),
                    "SOLD"
            );

            // tạo order
            orderDAO.createOrder(
                    user,
                    game
            );

            // xoá khỏi cart
            cartDAO.removeCart(
                    user.getId(),
                    game.getId()
            );

            // thông báo
            session.setAttribute(
                    "message",
                    "Mua acc thành công!"
            );

            response.sendRedirect(
                    "products"
            );

        } catch (Exception e){

            e.printStackTrace();

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "message",
                    "Mua acc thất bại!"
            );

            response.sendRedirect(
                    "products"
            );
        }
    }
}