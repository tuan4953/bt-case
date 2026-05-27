package controller.product;

import dao.GameAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.GameAccount;

import java.io.IOException;

@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {
    private final GameAccountDAO dao = new GameAccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            int id = Integer.parseInt(idParam);
            GameAccount game = dao.getProductById(id);

            if (game == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            request.setAttribute("game", game);
            request.getRequestDispatcher("/product/edit-product.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}