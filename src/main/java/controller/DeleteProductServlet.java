package controller;

import dao.GameAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {

    private final GameAccountDAO dao = new GameAccountDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        try {

            HttpSession session = request.getSession(false);

            // 1. Check login an toàn hơn
            if (session == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            User user = (User) session.getAttribute("user");

            // 2. Check role admin
            if (user == null || user.getRole() == null
                    || !user.getRole().equalsIgnoreCase("ADMIN")) {

                response.sendRedirect("login.jsp");
                return;
            }

            // 3. Validate id tránh lỗi parse
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.isEmpty()) {
                response.getWriter().println("Missing product id");
                return;
            }

            int id = Integer.parseInt(idParam);

            // 4. Delete
            boolean result = dao.deleteProduct(id);

            if (!result) {
                System.out.println("Delete failed for id: " + id);
            } else {
                System.out.println("Delete success id: " + id);
            }

            // 5. Redirect lại danh sách
            response.sendRedirect("products");

        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid product id");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Delete product error");
        }
    }
}