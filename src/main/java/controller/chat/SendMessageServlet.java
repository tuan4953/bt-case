package controller.chat;

import dao.ChatDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

import java.io.IOException;

@WebServlet("/send-message")
public class SendMessageServlet
        extends HttpServlet {

    ChatDAO chatDAO =
            new ChatDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute("user");

        if(user == null){

            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");

            return;
        }

        String message =
                request.getParameter("message");

        if(message != null &&
                !message.trim().isEmpty()){

            chatDAO.sendMessage(
                    user.getId(),
                    user.getRole(),
                    message
            );
        }

        response.sendRedirect(
                request.getHeader("Referer")
        );
    }
}