package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebFilter({
        "/add-product.jsp",
        "/add-product",
        "/delete-product",
        "/edit-product",
        "/update-product",
        "/admin.jsp"
})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        // 1. chưa login
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 2. check user
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() == null
                || !user.getRole().equalsIgnoreCase("ADMIN")) {

            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        // 3. pass filter
        chain.doFilter(request, response);
    }
}