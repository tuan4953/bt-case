package controller;

import dao.GameAccountDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

import java.io.IOException;

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {

    private final GameAccountDAO dao =
            new GameAccountDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);
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

            // =========================
            // CHECK SESSION
            // =========================

            if(session == null){

                response.sendRedirect("login.jsp");
                return;
            }



            // =========================
            // CHECK ADMIN
            // =========================

            if(user == null
                    ||
                    user.getRole() == null
                    ||
                    !user.getRole()
                            .equalsIgnoreCase("ADMIN")){

                session.setAttribute(
                        "error",
                        "⚠ Bạn không có quyền!"
                );

                response.sendRedirect("products");
                return;
            }

            // =========================
            // VALIDATE ID
            // =========================

            String idParam =
                    request.getParameter("id");

            if(idParam == null
                    ||
                    idParam.isEmpty()){

                session.setAttribute(
                        "error",
                        "❌ Thiếu ID sản phẩm!"
                );

                response.sendRedirect("products");
                return;
            }

            int id =
                    Integer.parseInt(idParam);

            // =========================
            // DELETE PRODUCT
            // =========================

            boolean result =
                    dao.deleteProduct(id);

            // =========================
            // RESULT
            // =========================

            if(result){

                session.setAttribute(
                        "message",
                        "🗑 Đã xoá acc thành công!"
                );

            } else {

                session.setAttribute(
                        "error",
                        "❌ Xoá acc thất bại!"
                );
            }

        } catch (NumberFormatException e){

            session.setAttribute(
                    "error",
                    "❌ ID sản phẩm không hợp lệ!"
            );

        } catch (Exception e){

            e.printStackTrace();

            session.setAttribute(
                    "error",
                    "❌ Lỗi hệ thống khi xoá acc!"
            );
        }

        response.sendRedirect("products");
    }
}

