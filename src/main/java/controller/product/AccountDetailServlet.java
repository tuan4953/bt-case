package controller.product;

import dao.AccountImageDAO;
import dao.GameAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.AccountImage;
import model.GameAccount;

import java.io.IOException;
import java.util.List;

@WebServlet("/account-detail")
public class AccountDetailServlet extends HttpServlet {
    private final GameAccountDAO dao = new GameAccountDAO();
    private final AccountImageDAO imageDAO = new AccountImageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idRaw = request.getParameter("id");

            if (idRaw == null || idRaw.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            int id = Integer.parseInt(idRaw);
            GameAccount acc = dao.getProductById(id);

            if (acc == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            List<AccountImage> images = imageDAO.getImagesByAccountId(id);

            request.setAttribute("account", acc);
            request.setAttribute("images", images);

            request.getRequestDispatcher("/product/account-detail.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}