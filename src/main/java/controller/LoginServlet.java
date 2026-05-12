package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.UserService;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // 1. Validate input
            if (username == null || password == null
                    || username.trim().isEmpty()
                    || password.trim().isEmpty()) {

                response.getWriter().println("Missing username or password");
                return;
            }

            // 2. Login check
            User user = userService.login(username, password);

            if (user != null) {

                // 3. Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // 4. Role redirect (mở rộng admin/user)
                if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/products");
                } else {
                    response.sendRedirect(request.getContextPath() + "/home.jsp");
                }

            } else {
                response.getWriter().println("Wrong username or password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login failed");
        }
    }
}