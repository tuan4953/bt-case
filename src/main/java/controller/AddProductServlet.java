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

    private final GameAccountDAO dao =
            new GameAccountDAO();

    private static final String UPLOAD_DIR =
            "C:/game-shop/uploads";

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession();

// =========================
// CHECK LOGIN
// =========================

        User user =
                (User) session.getAttribute("user");

        if(user == null){

            session.setAttribute(
                    "error",
                    "⚠ Vui lòng đăng nhập!"
            );

            response.sendRedirect("login.jsp");

            return;
        }

// =========================
// CHECK ADMIN
// =========================

        if(user.getRole() == null
                ||
                !user.getRole()
                        .equalsIgnoreCase("ADMIN")){

            session.setAttribute(
                    "error",
                    "❌ Bạn không có quyền truy cập!"
            );

            response.sendRedirect("products");

            return;
        }



        try {

            String gameName =
                    request.getParameter("gameName");

            String accountName =
                    request.getParameter("accountName");

            String status =
                    request.getParameter("status");

            double price =
                    Double.parseDouble(
                            request.getParameter("price")
                    );

            // =========================
            // IMAGE
            // =========================

            Part filePart =
                    request.getPart("image");

            if(filePart == null
                    ||
                    filePart.getSize() == 0){

                session.setAttribute(
                        "error",
                        "⚠ Vui lòng chọn ảnh!"
                );

                response.sendRedirect(
                        "add-product.jsp"
                );

                return;
            }

            String original =
                    filePart.getSubmittedFileName();

            String fileName =
                    System.currentTimeMillis()
                            + "_"
                            + original;

            File uploadDir =
                    new File(UPLOAD_DIR);

            if(!uploadDir.exists()){

                uploadDir.mkdirs();
            }

            filePart.write(
                    UPLOAD_DIR
                            + File.separator
                            + fileName
            );

            // =========================
            // CREATE PRODUCT
            // =========================

            GameAccount g =
                    new GameAccount();

            g.setGameName(gameName);

            g.setAccountName(accountName);

            g.setPrice(price);

            g.setStatus(status);

            g.setImage(fileName);

            boolean check =
                    dao.addProduct(g);

            // =========================
            // RESULT
            // =========================

            if(check){

                session.setAttribute(
                        "message",
                        "🎉 Thêm acc thành công!"
                );

                response.sendRedirect(
                        "products"
                );

            } else {

                session.setAttribute(
                        "error",
                        "❌ Thêm acc thất bại!"
                );

                response.sendRedirect(
                        "add-product.jsp"
                );
            }

        } catch (Exception e){

            e.printStackTrace();

            session.setAttribute(
                    "error",
                    "❌ Lỗi hệ thống khi thêm acc!"
            );

            response.sendRedirect(
                    "add-product.jsp"
            );
        }
    }
}
