<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.GameAccount" %>

<%
    GameAccount acc = (GameAccount) request.getAttribute("account");
%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Chi Tiết Tài Khoản</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:Arial,sans-serif;
        }

        body{
            background:#0f172a;
            color:white;
            min-height:100vh;
            padding:40px;
        }

        .container{
            max-width:1400px;
            margin:auto;
            display:grid;
            grid-template-columns:1.1fr 1fr;
            gap:40px;
        }

        /* LEFT */

        .left{
            background:#111827;
            border-radius:20px;
            padding:25px;
            box-shadow:0 0 25px rgba(0,0,0,0.4);
        }

        .main-image{
            width:100%;
            height:500px;
            object-fit:cover;
            border-radius:18px;
            border:3px solid #334155;
            transition:0.3s;
        }

        .thumbs{
            display:flex;
            gap:15px;
            margin-top:20px;
            overflow-x:auto;
        }

        .thumbs img{
            width:120px;
            height:90px;
            object-fit:cover;
            border-radius:12px;
            cursor:pointer;
            border:3px solid transparent;
            transition:0.25s;
        }

        .thumbs img:hover{
            transform:scale(1.05);
            border-color:#38bdf8;
        }

        /* RIGHT */

        .right{
            background:#111827;
            border-radius:20px;
            padding:30px;
            box-shadow:0 0 25px rgba(0,0,0,0.4);
        }

        .tag{
            display:inline-block;
            background:#ef4444;
            padding:8px 16px;
            border-radius:30px;
            margin-bottom:20px;
            font-weight:bold;
            font-size:14px;
        }

        .title{
            font-size:34px;
            font-weight:bold;
            margin-bottom:15px;
        }

        .price{
            font-size:40px;
            color:#22c55e;
            margin-bottom:25px;
            font-weight:bold;
        }

        .info-box{
            background:#1e293b;
            padding:18px;
            border-radius:15px;
            margin-bottom:18px;
        }

        .info-title{
            color:#94a3b8;
            margin-bottom:8px;
            font-size:14px;
        }

        .info-content{
            font-size:18px;
            font-weight:bold;
        }

        .description{
            margin-top:25px;
            line-height:1.8;
            color:#cbd5e1;
        }

        .btn-group{
            display:flex;
            gap:20px;
            margin-top:35px;
        }

        .btn{
            flex:1;
            padding:18px;
            border:none;
            border-radius:15px;
            cursor:pointer;
            font-size:18px;
            font-weight:bold;
            transition:0.25s;

            display:flex;
            justify-content:center;
            align-items:center;

            text-decoration:none;
        }

        .cart-btn{
            background:linear-gradient(45deg,#3b82f6,#2563eb);
            color:white;
        }

        .buy-btn{
            background:linear-gradient(45deg,#22c55e,#16a34a);
            color:white;
        }

        .btn:hover{
            transform:translateY(-3px);
            box-shadow:0 10px 20px rgba(0,0,0,0.3);
        }

        @media(max-width:1100px){

            .container{
                grid-template-columns:1fr;
            }

            .main-image{
                height:400px;
            }

        }

    </style>

</head>

<body>

<div class="container">

    <!-- LEFT -->

    <div class="left">

        <!-- ẢNH CHÍNH -->

        <img id="mainImg"
             class="main-image"
             src="<%= acc.getImage() %>"
             alt="">

        <!-- ẢNH PHỤ -->

        <div class="thumbs">

            <img onclick="changeImg(this)"
                 src="<%= acc.getImage() %>">

            <img onclick="changeImg(this)"
                 src="images/demo1.jpg">

            <img onclick="changeImg(this)"
                 src="images/demo2.jpg">

            <img onclick="changeImg(this)"
                 src="images/demo3.jpg">

        </div>

    </div>

    <!-- RIGHT -->

    <div class="right">

        <div class="tag">
            HOT ACCOUNT
        </div>

        <div class="title">
            <%= acc.getTitle() %>
        </div>

        <div class="price">
            <%= acc.getPrice() %> VNĐ
        </div>

        <div class="info-box">

            <div class="info-title">
                Rank
            </div>

            <div class="info-content">
                <%= acc.getRank() %>
            </div>

        </div>

        <div class="info-box">

            <div class="info-title">
                Skin
            </div>

            <div class="info-content">
                <%= acc.getSkin() %>
            </div>

        </div>

        <div class="info-box">

            <div class="info-title">
                Tướng
            </div>

            <div class="info-content">
                <%= acc.getChampion() %>
            </div>

        </div>

        <div class="description">

            <%= acc.getDescription() %>

        </div>

        <!-- BUTTON -->

        <div class="btn-group">

            <!-- THÊM GIỎ -->

            <a href="add-to-cart?id=<%= acc.getId() %>"
               class="btn cart-btn">

                Thêm Giỏ Hàng

            </a>

            <!-- MUA NGAY -->

            <a href="buy-now?id=<%= acc.getId() %>"
               class="btn buy-btn">

                Mua Ngay

            </a>

        </div>

    </div>

</div>

<script>

    function changeImg(el){

        document.getElementById("mainImg").src = el.src;

    }

</script>

</body>

</html>