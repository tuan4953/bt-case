<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <title>404 - Không tìm thấy trang</title>

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
                    url('https://images7.alphacoders.com/133/1338706.png');

            background-size:cover;

            font-family:Arial;

            color:white;
        }
        .box{

             width:700px;

             background:rgba(0,0,0,0.7);

             border:2px solid red;

             padding:60px;

             border-radius:25px;

             text-align:center;

             backdrop-filter:blur(10px);

             box-shadow:0 0 30px rgba(255,0,0,0.4);
         }

        h1{

            font-size:120px;

            color:red;

            text-shadow:0 0 25px red;
        }

        p{

            margin-top:20px;

            font-size:22px;

            color:#ddd;
        }
        a{

            display:inline-block;

            margin-top:35px;

            padding:15px 40px;

            background:gold;

            color:black;

            text-decoration:none;

            border-radius:14px;

            font-weight:bold;

            transition:0.3s;
        }

        a:hover{

            transform:translateY(-3px);

            box-shadow:0 0 20px gold;
        }

    </style>

</head>
<body>
<div class="box">

    <h1>404</h1>

    <p>
        Trang bạn tìm kiếm không tồn tại
    </p>

    <a href="../products">
        QUAY LẠI SHOP
    </a>

</div>

</body>
</html>