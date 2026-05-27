<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");

    // nếu đã login → không cho register nữa
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/products");
        return;
    }

    String error = request.getParameter("error");
%>

<html>

<head>

    <title>Register</title>

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

        .container{
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
        }

        .box{
            width:400px;
            background:#8b0000;
            padding:40px;
            border-radius:15px;
            border:2px solid gold;
        }

        h2{
            text-align:center;
            color:gold;
            margin-bottom:30px;
            font-size:35px;
        }

        input{
            width:100%;
            padding:15px;
            margin-top:15px;
            border:none;
            border-radius:8px;
            font-size:16px;
            box-sizing:border-box;
        }

        button{
            width:100%;
            padding:15px;
            margin-top:25px;
            background:gold;
            border:none;
            border-radius:10px;
            font-size:18px;
            font-weight:bold;
            cursor:pointer;
        }

        button:hover{
            background:#ffd700;
        }

        .back-btn{
            display:block;
            text-align:center;
            margin-top:20px;
            color:white;
            text-decoration:none;
            background:#001f54;
            padding:12px;
            border-radius:10px;
        }

        .error{
            background:red;
            padding:10px;
            border-radius:8px;
            margin-bottom:10px;
            text-align:center;
        }

    </style>

</head>
<jsp:include page="/chat/chat-box.jsp"/>
<body>
<div class="container">

    <div class="box">

        <h2>ĐĂNG KÝ</h2>

        <!-- ERROR -->
        <%
            if (error != null) {
        %>

        <div class="error">
            <%= error %>
        </div>

        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/register"
              method="post">

            <input type="text"
                   name="username"
                   placeholder="Username"
                   required>

            <input type="password"
                   name="password"
                   placeholder="Password"
                   required>

            <input type="email"
                   name="email"
                   placeholder="Email"
                   required>

            <button type="submit">
                REGISTER
            </button>

        </form>

        <a class="back-btn"
           href="<%= request.getContextPath() %>/index.jsp">

            ← Quay lại trang chủ

        </a>

    </div>

</div>
</body>
</html>