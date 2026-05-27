package controller.cart;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet("/remove-cart")
public class RemoveCartServlet extends HttpServlet {

    CartDAO cartDAO =
            new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session =
                    request.getSession();

            User user =
                    (User) session.getAttribute("user");

            int accountId =
                    Integer.parseInt(
                            request.getParameter("id")
                    );

            cartDAO.removeCart(
                    user.getId(),
                    accountId
            );

            response.sendRedirect("cart");

        } catch (Exception e){

            e.printStackTrace();

            response.sendRedirect("cart");
        }
    }
}