<%@ page import="model.GameAccount" %>
<%@ page import="java.util.List" %>
<%@ page import="model.AccountImage" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    GameAccount acc =
            (GameAccount) request.getAttribute("account");

    List<AccountImage> images =
            (List<AccountImage>)
                    request.getAttribute("images");

    if(acc == null){

        response.sendRedirect(
                request.getContextPath()
                        + "/products"
        );

        return;
    }

    String img =
            (acc.getImage() != null &&
                    !acc.getImage().isEmpty())
                    ? acc.getImage()
                    : "default.jpg";
%>

<!DOCTYPE html>
<html>

<head>

    <title>CHI TIẾT ACC</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{

            background:#0f0f0f;

            font-family:Arial;

            color:white;
        }

        .container{

            width:1200px;

            margin:50px auto;

            display:flex;

            gap:40px;

            align-items:flex-start;
        }

        /* ================= LEFT ================= */

        .left{

            width:50%;
        }

        .main-image{

            width:100%;

            height:500px;

            object-fit:cover;

            border-radius:20px;

            border:3px solid gold;

            box-shadow:0 0 20px rgba(255,215,0,0.3);
        }

        /* ================= GALLERY ================= */

        .gallery{

            display:flex;

            gap:15px;

            margin-top:20px;

            flex-wrap:wrap;
        }

        .gallery img{

            width:120px;

            height:80px;

            object-fit:cover;

            border-radius:10px;

            border:2px solid gold;

            cursor:pointer;

            transition:0.3s;
        }

        .gallery img:hover{

            transform:scale(1.05);

            box-shadow:0 0 15px gold;
        }

        /* ================= RIGHT ================= */

        .right{

            width:50%;

            background:#1a1a1a;

            padding:30px;

            border-radius:20px;

            border:2px solid gold;
        }

        h1{

            color:gold;

            margin-bottom:25px;

            font-size:40px;
        }

        .info{

            line-height:45px;

            font-size:20px;
        }

        .price{

            font-size:42px;

            color:gold;

            font-weight:bold;

            margin:30px 0;
        }

        /* ================= BUTTONS ================= */

        .buttons{

            display:flex;

            gap:15px;

            margin-top:30px;

            width:100%;
        }

        .buttons a{

            flex:1;

            text-align:center;

            text-decoration:none;

            padding:15px 20px;

            border-radius:12px;

            font-weight:bold;

            transition:0.3s;

            font-size:16px;

            box-shadow:0 0 10px rgba(255,255,255,0.2);
        }

        .buy{

            background:#007bff;

            color:white;
        }

        .cart{

            background:#00a651;

            color:white;
        }

        .buttons a:hover{

            transform:translateY(-3px);

            opacity:0.9;
        }

        /* ================= BACK ================= */

        .back{

            display:inline-block;

            margin-top:30px;

            color:gold;

            text-decoration:none;

            font-weight:bold;
        }

        .back:hover{

            text-decoration:underline;
        }

        /* ================= RESPONSIVE ================= */

        @media(max-width:1250px){

            .container{

                width:95%;
            }
        }

        @media(max-width:900px){

            .container{

                flex-direction:column;
            }

            .left,
            .right{

                width:100%;
            }
        }

    </style>

</head>

<body>

<div class="container">

    <!-- LEFT -->

    <div class="left">

        <!-- MAIN IMAGE -->

        <img
                id="mainImage"
                class="main-image"
                src="<%= request.getContextPath() %>/image?name=<%= img %>"
        >

        <!-- MULTIPLE IMAGES -->

        <div class="gallery">

            <%
                if(images != null &&
                        !images.isEmpty()){

                    for(AccountImage i : images){
            %>

            <img
                    src="<%= request.getContextPath() %>/image?name=<%= i.getImageName() %>"
                    onclick="changeImage(this.src)"
            >

            <%
                    }
                }
            %>

        </div>

    </div>

    <!-- RIGHT -->

    <div class="right">

        <h1>

            <%= acc.getAccountName() %>

        </h1>

        <div class="info">

            🎮 Game:
            <%= acc.getGameName() %>

            <br>

            📌 Trạng thái:
            <%= acc.getStatus() %>

            <br>

            🆔 Mã acc:
            #<%= acc.getId() %>

        </div>

        <div class="price">

            <%= (int)acc.getPrice() %>đ

        </div>

        <div class="buttons">

            <a class="cart"
               href="<%= request.getContextPath() %>/add-to-cart?id=<%= acc.getId() %>">

                🛒 Thêm vào giỏ

            </a>

            <a class="buy"
               href="<%= request.getContextPath() %>/buy-now?id=<%= acc.getId() %>"
               onclick="return confirm('Xác nhận mua acc này?')">

                💳 Mua ngay

            </a>

        </div>

        <a class="back"
           href="<%= request.getContextPath() %>/products">

            ← Quay lại cửa hàng

        </a>

    </div>

</div>

<script>

    // ĐỔI ẢNH LỚN

    function changeImage(src){

        document.getElementById(
            "mainImage"
        ).src = src;
    }

</script>

</body>
</html>