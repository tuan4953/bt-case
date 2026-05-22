
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer totalUsers =
            (Integer) request.getAttribute("totalUsers");

    Double totalRevenue =
            (Double) request.getAttribute("totalRevenue");

    Integer totalSold =
            (Integer) request.getAttribute("totalSold");

    if(totalUsers == null)
        totalUsers = 0;

    if(totalRevenue == null)
        totalRevenue = 0.0;

    if(totalSold == null)
        totalSold = 0;
%>

<!DOCTYPE html>
<html>

<head>

    <title>Admin Dashboard</title>

    <meta charset="UTF-8">

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{

            font-family:'Segoe UI',sans-serif;

            background:
                    linear-gradient(
                            rgba(0,0,0,0.88),
                            rgba(0,0,0,0.92)
                    ),
                    url('https://images.unsplash.com/photo-1542751110-97427bbecf20');

            background-size:cover;

            background-attachment:fixed;

            color:white;

            min-height:100vh;
        }

        a{
            text-decoration:none;
        }

        /* HEADER */

        .header{

            display:flex;

            justify-content:space-between;

            align-items:center;

            padding:18px 35px;

            background:
                    rgba(15,15,15,0.78);

            backdrop-filter:blur(14px);

            border-bottom:
                    1px solid rgba(255,215,0,0.2);
        }

        .logo{

            font-size:30px;

            font-weight:900;

            color:gold;

            letter-spacing:2px;

            text-shadow:
                    0 0 12px gold;
        }

        .back-btn{

            padding:12px 18px;

            border-radius:12px;

            background:
                    linear-gradient(
                            135deg,
                            gold,
                            #ffcc00
                    );

            color:black;

            font-weight:bold;

            transition:0.3s;
        }

        .back-btn:hover{

            transform:
                    translateY(-2px);

            box-shadow:
                    0 0 15px gold;
        }

        /* TITLE */

        .page-title{

            text-align:center;

            padding:45px 20px 30px;
        }

        .page-title h1{

            font-size:55px;

            font-weight:900;

            color:gold;

            text-shadow:
                    0 0 20px gold;
        }

        .page-title p{

            margin-top:10px;

            color:#ccc;

            font-size:15px;
        }

        /* DASHBOARD */

        .dashboard{

            width:95%;

            margin:auto;

            display:grid;

            grid-template-columns:1fr;

            gap:22px;

            padding-bottom:50px;
        }

        .card{

            background:
                    linear-gradient(
                            145deg,
                            rgba(20,20,20,0.96),
                            rgba(10,10,10,0.96)
                    );

            border:
                    1px solid rgba(255,215,0,0.18);

            border-radius:22px;

            padding:30px;

            text-align:center;

            transition:0.3s;

            position:relative;

            overflow:hidden;
        }

        .card:hover{

            transform:
                    translateY(-6px);

            border-color:gold;

            box-shadow:
                    0 0 25px rgba(255,215,0,0.22);
        }

        .card::before{

            content:"";

            position:absolute;

            top:-50%;

            left:-50%;

            width:200%;

            height:200%;

            background:
                    linear-gradient(
                            transparent,
                            rgba(255,215,0,0.08),
                            transparent
                    );

            transform:rotate(25deg);

            animation:shine 5s linear infinite;
        }

        @keyframes shine{

            0%{
                transform:
                        rotate(25deg)
                        translateX(-100%);
            }

            100%{
                transform:
                        rotate(25deg)
                        translateX(100%);
            }
        }

        .card-icon{

            font-size:55px;

            margin-bottom:18px;
        }

        .card-title{

            font-size:18px;

            color:#ccc;

            margin-bottom:15px;
        }

        .card-value{

            font-size:42px;

            font-weight:900;

            color:gold;

            text-shadow:
                    0 0 14px rgba(255,215,0,0.4);
        }

        /* FOOTER */

        .footer{

            margin-top:40px;

            padding:30px;

            text-align:center;

            background:#090909;

            border-top:
                    1px solid rgba(255,215,0,0.2);
        }

        .footer h2{

            color:gold;

            margin-bottom:10px;
        }

        .footer p{

            color:#aaa;

            margin-top:8px;
        }

        /* MOBILE FIRST */

        @media(min-width:700px){

            .dashboard{

                grid-template-columns:
repeat(2,1fr);
            }

            .page-title h1{

                font-size:60px;
            }
        }

        @media(min-width:1100px){

            .dashboard{

                grid-template-columns:
repeat(3,1fr);
            }
        }

    </style>

</head>

<body>

<div class="header">

    <div class="logo">

        🎮 ADMIN PANEL

    </div>

    <a href="products"
       class="back-btn">

        ← QUAY LẠI SHOP

    </a>

</div>

<div class="page-title">

    <h1>
        📊 DASHBOARD ADMIN
    </h1>

    <p>
        Thống kê tổng quan hệ thống bán acc game
    </p>

</div>

<div class="dashboard">

    <!-- TOTAL USERS -->

    <div class="card">

        <div class="card-icon">
            👤
        </div>

        <div class="card-title">
            TỔNG USER
        </div>

        <div class="card-value">

            <%= totalUsers %>

        </div>

    </div>

    <!-- TOTAL SOLD -->

    <div class="card">

        <div class="card-icon">
            📦
        </div>

        <div class="card-title">
            ACC ĐÃ BÁN
        </div>

        <div class="card-value">

            <%= totalSold %>

        </div>

    </div>

    <!-- TOTAL REVENUE -->

    <div class="card">

        <div class="card-icon">
            💰
        </div>

        <div class="card-title">
            TỔNG DOANH THU
        </div>

        <div class="card-value">

            <%= String.format("%,.0f",totalRevenue) %>đ

        </div>

    </div>

</div>

<div class="footer">

    <h2>
        🎮 GAME STORE ADMIN
    </h2>

    <p>
        Hệ thống quản trị website bán acc game
    </p>

    <p>
        Responsive • Gaming UI • MVC Architecture
    </p>

</div>

</body>
</html>

