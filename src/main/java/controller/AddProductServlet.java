package controller;

import dao.GameAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.GameAccount;

import java.io.File;
import java.io.IOException;

@WebServlet("/add-product")
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    private final GameAccountDAO dao = new GameAccountDAO();

    private static final String UPLOAD_DIR = "C:/game-shop/uploads";

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {

            String gameName = request.getParameter("gameName");
            String accountName = request.getParameter("accountName");
            String status = request.getParameter("status");
            double price = Double.parseDouble(request.getParameter("price"));

            Part filePart = request.getPart("image");

            if (filePart == null || filePart.getSize() == 0) {
                response.getWriter().println("No image selected");
                return;
            }

            String original = filePart.getSubmittedFileName();
            String fileName = System.currentTimeMillis() + "_" + original;

            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            filePart.write(UPLOAD_DIR + File.separator + fileName);

            GameAccount g = new GameAccount();
            g.setGameName(gameName);
            g.setAccountName(accountName);
            g.setPrice(price);
            g.setStatus(status);
            g.setImage(fileName);

            boolean check = dao.addProduct(g);

            if (check) {
                response.sendRedirect("products");
            } else {
                response.getWriter().println("Add product failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Server error");
        }
    }
}