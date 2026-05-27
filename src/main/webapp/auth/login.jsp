<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }

    String error = request.getParameter("error");
%>

<html>
<head>
    <title>Login</title>

    <style>
        body {
            background-image: url('https://img.thuthuatphanmem.vn/uploads/2018/09/27/anh-nen-4k-cho-desktop_105907396.jpg');
            background-size: cover;
            background-attachment: fixed;
            background-position: center;
            font-family: Arial;
            margin: 0;
            height: 100vh;
            overflow: hidden;
        }

        /* vùng hover kích hoạt login */
        .container {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* BOX LOGIN */
        .box {
            width: 300px;
            padding: 40px;
            border-radius: 18px;
            border: 1px solid rgba(255, 215, 0, 0.6);
            background: rgba(0, 0, 0, 0.25);
            backdrop-filter: blur(10px);

            /* ẨN BAN ĐẦU */
            opacity: 0;
            transform: translateY(40px) scale(0.95);
            transition: all 0.5s ease;

            box-shadow: 0 0 0 rgba(0,0,0,0);
        }

        /* CHỈ HIỆN KHI HOVER */
        .container:hover .box {
            opacity: 1;
            transform: translateY(0) scale(1);
            box-shadow:
                    0 0 25px rgba(255, 215, 0, 0.6),
                    0 0 60px rgba(0, 0, 0, 0.8);
        }

        h2 {
            text-align: center;
            color: gold;
            margin-bottom: 25px;
            font-size: 34px;
            letter-spacing: 2px;
        }

        /* INPUT GLASS EFFECT */
        input {
            width: 100%;
            padding: 14px;
            margin-top: 15px;
            border-radius: 10px;
            border: 1px solid rgba(255, 215, 0, 0.6);
            font-size: 15px;
            box-sizing: border-box;

            background: rgba(255, 255, 255, 0.1);
            color: white;

            outline: none;
            backdrop-filter: blur(6px);
            transition: 0.3s;
        }

        input:focus {
            border: 1px solid gold;
            box-shadow: 0 0 10px gold;
            background: rgba(255, 255, 255, 0.15);
        }

        button {
            width: 100%;
            padding: 14px;
            margin-top: 20px;
            background: gold;
            border: none;
            border-radius: 10px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px gold;
        }

        .back-btn {
            display: block;
            text-align: center;
            margin-top: 18px;
            color: white;
            text-decoration: none;
            background: rgba(0, 0, 0, 0.4);
            padding: 12px;
            border-radius: 10px;
            transition: 0.3s;
        }

        .back-btn:hover {
            background: rgba(255, 215, 0, 0.2);
            box-shadow: 0 0 10px gold;
        }

        .error {
            background: rgba(255,0,0,0.7);
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 10px;
            text-align: center;
        }

        /* gợi ý "hover để hiện login" */
        .hint {
            position: absolute;
            color: white;
            opacity: 0.6;
            font-size: 14px;
        }

        .container:hover .hint {
            display: none;
        }

    </style>
</head>

<body>

<div class="container">

    <div class="hint">
        Di chuột vào giữa màn hình để hiện login
    </div>

    <div class="box">

        <h2>LOGIN</h2>

        <%
            if (error != null) {
        %>
        <div class="error"><%= error %></div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/login" method="post">

            <input type="text" name="username" placeholder="Username" required>

            <input type="password" name="password" placeholder="Password" required>

            <button type="submit">LOGIN</button>

        </form>

        <a class="back-btn" href="<%= request.getContextPath() %>/index.jsp">
            ← Quay lại trang chủ
        </a>

    </div>

</div>

</body>
</html>