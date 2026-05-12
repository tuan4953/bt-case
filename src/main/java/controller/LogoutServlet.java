package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // 1. Lấy session hiện tại (KHÔNG tạo mới)
            HttpSession session = request.getSession(false);

            // 2. Nếu có session thì mới xoá
            if (session != null) {
                session.invalidate();
            }

            // 3. Redirect an toàn
            response.sendRedirect(request.getContextPath() + "/index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Logout error");
        }
    }
}