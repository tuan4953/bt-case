package controller.product;

import dao.CartDAO;
import dao.ChatDAO;
import dao.GameAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.GameAccount;
import model.User;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private final GameAccountDAO dao = new GameAccountDAO();
    private final CartDAO cartDAO = new CartDAO();
    private final ChatDAO chatDAO = new ChatDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            String keyword = request.getParameter("keyword");
            String categoryId = request.getParameter("categoryId");
            List<GameAccount> list;

            if ((keyword != null && !keyword.trim().isEmpty()) || (categoryId != null && !categoryId.isEmpty())) {
                list = dao.searchProducts(keyword, categoryId);
            } else {
                list = dao.getAllAccounts();
            }

            request.setAttribute("list", list);

            if (user != null) {
                request.setAttribute("cartCount", cartDAO.getCartCount(user.getId()));
                request.setAttribute("chatList", chatDAO.getChatByUser(user.getId()));
            }

            request.getRequestDispatcher("/product/products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Load products failed");
        }
    }
}