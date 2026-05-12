<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>

  <title>Add Product</title>

  <style>

    body{
      background:#111;
      font-family:Arial;
      color:white;
      padding:40px;
    }

    .container{
      width:500px;
      margin:auto;
      background:#1c1c1c;
      padding:40px;
      border:2px solid gold;
      border-radius:15px;
    }

    h1{
      text-align:center;
      color:gold;
      margin-bottom:30px;
    }

    input, select{
      width:100%;
      padding:15px;
      margin-top:10px;
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
      margin-top:20px;
    }

    button{
      width:100%;
      padding:15px;
      margin-top:25px;
      border:none;
      background:#8b0000;
      color:white;
      font-size:18px;
      font-weight:bold;
      border-radius:10px;
      cursor:pointer;
    }

    button:hover{
      background:#c40000;
    }

    .back-btn{
      display:inline-block;
      margin-top:20px;
      text-decoration:none;
      color:white;
      background:#001f54;
      padding:12px 20px;
      border-radius:10px;
    }

    /* SEARCH BAR */
    .search-box{
      margin-bottom:20px;
    }

    .search-box input{
      width:70%;
      display:inline-block;
    }

    .search-box button{
      width:28%;
      display:inline-block;
      margin-top:10px;
      background:gold;
      color:black;
    }

  </style>

</head>
<jsp:include page="chat-box.jsp" />
<body>

<div class="container">

  <h1>THÊM ACC GAME</h1>

  <!-- SEARCH UI -->
  <form class="search-box" action="products" method="get">

    <input type="text"
           name="keyword"
           placeholder="Tìm theo tên acc...">

    <button type="submit">SEARCH</button>

  </form>

  <!-- ADD PRODUCT FORM -->
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
           required>

    <!-- FIX STATUS -->
    <select name="status" required>
      <option value="AVAILABLE">AVAILABLE</option>
      <option value="SOLD">SOLD</option>
      <option value="PENDING">PENDING</option>
    </select>

    <!-- OPTIONAL CATEGORY (chuẩn DB bạn có) -->
    <input type="text"
           name="categoryId"
           placeholder="ID danh mục (optional)">

    <div class="file-box">

      <label>Chọn ảnh sản phẩm:</label>

      <input type="file"
             name="image"
             accept="image/*"
             required>

    </div>

    <button type="submit">
      THÊM SẢN PHẨM
    </button>

  </form>

  <a class="back-btn"
     href="products">
    ← Quay lại shop
  </a>

</div>

</body>
</html>