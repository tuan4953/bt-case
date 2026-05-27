package controller.product;

import dao.AccountImageDAO;
import dao.GameAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.GameAccount;
import java.io.File;
import java.io.IOException;
import java.util.Collection;

@WebServlet("/update-product")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class UpdateProductServlet extends HttpServlet {
    private final GameAccountDAO dao = new GameAccountDAO();
    private final AccountImageDAO imageDAO = new AccountImageDAO();
    private static final String UPLOAD_DIR = "C:/game-shop/uploads";
    private static final String SUB_UPLOAD_DIR = "C:/game-shop/uploads/accounts";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            int id = Integer.parseInt(idParam);
            GameAccount old = dao.getProductById(id);

            if (old == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            String gameName = request.getParameter("gameName");
            String accountName = request.getParameter("accountName");
            String accountUser = request.getParameter("accountUser");
            String accountPass = request.getParameter("accountPass");
            String description = request.getParameter("description");
            String rankName = request.getParameter("rankName");
            String priceRaw = request.getParameter("price");
            String status = request.getParameter("status");

            if (gameName == null || gameName.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Vui lòng nhập tên game!");
                response.sendRedirect(request.getContextPath() + "/edit-product?id=" + id);
                return;
            }

            if (accountName == null || accountName.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Vui lòng nhập tên acc!");
                response.sendRedirect(request.getContextPath() + "/edit-product?id=" + id);
                return;
            }

            if (priceRaw == null || priceRaw.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Vui lòng nhập giá!");
                response.sendRedirect(request.getContextPath() + "/edit-product?id=" + id);
                return;
            }

            String imageName = old.getImage();
            Part filePart = request.getPart("image");

            if (filePart != null && filePart.getSize() > 0) {
                String original = filePart.getSubmittedFileName();

                if (original != null && !original.trim().isEmpty()) {
                    original = original.replaceAll("\\s+", "_");
                    String fileName = System.currentTimeMillis() + "_" + original;
                    File dir = new File(UPLOAD_DIR);

                    if (!dir.exists()) {
                        dir.mkdirs();
                    }

                    filePart.write(UPLOAD_DIR + File.separator + fileName);
                    imageName = fileName;
                }
            }

            int gameId = dao.getOrCreateGame(gameName);

            GameAccount g = new GameAccount();
            g.setId(id);
            g.setGameId(gameId);
            g.setAccountName(accountName.trim());
            g.setAccountUser(accountUser == null || accountUser.trim().isEmpty() ? old.getAccountUser() : accountUser.trim());
            g.setAccountPass(accountPass == null || accountPass.trim().isEmpty() ? old.getAccountPass() : accountPass.trim());
            g.setDescription(description == null || description.trim().isEmpty() ? old.getDescription() : description.trim());
            g.setRankName(rankName == null || rankName.trim().isEmpty() ? old.getRankName() : rankName.trim());
            g.setPrice(Double.parseDouble(priceRaw));
            g.setStatus(status == null || status.trim().isEmpty() ? old.getStatus() : status.trim());
            g.setImage(imageName);

            boolean ok = dao.updateProduct(g);

            if (ok) {
                File subDir = new File(SUB_UPLOAD_DIR);

                if (!subDir.exists()) {
                    subDir.mkdirs();
                }

                Collection<Part> parts = request.getParts();

                for (Part part : parts) {
                    if (part.getName().equals("subImages") && part.getSize() > 0) {
                        String original = part.getSubmittedFileName();

                        if (original != null && !original.trim().isEmpty()) {
                            original = original.replaceAll("\\s+", "_");
                            String fileName = System.currentTimeMillis() + "_" + original;
                            part.write(SUB_UPLOAD_DIR + File.separator + fileName);
                            imageDAO.addImage(id, fileName);
                        }
                    }
                }

                request.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
                response.sendRedirect(request.getContextPath() + "/account-detail?id=" + id);
            } else {
                request.getSession().setAttribute("error", "Update thất bại!");
                response.sendRedirect(request.getContextPath() + "/edit-product?id=" + id);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Server error!");
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}