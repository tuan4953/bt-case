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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout-cart")
public class CheckoutCartServlet extends HttpServlet {
    private final CartDAO cartDAO = new CartDAO();
    private final UserDAO userDAO = new UserDAO();
    private final GameAccountDAO gameDAO = new GameAccountDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
                return;
            }

            String[] selectedIds = request.getParameterValues("selectedIds");

            if (selectedIds == null || selectedIds.length == 0) {
                session.setAttribute("message", "Vui lòng chọn ít nhất 1 acc để thanh toán!");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            List<GameAccount> selectedCart = new ArrayList<>();

            for (String idRaw : selectedIds) {
                int accountId = Integer.parseInt(idRaw);
                GameAccount game = gameDAO.getProductById(accountId);

                if (game != null && "AVAILABLE".equalsIgnoreCase(game.getStatus())) {
                    selectedCart.add(game);
                }
            }

            if (selectedCart.isEmpty()) {
                session.setAttribute("message", "Không có acc hợp lệ để thanh toán!");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            double total = 0;

            for (GameAccount g : selectedCart) {
                total += g.getPrice();
            }

            if (user.getBalance() < total) {
                session.setAttribute("message", "Không đủ tiền!");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            double newBalance = user.getBalance() - total;

            userDAO.updateBalance(user.getId(), newBalance);

            user.setBalance(newBalance);

            session.setAttribute("user", user);

            for (GameAccount g : selectedCart) {
                gameDAO.updateStatus(g.getId(), "SOLD");
                orderDAO.createOrder(user, g);
                cartDAO.removeCart(user.getId(), g.getId());
            }

            session.setAttribute("message", "Thanh toán các acc đã chọn thành công!");
            response.sendRedirect(request.getContextPath() + "/products");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Checkout thất bại!");
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}