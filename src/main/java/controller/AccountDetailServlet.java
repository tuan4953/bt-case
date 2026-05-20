package controller;

import dao.AccountImageDAO;
import dao.GameAccountDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.AccountImage;
import model.GameAccount;

import java.io.IOException;
import java.util.List;

@WebServlet("/account-detail")
public class AccountDetailServlet
        extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        try {

            // =========================
            // GET ID
            // =========================

            int id = Integer.parseInt(
                    request.getParameter("id")
            );

            // =========================
            // GET ACCOUNT
            // =========================

            GameAccountDAO dao =
                    new GameAccountDAO();

            GameAccount acc =
                    dao.getProductById(id);

            // KHÔNG TÌM THẤY
            if(acc == null){

                response.sendRedirect("products");

                return;
            }

            // =========================
            // GET MULTIPLE IMAGES
            // =========================

            AccountImageDAO imageDAO =
                    new AccountImageDAO();

            List<AccountImage> images =
                    imageDAO.getImagesByAccountId(id);

            // =========================
            // SEND DATA TO JSP
            // =========================

            request.setAttribute(
                    "account",
                    acc
            );

            request.setAttribute(
                    "images",
                    images
            );

            // =========================
            // FORWARD
            // =========================

            request.getRequestDispatcher(
                    "account-detail.jsp"
            ).forward(request,response);

        } catch (Exception e){

            e.printStackTrace();

            response.sendRedirect("products");
        }
    }
}