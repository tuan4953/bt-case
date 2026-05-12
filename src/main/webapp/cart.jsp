<%@ page import="java.util.List" %>
<%@ page import="model.GameAccount" %>
<%@ page import="model.User" %>
<%@ page import="dao.CartDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user =
            (User) session.getAttribute("user");

    if(user == null){

        response.sendRedirect("login.jsp");
        return;
    }

    CartDAO cartDAO =
            new CartDAO();

    List<GameAccount> cart =
            cartDAO.getCartByUser(user.getId());

    double total = 0;
%>

<html>

<head>

    <title>Cart</title>

    <style>

        body{
            background-image: url('https://t4.ftcdn.net/jpg/03/04/86/61/360_F_304866110_63UOE2JR9mdXnB6IOlqjgNUrkkAPLvvI.jpg');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            color:red;
            font-family:Arial;
            padding:30px;
            margin:0;
        }

        h1{
            text-align:center;
            color:gold;
            margin-bottom:30px;
        }

        .container{
            width:1000px;
            margin:auto;
        }

        .top{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:30px;
        }

        .back-btn{
            background:#001f54;
            color:white;
            text-decoration:none;
            padding:12px 20px;
            border-radius:10px;
            font-weight:bold;
        }

        .item{
            display:flex;
            gap:20px;
            background:#1c1c1c;
            border:2px solid gold;
            margin-top:20px;
            border-radius:15px;
            overflow:hidden;
        }

        .item img{
            width:250px;
            height:180px;
            object-fit:cover;
        }

        .info{
            padding:20px;
            flex:1;
        }

        .info h2{
            margin-top:0;
            color:gold;
        }

        .price{
            color:yellow;
            font-size:28px;
            font-weight:bold;
            margin-top:10px;
        }

        .btn{
            display:inline-block;
            margin-top:15px;
            padding:10px 20px;
            background:#8b0000;
            color:white;
            text-decoration:none;
            border-radius:10px;
            font-weight:bold;
        }

        .btn:hover{
            background:#c40000;
        }

        .total{
            text-align:right;
            margin-top:30px;
            font-size:35px;
            color:gold;
            font-weight:bold;
        }

        .checkout{
            text-align:right;
            margin-top:20px;
        }

        .checkout button{
            padding:15px 35px;
            border:none;
            background:gold;
            color:black;
            font-size:20px;
            font-weight:bold;
            border-radius:10px;
            cursor:pointer;
        }

        .checkout button:hover{
            opacity:0.9;
        }

        .empty{
            text-align:center;
            margin-top:100px;
            font-size:30px;
            color:gray;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="top">

        <a class="back-btn"
           href="products">

            ← QUAY LẠI SHOP

        </a>

        <h1>GIỎ HÀNG</h1>

    </div>

    <%
        if(cart != null && !cart.isEmpty()){

            for(GameAccount g : cart){

                total += g.getPrice();
    %>

    <div class="item">

        <img src="<%= request.getContextPath() %>/image?name=<%= g.getImage() %>">

        <div class="info">

            <h2>

                <%= g.getGameName() %>

            </h2>

            <p>

                Tài khoản:
                <%= g.getAccountName() %>

            </p>

            <p>

                Trạng thái:
                <%= g.getStatus() %>

            </p>

            <div class="price">

                <%= (int)g.getPrice() %>đ

            </div>

            <a class="btn"
               href="remove-cart?id=<%= g.getId() %>">

                XOÁ KHỎI GIỎ

            </a>

        </div>

    </div>

    <%
        }
    %>

    <div class="total">

        Tổng:
        <%= (int)total %>đ

    </div>

    <div class="checkout">

        <form action="checkout-cart"
              method="post">

            <button type="submit">

                THANH TOÁN TẤT CẢ

            </button>

        </form>

    </div>

    <%
    } else {
    %>

    <div class="empty">

        Giỏ hàng trống

    </div>

    <%
        }
    %>

</div>

</body>
</html>