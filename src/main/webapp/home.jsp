<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  User user =
          (User) session.getAttribute("user");

  // CHƯA LOGIN
  if(user == null){

    response.sendRedirect("login.jsp");
    return;
  }
%>

<html>

<head>

  <title>HOME</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
        rel="stylesheet">

  <style>

    *{
      margin:0;
      padding:0;
      box-sizing:border-box;
    }

    body{
      font-family:Arial;
      background:#111;
      color:white;
      overflow-x:hidden;
    }

    /* ========================= */
    /* HEADER */
    /* ========================= */

    .header{
      width:100%;
      padding:20px 50px;
      background:#1c1c1c;
      border-bottom:2px solid gold;

      display:flex;
      justify-content:space-between;
      align-items:center;
    }

    .logo{
      font-size:32px;
      font-weight:bold;
      color:gold;
    }

    .user-box{
      color:white;
      font-size:18px;
      font-weight:bold;
    }

    /* ========================= */
    /* BANNER */
    /* ========================= */

    .banner{
      height:350px;
      background:url('https://images7.alphacoders.com/133/1338701.png');
      background-size:cover;
      background-position:center;

      display:flex;
      justify-content:center;
      align-items:center;
      flex-direction:column;
      text-align:center;

      position:relative;
    }

    .banner::before{
      content:'';
      position:absolute;
      inset:0;
      background:rgba(0,0,0,0.5);
    }

    .banner h1,
    .banner p{
      position:relative;
      z-index:2;
    }

    .banner h1{
      font-size:65px;
      color:gold;
      text-shadow:0 0 20px black;
    }

    .banner p{
      margin-top:20px;
      font-size:22px;
      width:800px;
    }

    /* ========================= */
    /* MENU BOX */
    /* ========================= */

    .content{
      width:1300px;
      margin:70px auto;
    }

    .title{
      text-align:center;
      font-size:45px;
      color:gold;
      margin-bottom:50px;
    }

    .box-area{
      display:grid;
      grid-template-columns:repeat(4,1fr);
      gap:30px;
    }

    .box{
      background:#1c1c1c;
      border:2px solid gold;
      border-radius:25px;
      padding:40px 25px;
      text-align:center;
      transition:0.4s;
      cursor:pointer;
      position:relative;
      overflow:hidden;
    }

    .box:hover{
      transform:translateY(-12px) scale(1.03);
      box-shadow:0 0 25px gold;
    }

    .icon{
      font-size:70px;
      margin-bottom:20px;
    }

    .box h2{
      color:gold;
      margin-bottom:20px;
      font-size:28px;
    }

    .box p{
      color:#ddd;
      line-height:28px;
      min-height:90px;
    }

    .go-btn{

      display:inline-block;
      margin-top:25px;
      padding:12px 30px;
      background:gold;
      color:black;
      border-radius:12px;
      text-decoration:none;
      font-weight:bold;
      transition:0.3s;
    }

    .go-btn:hover{
      background:white;
      transform:scale(1.05);
    }

    /* ========================= */
    /* FOOTER */
    /* ========================= */

    .footer{
      margin-top:80px;
      background:#1c1c1c;
      border-top:2px solid gold;
      padding:30px;
      text-align:center;
      color:#aaa;
    }

    .footer h3{
      color:gold;
      margin-bottom:10px;
    }

  </style>

</head>
<jsp:include page="chat-box.jsp" />
<body>

<div class="header" >

  <div class="logo">
    SHOP ACC GAME
  </div>

  <div style="
        display:flex;
        align-items:center;
        gap:15px;
">

    <div class="user-box">

      Xin chào,
      <%= user.getUsername() %>

    </div>

    <a href="logout"
       style="
            background:#8b0000;
            color:white;
            text-decoration:none;
            padding:10px 18px;
            border-radius:10px;
            font-weight:bold;
            transition:0.3s;
       "
       onmouseover="this.style.background='red'"
       onmouseout="this.style.background='#8b0000'">

      LOGOUT

    </a>

  </div>

</div>

<div class="banner">

  <h1>
    HỆ THỐNG SHOP ACC GAME
  </h1>

</div>

<div class="content">

  <div class="title">
    CHỨC NĂNG WEBSITE
  </div>

  <div class="box-area">

    <!-- PRODUCTS -->

    <div class="box" onclick="location.href='products'">

      <div class="icon">
        🎮
      </div>

      <h2>
        SHOP ACC
      </h2>

      <p>
        Xem toàn bộ acc game,
        tìm kiếm và mua acc nhanh chóng.
      </p>

      <a class="go-btn"
         href="products">

        VÀO SHOP

      </a>

    </div>

    <!-- GIẢI TRÍ -->

    <div class="box" onclick="location.href='taixiu.jsp'">

      <div class="icon">
        🎲
      </div>

      <h2>
        GIẢI TRÍ
      </h2>

      <p>
        Khu vực giải trí,
        mini game và hiệu ứng website.
      </p>

      <a class="go-btn"
         href="taixiu.jsp">

        TRUY CẬP

      </a>

    </div>

    <!-- NẠP TIỀN -->

    <div class="box" onclick="location.href='deposit.jsp'">

      <div class="icon">
        💰
      </div>

      <h2>
        NẠP TIỀN
      </h2>

      <p>
        Nạp tiền trực tiếp vào tài khoản
        để mua acc game.
      </p>

      <a class="go-btn"
         href="deposit.jsp">

        NẠP NGAY

      </a>

    </div>

    <!-- LỊCH SỬ -->

    <div class="box" onclick="location.href='purchase-history'">

      <div class="icon">
        📜
      </div>

      <h2>
        BILL & LỊCH SỬ
      </h2>

      <p>
        Xem lại acc đã mua,
        bill và lịch sử giao dịch.
      </p>

      <a class="go-btn"
         href="purchase-history">

        XEM BILL

      </a>

    </div>

  </div>

</div>

<div class="footer">

  <h3>
    SHOP ACC GAME
  </h3>

  <p>
    © 2026 All Rights Reserved
  </p>

  <p>
    JSP Servlet + MySQL
  </p>

</div>

</body>

</html>


