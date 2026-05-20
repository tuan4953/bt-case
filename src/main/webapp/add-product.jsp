<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user =
            (User) session.getAttribute("user");

    if(user == null ||
            !"ADMIN".equalsIgnoreCase(user.getRole())){

        response.sendRedirect(
                request.getContextPath()
                        + "/login.jsp"
        );

        return;
    }

    String message =
            (String) session.getAttribute("message");

    String error =
            (String) session.getAttribute("error");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Add Product</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{

            background:
                    linear-gradient(
                            rgba(0,0,0,0.7),
                            rgba(0,0,0,0.85)
                    ),
                    url('https://img.thuthuatphanmem.vn/uploads/2018/09/27/anh-nen-4k-cho-desktop_105907396.jpg');

            background-size:cover;

            background-attachment:fixed;

            background-position:center;

            font-family:Arial;

            color:white;

            min-height:100vh;

            padding:40px 0;
        }

        /* ================= CONTAINER ================= */

        .container{

            width:550px;

            margin:auto;

            background:rgba(20,20,20,0.92);

            padding:40px;

            border:2px solid gold;

            border-radius:20px;

            backdrop-filter:blur(10px);

            box-shadow:
                    0 0 25px rgba(255,215,0,0.2);
        }

        /* ================= TITLE ================= */

        h1{

            text-align:center;

            color:gold;

            margin-bottom:30px;

            font-size:38px;

            text-shadow:0 0 12px gold;
        }

        /* ================= MESSAGE ================= */

        .success{

            background:#00aa00;

            padding:15px;

            border-radius:10px;

            margin-bottom:20px;

            text-align:center;

            font-weight:bold;
        }

        .error{

            background:#8b0000;

            padding:15px;

            border-radius:10px;

            margin-bottom:20px;

            text-align:center;

            font-weight:bold;
        }

        /* ================= SEARCH ================= */

        .search-box{

            display:flex;

            gap:10px;

            margin-bottom:25px;
        }

        .search-box input{

            flex:1;
        }

        .search-box button{

            width:120px;

            margin-top:0;

            background:gold;

            color:black;
        }

        /* ================= INPUT ================= */

        input,
        select{

            width:100%;

            padding:15px;

            margin-top:15px;

            border:none;

            border-radius:12px;

            font-size:16px;

            box-sizing:border-box;

            background:rgba(255,255,255,0.08);

            color:white;

            border:1px solid rgba(255,215,0,0.3);

            outline:none;

            transition:0.3s;
        }

        input:focus,
        select:focus{

            border-color:gold;

            box-shadow:0 0 10px gold;
        }

        option{
            color:black;
        }

        /* ================= FILE BOX ================= */

        .file-box{

            background:rgba(255,255,255,0.08);

            padding:18px;

            border-radius:12px;

            margin-top:20px;

            border:1px solid rgba(255,215,0,0.3);
        }

        /* ================= PREVIEW ================= */

        .preview{

            width:100%;

            height:280px;

            object-fit:cover;

            border-radius:15px;

            margin-top:20px;

            border:2px solid gold;

            background:black;
        }

        /* ================= BUTTON ================= */

        button{

            width:100%;

            padding:15px;

            margin-top:25px;

            border:none;

            background:#8b0000;

            color:white;

            font-size:18px;

            font-weight:bold;

            border-radius:12px;

            cursor:pointer;

            transition:0.3s;
        }

        button:hover{

            background:#c40000;

            transform:translateY(-2px);

            box-shadow:0 0 15px red;
        }

        /* ================= BACK ================= */

        .back-btn{

            display:block;

            margin-top:22px;

            text-decoration:none;

            color:white;

            background:#001f54;

            padding:14px;

            border-radius:12px;

            text-align:center;

            transition:0.3s;
        }

        .back-btn:hover{

            background:#003b99;

            box-shadow:0 0 15px #007bff;
        }

        /* ================= RESPONSIVE ================= */

        @media(max-width:650px){

            .container{

                width:95%;
            }

            .search-box{

                flex-direction:column;
            }

            .search-box button{

                width:100%;
            }
        }

    </style>

</head>

<body>
<div class="container">

    <h1>

        THÊM ACC GAME

    </h1>

    <!-- SUCCESS -->

    <%
        if(message != null){
    %>

    <div class="success">

        <%= message %>

    </div>

    <%
            session.removeAttribute("message");
        }
    %>

    <!-- ERROR -->

    <%
        if(error != null){
    %>

    <div class="error">

        <%= error %>

    </div>

    <%
            session.removeAttribute("error");
        }
    %>

    <!-- SEARCH -->

    <form class="search-box"
          action="products"
          method="get">

        <input type="text"
               name="keyword"
               placeholder="Tìm theo tên acc...">

        <button type="submit">

            SEARCH

        </button>

    </form>

    <!-- ADD PRODUCT -->

    <form action="add-product"
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
               placeholder="Giá"
               min="0"
               required>

        <!-- STATUS -->

        <select name="status"
                required>

            <option value="AVAILABLE">

                AVAILABLE

            </option>

            <option value="PENDING">

                PENDING

            </option>

            <option value="SOLD">

                SOLD

            </option>

        </select>

        <!-- CATEGORY -->

        <input type="text"
               name="categoryId"
               placeholder="ID danh mục (optional)">

        <!-- IMAGE -->

        <div class="file-box">

            <label>

                Chọn ảnh sản phẩm:

            </label>

            <br><br>

            <input type="file"
                   name="image"
                   accept="image/*"
                   required>

        </div>

        <!-- PREVIEW -->

        <img id="preview"
             class="preview"
             src="https://via.placeholder.com/500x300?text=PREVIEW">

        <!-- BUTTON -->

        <button type="submit"
                onclick="this.disabled=true;this.form.submit();">

            THÊM SẢN PHẨM

        </button>

    </form>

    <!-- BACK -->

    <a class="back-btn"
       href="products">

        ← Quay lại shop

    </a>

</div>

<!-- CHAT -->

<jsp:include page="chat-box.jsp"/>

<script>

    const input =
        document.querySelector(
            'input[name="image"]'
        );

    const preview =
        document.getElementById(
            "preview"
        );

    input.addEventListener(
        "change",
        function(){

            const file =
                this.files[0];

            if(file){

                preview.src =
                    URL.createObjectURL(file);
            }
        }
    );

</script>
</body>
</html>