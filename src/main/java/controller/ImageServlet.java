package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {

    // 🔥 THƯ MỤC LƯU ẢNH (ngoài project để KHÔNG mất khi restart server)
    private static final String UPLOAD_DIR = "C:/game-shop/uploads/";

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");

        if (name == null || name.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 🔥 chống path traversal
        name = new File(name).getName();

        File file = new File(UPLOAD_DIR + name);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // lấy đúng type ảnh
        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            contentType = "image/jpeg";
        }

        response.setContentType(contentType);
        response.setContentLength((int) file.length());

        try (FileInputStream fis = new FileInputStream(file);
             BufferedInputStream bis = new BufferedInputStream(fis);
             OutputStream os = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = bis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}