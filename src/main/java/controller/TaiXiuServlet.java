package controller;

import dao.BalanceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Random;

@WebServlet("/tai-xiu")
public class TaiXiuServlet extends HttpServlet {

    BalanceDAO balanceDAO = new BalanceDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        int userId = Integer.parseInt(request.getParameter("userId"));
        double bet = Double.parseDouble(request.getParameter("bet"));
        String choice = request.getParameter("choice"); // TAI / XIU

        // trừ tiền trước
        boolean ok = balanceDAO.deductMoney(userId, bet);

        if (!ok) {
            session.setAttribute("message", "Không đủ tiền!");
            response.sendRedirect("taixiu.jsp");
            return;
        }

        // random 3 xúc xắc
        Random r = new Random();
        int total = r.nextInt(16) + 3;

        String result = (total >= 11) ? "TAI" : "XIU";

        if (result.equals(choice)) {
            double win = bet * 2;
            balanceDAO.addMoney(userId, win);

            session.setAttribute("message", "Thắng + " + win);
        } else {
            session.setAttribute("message", "Thua mất " + bet);
        }

        response.sendRedirect("taixiu.jsp");
    }
}