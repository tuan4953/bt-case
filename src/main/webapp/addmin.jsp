<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  User user = (User) session.getAttribute("user");

  if (user == null || !"ADMIN".equals(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
  }
%>

<html>

<head>

  <title>Admin Panel</title>

  <style>

    body{
      background:#111;
      color:white;
      font-family:Arial;
      padding:30px;
    }

    h1{
      color:gold;
      text-align:center;
      margin-bottom:10px;
    }

    h2{
      text-align:center;
      margin-bottom:40px;
    }

    .menu{
      display:flex;
      justify-content:center;
      gap:30px;
      flex-wrap:wrap;
    }

    .card{
      background:#1c1c1c;
      padding:30px;
      width:280px;
      border:2px solid gold;
      border-radius:15px;
      text-align:center;
    }

    .card h2{
      color:gold;
      margin-bottom:20px;
    }

    .btn{
      display:inline-block;
      margin-top:20px;
      background:#8b0000;
      color:white;
      padding:12px 25px;
      text-decoration:none;
      border-radius:10px;
      font-weight:bold;
    }

    .btn:hover{
      background:#c40000;
    }

    .logout{
      position:absolute;
      top:20px;
      right:20px;
      background:#001f54;
      padding:10px 15px;
      border-radius:8px;
      color:white;
      text-decoration:none;
    }

  </style>

</head>
<jsp:include page="chat-box.jsp" />
<body>

<!-- FIX LOGOUT -->
<a class="logout"
   href="<%= request.getContextPath() %>/logout">

  LOGOUT

</a>

<h1>ADMIN PANEL</h1>

<h2>
  Xin chào Admin:
  <%= user.getUsername() %>
</h2>

<div class="menu">

  <div class="card">

    <h2>THÊM ACC GAME</h2>

    <p>Thêm sản phẩm mới vào shop</p>

    <a class="btn"
       href="<%= request.getContextPath() %>/add-product.jsp">

      VÀO

    </a>

  </div>

  <div class="card">

    <h2>QUẢN LÝ SHOP</h2>

    <p>Xem, sửa và xóa acc game</p>

    <a class="btn"
       href="<%= request.getContextPath() %>/products">

      VÀO

    </a>

  </div>

</div>

</body>
</html>