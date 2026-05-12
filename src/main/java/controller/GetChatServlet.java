package controller;

import dao.ChatDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.SupportMessage;

import java.io.IOException;
import java.util.List;

@WebServlet("/chat-box")
public class GetChatServlet extends HttpServlet {

    ChatDAO chatDAO =
            new ChatDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<SupportMessage> list =
                chatDAO.getMessages();

        request.setAttribute("chatList", list);

        request.getRequestDispatcher(
                "chat-box.jsp"
        ).forward(request,response);
    }
}