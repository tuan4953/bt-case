<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
%>

<html>

<head>

    <title>Home</title>

    <style>

        body{
            background-image: url('https://img.thuthuatphanmem.vn/uploads/2018/09/27/anh-nen-4k-cho-desktop_105907396.jpg');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            font-family: Arial;
            margin: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        /* overlay làm nền đỡ chói */
        body::before{
            content:"";
            position: fixed;
            top:0;
            left:0;
            width:100%;
            height:100%;
            background: rgba(0,0,0,0.55);
            z-index:0;
        }

        .container{
            width: 750px;
            text-align: center;
            z-index:1;
            padding: 40px;
            border-radius: 20px;

            background: rgba(255,255,255,0.08);
            backdrop-filter: blur(12px);

            box-shadow:
                    0 0 25px rgba(0,0,0,0.6),
                    0 0 40px rgba(255,215,0,0.15);
        }

        h1{
            font-size: 58px;
            color: gold;
            margin-bottom: 10px;
            letter-spacing: 3px;
            text-shadow: 0 0 20px rgba(255,215,0,0.6);
        }

        p{
            font-size: 20px;
            opacity: 0.85;
            margin-bottom: 40px;
        }

        .menu{
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .btn{
            display: inline-block;
            padding: 15px 30px;
            text-decoration: none;
            font-size: 18px;
            border-radius: 12px;
            font-weight: bold;
            transition: 0.3s ease;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.2);
        }

        /* hiệu ứng hover ánh sáng chạy */
        .btn::before{
            content:"";
            position:absolute;
            top:0;
            left:-100%;
            width:100%;
            height:100%;
            background: rgba(255,255,255,0.15);
            transition: 0.4s;
        }

        .btn:hover::before{
            left:0;
        }

        .btn:hover{
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 0 20px rgba(255,255,255,0.2);
        }

        .admin-btn{
            background: linear-gradient(135deg, #001f54, #003b9a);
            color: white;
        }

        .register-btn{
            background: linear-gradient(135deg, gold, #ffcc00);
            color: black;
        }

        .shop-btn{
            background: linear-gradient(135deg, #8b0000, #c40000);
            color: white;
        }

        .logout-btn{
            background: rgba(50,50,50,0.8);
            color: white;
        }

        .footer{
            margin-top: 40px;
            font-size: 16px;
            opacity: 0.7;
        }

    </style>

</head>
<jsp:include page="chat-box.jsp" />
<body>

<div class="container">

    <h1>SHOP ACC GAME</h1>

    <p>Hệ thống mua bán acc game tự động - nhanh, gọn, an toàn</p>

    <div class="menu">

        <%
            if (user == null) {
        %>

        <a class="btn admin-btn"
           href="<%= request.getContextPath() %>/login.jsp">
            LOGIN
        </a>

        <a class="btn register-btn"
           href="<%= request.getContextPath() %>/register.jsp">
            ĐĂNG KÝ
        </a>

        <%
        } else {
        %>

        <a class="btn shop-btn"
           href="<%= request.getContextPath() %>/products">
            XEM SHOP
        </a>

        <%
            if ("ADMIN".equals(user.getRole())) {
        %>

        <a class="btn admin-btn"
           href="<%= request.getContextPath() %>/admin.jsp">
            ADMIN PANEL
        </a>

        <%
            }
        %>

        <a class="btn logout-btn"
           href="<%= request.getContextPath() %>/logout">
            LOGOUT
        </a>

        <%
            }
        %>

    </div>

    <div class="footer">
        © 2026 GAME SHOP SYSTEM
    </div>

</div>

</body>
</html>