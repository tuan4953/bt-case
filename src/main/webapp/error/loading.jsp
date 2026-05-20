<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <title>Loading</title>

    <style>

        body{

            margin:0;

            background:#0f0f0f;

            display:flex;
            justify-content:center;
            align-items:center;

            height:100vh;
        }

        .loader{

            width:100px;
            height:100px;

            border:10px solid #333;
            border-top:10px solid gold;

            border-radius:50%;

            animation:spin 1s linear infinite;
        }
        @keyframes spin{

            100%{
                transform:rotate(360deg);
            }
        }

    </style>

</head>
<body>

<div class="loader"></div>

</body>
</html>