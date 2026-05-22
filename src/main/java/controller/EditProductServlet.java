package controller;

import dao.GameAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.GameAccount;

import java.io.IOException;

@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {

    private final GameAccountDAO dao = new GameAccountDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)

            throws ServletException, IOException {

        try {

            // 1. Lấy id an toàn
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.isEmpty()) {
                response.getWriter().println("Missing product id");
                return;
            }

            int id = Integer.parseInt(idParam);

            // 2. Lấy product từ DB
            GameAccount game = dao.getProductById(id);

            // 3. Check null tránh JSP crash
            if (game == null) {
                response.getWriter().println("Product not found");
                return;
            }

            // 4. Gửi sang JSP
            request.setAttribute("game", game);

            request.getRequestDispatcher("edit-product.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid product id");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Edit product error");
        }
    }
}