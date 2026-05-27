package controller.cart;

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
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final ChatDAO chatDAO = new ChatDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // =========================
        // CHECK LOGIN
        // =========================
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        // =========================
        // LOAD CART
        // =========================
        List<GameAccount> cart = cartDAO.getCartByUser(user.getId());

        request.setAttribute("cart", cart);

        // =========================
        // LOAD CHAT
        // =========================
        request.setAttribute(
                "chatList",
                chatDAO.getChatByUser(user.getId())
        );

        // =========================
        // FORWARD JSP
        // =========================
        request.getRequestDispatcher("/cart/cart.jsp")
                .forward(request, response);
    }
}