package controller;

import dao.GameAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.GameAccount;
import model.User;
import java.io.File;
import java.io.IOException;

@WebServlet("/add-product")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    private final GameAccountDAO dao = new GameAccountDAO();
    private static final String UPLOAD_DIR = "C:/game-shop/uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("error", "⚠ Vui lòng đăng nhập!");
            response.sendRedirect("login.jsp");
            return;
        }

        if (user.getRole() == null || !user.getRole().equalsIgnoreCase("ADMIN")) {
            session.setAttribute("error", "❌ Bạn không có quyền truy cập!");
            response.sendRedirect("products");
            return;
        }

        try {
            String gameName = request.getParameter("gameName");
            String accountName = request.getParameter("accountName");
            String accountPass = request.getParameter("accountPass");
            String status = request.getParameter("status");
            String description = request.getParameter("description");
            String rankName = request.getParameter("rankName");
            String priceRaw = request.getParameter("price");

            if (gameName == null || gameName.trim().isEmpty()) {
                session.setAttribute("error", "⚠ Vui lòng nhập tên game!");
                response.sendRedirect("add-product.jsp");
                return;
            }

            if (accountName == null || accountName.trim().isEmpty()) {
                session.setAttribute("error", "⚠ Vui lòng nhập tên acc!");
                response.sendRedirect("add-product.jsp");
                return;
            }

            if (accountPass == null || accountPass.trim().isEmpty()) {
                session.setAttribute("error", "⚠ Vui lòng nhập mật khẩu acc game!");
                response.sendRedirect("add-product.jsp");
                return;
            }

            if (priceRaw == null || priceRaw.trim().isEmpty()) {
                session.setAttribute("error", "⚠ Vui lòng nhập giá!");
                response.sendRedirect("add-product.jsp");
                return;
            }

            double price = Double.parseDouble(priceRaw);
            Part filePart = request.getPart("image");

            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("error", "⚠ Vui lòng chọn ảnh!");
                response.sendRedirect("add-product.jsp");
                return;
            }

            String original = filePart.getSubmittedFileName();
            String fileName = System.currentTimeMillis() + "_" + original;
            File uploadDir = new File(UPLOAD_DIR);

            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(UPLOAD_DIR + File.separator + fileName);

            int gameId = dao.getOrCreateGame(gameName);

            GameAccount g = new GameAccount();
            g.setGameId(gameId);
            g.setAccountName(accountName.trim());
            g.setAccountUser(accountName.trim());
            g.setAccountPass(accountPass.trim());
            g.setDescription(description == null || description.trim().isEmpty() ? "No description" : description.trim());
            g.setRankName(rankName == null || rankName.trim().isEmpty() ? "Normal" : rankName.trim());
            g.setPrice(price);
            g.setStatus(status == null || status.trim().isEmpty() ? "AVAILABLE" : status.trim());
            g.setImage(fileName);

            boolean check = dao.addProduct(g);

            if (check) {
                session.setAttribute("message", "🎉 Thêm acc thành công!");
                response.sendRedirect("products");
            } else {
                session.setAttribute("error", "❌ Thêm acc thất bại!");
                response.sendRedirect("add-product.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "❌ Lỗi hệ thống khi thêm acc!");
            response.sendRedirect("add-product.jsp");
        }
    }
}