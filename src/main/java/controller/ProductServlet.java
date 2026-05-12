package controller;

import dao.ChatDAO;
import dao.GameAccountDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.GameAccount;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private final GameAccountDAO dao =
            new GameAccountDAO();

    // =========================
    // THÊM CHAT DAO
    // =========================
    private final ChatDAO chatDAO =
            new ChatDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {

            // =========================
            // LẤY USER LOGIN
            // =========================
            HttpSession session =
                    request.getSession();

            User user =
                    (User) session.getAttribute("user");

            // =========================
            // GET PARAM SEARCH
            // =========================
            String keyword =
                    request.getParameter("keyword");

            String categoryId =
                    request.getParameter("categoryId");

            List<GameAccount> list;

            // =========================
            // SEARCH + FILTER
            // =========================
            if ((keyword != null &&
                    !keyword.trim().isEmpty())
                    || (categoryId != null &&
                    !categoryId.isEmpty())) {

                list =
                        dao.searchProducts(
                                keyword,
                                categoryId
                        );

            } else {

                list =
                        dao.getAllAccounts();
            }

            // =========================
            // DEBUG
            // =========================
            System.out.println(
                    "TOTAL PRODUCTS: "
                            + list.size()
            );

            // =========================
            // SET PRODUCT LIST
            // =========================
            request.setAttribute(
                    "list",
                    list
            );

            // =========================
            // THÊM CHAT LIST
            // =========================
            if(user != null){

                request.setAttribute(
                        "chatList",
                        chatDAO.getChatByUser(
                                user.getId()
                        )
                );
            }

            // =========================
            // FORWARD JSP
            // =========================
            request.getRequestDispatcher(
                    "products.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter()
                    .println("Load products failed");
        }
    }
}