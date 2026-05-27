
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  User user =
          (User) session.getAttribute("user");

  if(user == null){

    response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
    return;
  }
%>

<html>

<head>

  <title>Nạp Tiền</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
        rel="stylesheet">

  <style>

    body{
      margin:0;
      font-family:Arial;
      background:#111;
      color:white;
    }

    .header{
      background:#1c1c1c;
      padding:20px 40px;
      border-bottom:2px solid gold;

      display:flex;
      justify-content:space-between;
      align-items:center;
    }

    .logo{
      color:gold;
      font-size:32px;
      font-weight:bold;
    }

    .back-btn{
      background:#8b0000;
      color:white;
      text-decoration:none;
      padding:12px 20px;
      border-radius:10px;
      font-weight:bold;
    }

    .title{
      text-align:center;
      color:gold;
      margin-top:40px;
      font-size:50px;
    }

    .container-box{
      width:1400px;
      margin:50px auto;

      display:grid;
      grid-template-columns:repeat(3,1fr);
      gap:30px;
    }

    .box{
      background:#1c1c1c;
      border:2px solid gold;
      border-radius:20px;
      padding:30px;
      transition:0.3s;
    }

    .box:hover{
      transform:translateY(-8px);
      box-shadow:0 0 20px gold;
    }

    .box h2{
      color:gold;
      text-align:center;
      margin-bottom:30px;
    }

    .form-group{
      margin-bottom:20px;
    }

    .form-group label{
      display:block;
      margin-bottom:8px;
      font-weight:bold;
    }

    .form-group input,
    .form-group select{
      width:100%;
      padding:14px;
      border:none;
      border-radius:10px;
      outline:none;
      background:#2a2a2a;
      color:white;
    }

    .submit-btn{
      width:100%;
      padding:15px;
      border:none;
      background:gold;
      color:black;
      font-size:18px;
      font-weight:bold;
      border-radius:12px;
      cursor:pointer;
      margin-top:10px;
      transition:0.3s;
    }

    .submit-btn:hover{
      transform:scale(1.03);
      background:white;
    }

    .qr-box{
      text-align:center;
    }

    .qr-box img{
      width:280px;
      height:280px;
      object-fit:cover;
      border-radius:15px;
      border:3px solid gold;
      margin-top:20px;
    }

    .note{
      margin-top:20px;
      line-height:30px;
      color:#ccc;
      text-align:center;
    }

    .footer{
      margin-top:80px;
      background:#1c1c1c;
      border-top:2px solid gold;
      padding:25px;
      text-align:center;
      color:#aaa;
    }

  </style>

</head>
<jsp:include page="../chat/chat-box.jsp" />
<body>

<div class="header">

  <div class="logo">
    SHOP ACC GAME
  </div>

  <a class="back-btn"
     href="../home.jsp">

    ← QUAY LẠI HOME

  </a>

</div>

<h1 class="title">
  NẠP TIỀN TÀI KHOẢN
</h1>

<div class="container-box">

  <!-- ========================= -->
  <!-- NẠP THẺ CÀO -->
  <!-- ========================= -->

  <div class="box">

    <h2>
      📱 NẠP THẺ CÀO
    </h2>

    <form>

      <div class="form-group">

        <label>
          Số seri
        </label>

        <input type="text"
               placeholder="Nhập số seri thẻ">

      </div>

      <div class="form-group">

        <label>
          Mã thẻ cào
        </label>

        <input type="text"
               placeholder="Nhập mã thẻ">

      </div>

      <div class="form-group">

        <label>
          Giá trị thẻ
        </label>

        <select>

          <option>
            10.000đ
          </option>

          <option>
            20.000đ
          </option>

          <option>
            50.000đ
          </option>

          <option>
            100.000đ
          </option>

          <option>
            200.000đ
          </option>

          <option>
            500.000đ
          </option>

        </select>

      </div>

      <button class="submit-btn"
              type="submit">

        NẠP THẺ

      </button>

    </form>

  </div>

  <!-- ========================= -->
  <!-- QR CODE -->
  <!-- ========================= -->

  <div class="box qr-box">

    <h2>
      💳 NẠP QUA QR CODE
    </h2>

    <!-- THAY LINK ẢNH QR TẠI ĐÂY -->

    <img src="https://i.imgur.com/2DhmtJ4.png">

    <div class="note">

      Quét mã QR để chuyển khoản.
      <br>
      Nội dung chuyển khoản:
      <br>
      <b>NAPTIEN_USERNAME</b>

    </div>

  </div>

  <!-- ========================= -->
  <!-- THẺ NGÂN HÀNG -->
  <!-- ========================= -->

  <div class="box">

    <h2>
      🏦 THẺ NGÂN HÀNG
    </h2>

    <form>

      <div class="form-group">

        <label>
          Số thẻ
        </label>

        <input type="text"
               placeholder="Nhập số thẻ ngân hàng">

      </div>

      <div class="form-group">

        <label>
          Tên chủ thẻ
        </label>

        <input type="text"
               placeholder="Nhập tên chủ thẻ">

      </div>

      <div class="form-group">

        <label>
          Số CCCD
        </label>

        <input type="text"
               placeholder="Nhập số CCCD">

      </div>

      <button class="submit-btn"
              type="submit">

        XÁC NHẬN

      </button>

    </form>

  </div>

</div>

<div class="footer">

  © 2026 SHOP ACC GAME - JSP Servlet + MySQL

</div>

</body>

</html>

