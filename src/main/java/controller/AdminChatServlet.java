package controller;

import dao.ChatDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin-chat")
public class AdminChatServlet
        extends HttpServlet {

    ChatDAO chatDAO =
            new ChatDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "chatList",
                chatDAO.getAllMessages()
        );

        request.getRequestDispatcher(
                "admin-chat.jsp"
        ).forward(request,response);
    }
}