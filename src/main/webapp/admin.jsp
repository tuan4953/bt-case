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

    <title>Admin Add Product</title>

    <style>

        body {
            background-image: url('https://img.thuthuatphanmem.vn/uploads/2018/09/27/anh-nen-4k-cho-desktop_105907396.jpg');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            font-family: Arial;
            color: white;
            margin: 0;
            padding: 0;
        }

        .box{
            width:500px;
            background:#8b0000;
            margin:40px auto;
            padding:30px;
            border:2px solid gold;
            border-radius:15px;
        }

        h2{
            text-align:center;
            color:gold;
            margin-bottom:30px;
        }

        input, select{
            width:100%;
            padding:15px;
            margin-top:15px;
            border:none;
            border-radius:8px;
            font-size:16px;
            box-sizing:border-box;
        }

        .file-box{
            background:white;
            color:black;
            padding:15px;
            border-radius:8px;
            margin-top:15px;
        }

        button{
            width:100%;
            padding:15px;
            margin-top:25px;
            background:gold;
            border:none;
            border-radius:10px;
            font-weight:bold;
            font-size:18px;
            cursor:pointer;
        }

        button:hover{
            background:#ffd700;
        }

        .back-btn{
            display:inline-block;
            margin-top:20px;
            background:#001f54;
            color:white;
            padding:12px 20px;
            text-decoration:none;
            border-radius:10px;
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

<div class="box">

    <h2>THÊM ACC GAME</h2>

    <form action="<%= request.getContextPath() %>/add-product"
          method="post"
          enctype="multipart/form-data">

        <input type="text"
               name="gameName"
               placeholder="Tên game"
               required>

        <input type="text"
               name="accountName"
               placeholder="Tên acc"
               required>

        <input type="number"
               name="price"
               placeholder="Giá tiền"
               min="0"
               required>

        <!-- FIX STATUS -->
        <select name="status" required>
            <option value="AVAILABLE">AVAILABLE</option>
            <option value="SOLD">SOLD</option>
            <option value="PENDING">PENDING</option>
        </select>

        <!-- OPTIONAL CATEGORY -->
        <input type="text"
               name="categoryId"
               placeholder="Category ID (optional)">

        <div class="file-box">

            Chọn ảnh sản phẩm:

            <br><br>

            <input type="file"
                   name="image"
                   accept="image/*"
                   required>

        </div>

        <button type="submit">
            ADD ACCOUNT
        </button>

    </form>

    <a class="back-btn"
       href="<%= request.getContextPath() %>/products">

        ← QUAY LẠI SHOP

    </a>

</div>

</body>
</html>