package controller;

import dao.AccountImageDAO;
import dao.GameAccountDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.GameAccount;

import java.io.File;
import java.io.IOException;
import java.util.Collection;

@WebServlet("/update-product")

@MultipartConfig(

        fileSizeThreshold = 1024 * 1024,

        maxFileSize = 1024 * 1024 * 10,

        maxRequestSize = 1024 * 1024 * 50
)

public class UpdateProductServlet
        extends HttpServlet {

    private final GameAccountDAO dao =
            new GameAccountDAO();

    private final AccountImageDAO imageDAO =
            new AccountImageDAO();

    // ẢNH CHÍNH

    private static final String UPLOAD_DIR =
            "C:/game-shop/uploads";

    // ẢNH PHỤ

    private static final String SUB_UPLOAD_DIR =
            "C:/game-shop/uploads/accounts";

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    )
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setCharacterEncoding("UTF-8");

        try {

            // =========================
            // GET ID
            // =========================

            String idParam =
                    request.getParameter("id");

            if(idParam == null ||
                    idParam.isEmpty()){

                response.sendRedirect(
                        request.getContextPath()
                                + "/products"
                );

                return;
            }

            int id =
                    Integer.parseInt(idParam);

            // =========================
            // GET OLD PRODUCT
            // =========================

            GameAccount old =
                    dao.getProductById(id);

            if(old == null){

                response.sendRedirect(
                        request.getContextPath()
                                + "/products"
                );

                return;
            }

            // =========================
            // MAIN IMAGE
            // =========================

            String imageName =
                    old.getImage();

            Part filePart =
                    request.getPart("image");

            // CÓ ẢNH MỚI

            if(filePart != null
                    &&
                    filePart.getSize() > 0){

                String original =
                        filePart.getSubmittedFileName();

                if(original != null
                        &&
                        !original.trim().isEmpty()){

                    original =
                            original.replaceAll(
                                    "\\s+",
                                    "_"
                            );

                    String fileName =
                            System.currentTimeMillis()
                                    + "_"
                                    + original;

                    File dir =
                            new File(UPLOAD_DIR);

                    if(!dir.exists()){

                        dir.mkdirs();
                    }

                    // SAVE FILE

                    filePart.write(
                            UPLOAD_DIR
                                    + File.separator
                                    + fileName
                    );

                    imageName = fileName;
                }
            }

            // =========================
            // UPDATE PRODUCT
            // =========================

            GameAccount g =
                    new GameAccount();

            g.setId(id);

            g.setGameName(
                    request.getParameter("gameName")
            );

            g.setAccountName(
                    request.getParameter("accountName")
            );

            g.setPrice(
                    Double.parseDouble(
                            request.getParameter("price")
                    )
            );

            g.setStatus(
                    request.getParameter("status")
            );

            g.setImage(imageName);

            boolean ok =
                    dao.updateProduct(g);

            // =========================
            // SAVE MULTIPLE IMAGES
            // =========================

            if(ok){

                File subDir =
                        new File(SUB_UPLOAD_DIR);

                if(!subDir.exists()){

                    subDir.mkdirs();
                }

                Collection<Part> parts =
                        request.getParts();

                for(Part part : parts){

                    if(part.getName()
                            .equals("subImages")

                            &&

                            part.getSize() > 0){

                        String original =
                                part.getSubmittedFileName();

                        if(original != null
                                &&
                                !original.trim().isEmpty()){

                            original =
                                    original.replaceAll(
                                            "\\s+",
                                            "_"
                                    );

                            String fileName =
                                    System.currentTimeMillis()
                                            + "_"
                                            + original;

                            // SAVE FILE

                            part.write(
                                    SUB_UPLOAD_DIR
                                            + File.separator
                                            + fileName
                            );

                            // SAVE DATABASE

                            imageDAO.addImage(
                                    id,
                                    fileName
                            );
                        }
                    }
                }

                // SUCCESS

                request.getSession()
                        .setAttribute(
                                "message",
                                "Cập nhật sản phẩm thành công!"
                        );

                response.sendRedirect(
                        request.getContextPath()
                                + "/account-detail?id="
                                + id
                );

            } else {

                request.getSession()
                        .setAttribute(
                                "error",
                                "Update thất bại!"
                        );

                response.sendRedirect(
                        request.getContextPath()
                                + "/edit-product?id="
                                + id
                );
            }

        } catch (Exception e){

            e.printStackTrace();

            request.getSession()
                    .setAttribute(
                            "error",
                            "Server error!"
                    );

            response.sendRedirect(
                    request.getContextPath()
                            + "/products"
            );
        }
    }
}