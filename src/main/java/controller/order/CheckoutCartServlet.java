package controller.order;

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
import java.util.List;

@WebServlet("/checkout-cart")
public class CheckoutCartServlet
        extends HttpServlet {

    CartDAO cartDAO =
            new CartDAO();

    UserDAO userDAO =
            new UserDAO();

    GameAccountDAO gameDAO =
            new GameAccountDAO();

    OrderDAO orderDAO =
            new OrderDAO();

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

                response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
                return;
            }

            List<GameAccount> cart =
                    cartDAO.getCartByUser(
                            user.getId()
                    );

            if(cart == null || cart.isEmpty()){

                session.setAttribute(
                        "message",
                        "Giỏ hàng trống!"
                );

                response.sendRedirect("cart");
                return;
            }

            double total = 0;

            // tính tổng
            for(GameAccount g : cart){

                total += g.getPrice();
            }

            // check tiền
            if(user.getBalance() < total){

                session.setAttribute(
                        "message",
                        "Không đủ tiền!"
                );

                response.sendRedirect("cart");
                return;
            }

            // trừ tiền
            double newBalance =
                    user.getBalance() - total;

            userDAO.updateBalance(
                    user.getId(),
                    newBalance
            );

            user.setBalance(newBalance);

            session.setAttribute(
                    "user",
                    user
            );

            // mua từng acc
            for(GameAccount g : cart){

                // bỏ qua acc sold
                if("SOLD".equals(g.getStatus())){
                    continue;
                }

                // update sold
                gameDAO.updateStatus(
                        g.getId(),
                        "SOLD"
                );

                // tạo order
                orderDAO.createOrder(
                        user,
                        g
                );

                // xoá khỏi cart
                cartDAO.removeCart(
                        user.getId(),
                        g.getId()
                );
            }

            session.setAttribute(
                    "message",
                    "Thanh toán giỏ hàng thành công!"
            );

            response.sendRedirect(
                    "products"
            );

        } catch (Exception e){

            e.printStackTrace();

            request.getSession()
                    .setAttribute(
                            "message",
                            "Checkout thất bại!"
                    );

            response.sendRedirect("cart");
        }
    }
}