<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>

<head>

    <title>Access Denied</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{

            height:100vh;

            display:flex;
            justify-content:center;
            align-items:center;

            background:
                    linear-gradient(rgba(0,0,0,0.8),
                    rgba(0,0,0,0.9)),
                    url('https://wallpapers.com/images/featured/gaming-background-rml9nn09bly3fnr2.jpg');

            background-size:cover;

            font-family:Arial;

            color:white;
        }

        .box{

            width:700px;

            background:rgba(0,0,0,0.75);

            border:2px solid orange;

            padding:60px;

            border-radius:25px;

            text-align:center;

            backdrop-filter:blur(10px);

            box-shadow:0 0 30px rgba(255,165,0,0.4);
        }

        h1{

            font-size:100px;

            color:orange;

            text-shadow:0 0 25px orange;
        }

        p{

            margin-top:20px;

            font-size:22px;

            color:#ddd;

            line-height:38px;
        }

        a{

            display:inline-block;

            margin-top:35px;

            padding:15px 40px;

            background:orange;

            color:black;

            text-decoration:none;

            border-radius:14px;

            font-weight:bold;

            transition:0.3s;
        }

        a:hover{

            transform:translateY(-3px);

            box-shadow:0 0 20px orange;
        }

    </style>

</head>

<body>

<div class="box">

    <h1>403</h1>

    <p>

        Bạn không có quyền truy cập trang này

        <br>

        Vui lòng đăng nhập đúng tài khoản

    </p>

    <a href="../products">

        QUAY LẠI SHOP

    </a>

</div>

</body>

</html>