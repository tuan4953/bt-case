package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import service.UserService;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {

            // 1. Get data
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");

            // 2. Validate input (QUAN TRỌNG)
            if (username == null || password == null
                    || username.trim().isEmpty()
                    || password.trim().isEmpty()) {

                response.getWriter().println("Username or password is empty");
                return;
            }

            // 3. Create user object
            User user = new User();
            user.setUsername(username.trim());
            user.setPassword(password.trim());
            user.setEmail(email != null ? email.trim() : null);

            // 4. Register
            boolean check = userService.register(user);

            // 5. Result
            if (check) {
                response.sendRedirect("login.jsp");
            } else {
                response.getWriter().println("Register failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Server error: " + e.getMessage());
        }
    }
}