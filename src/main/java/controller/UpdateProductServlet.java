package controller;

import dao.GameAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.GameAccount;

import java.io.File;
import java.io.IOException;

@WebServlet("/update-product")
@MultipartConfig
public class UpdateProductServlet extends HttpServlet {

    private final GameAccountDAO dao = new GameAccountDAO();

    private static final String UPLOAD_DIR = "C:/game-shop/uploads";

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));

            GameAccount old = dao.getProductById(id);

            String imageName = old.getImage(); // giữ ảnh cũ

            Part filePart = request.getPart("image");

            // 🔥 CHỈ XỬ LÝ KHI CÓ FILE MỚI
            if (filePart != null &&
                    filePart.getSize() > 0 &&
                    filePart.getSubmittedFileName() != null &&
                    !filePart.getSubmittedFileName().isEmpty()) {

                String original = filePart.getSubmittedFileName();
                String fileName = System.currentTimeMillis() + "_" + original;

                File dir = new File(UPLOAD_DIR);
                if (!dir.exists()) dir.mkdirs();

                filePart.write(UPLOAD_DIR + File.separator + fileName);

                imageName = fileName; // update ảnh mới
            }

            GameAccount g = new GameAccount();
            g.setId(id);
            g.setGameName(request.getParameter("gameName"));
            g.setAccountName(request.getParameter("accountName"));
            g.setPrice(Double.parseDouble(request.getParameter("price")));
            g.setStatus(request.getParameter("status"));
            g.setImage(imageName);

            boolean ok = dao.updateProduct(g);

            if (ok) {
                response.sendRedirect("products");
            } else {
                response.getWriter().println("Update failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Server error");
        }
    }
}