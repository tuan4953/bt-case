package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        String name =
                request.getParameter("name");

        if(name == null || name.isEmpty()){

            return;
        }

        // ẢNH CHÍNH

        String path =
                "C:/game-shop/uploads/" + name;

        File file =
                new File(path);

        // NẾU KHÔNG CÓ -> CHECK ẢNH PHỤ

        if(!file.exists()){

            path =
                    "C:/game-shop/uploads/accounts/"
                            + name;

            file = new File(path);
        }

        // KHÔNG TỒN TẠI

        if(!file.exists()){

            response.getWriter()
                    .println("Image not found");

            return;
        }

        response.setContentType(
                getServletContext()
                        .getMimeType(file.getName())
        );

        FileInputStream fis =
                new FileInputStream(file);

        OutputStream os =
                response.getOutputStream();

        byte[] buffer =
                new byte[4096];

        int length;

        while((length = fis.read(buffer)) > 0){

            os.write(buffer,0,length);
        }

        fis.close();
        os.close();
    }
}