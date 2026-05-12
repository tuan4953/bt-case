<%@ page import="model.GameAccount" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  GameAccount g = (GameAccount) request.getAttribute("game");

  if (g == null) {
    response.sendRedirect(request.getContextPath() + "/products");
    return;
  }
%>

<html>

<head>

  <title>Edit Product</title>

  <style>

    body{
      background:#b30021;
      font-family:Arial;
      color:white;
    }

    .box{
      width:550px;
      background:#8b0000;
      margin:50px auto;
      padding:30px;
      border-radius:15px;
      border:2px solid gold;
    }

    h2{
      text-align:center;
      color:gold;
      margin-bottom:25px;
    }

    input, select{
      width:100%;
      padding:15px;
      margin-top:15px;
      border:none;
      border-radius:8px;
      box-sizing:border-box;
      font-size:16px;
    }

    .preview{
      width:100%;
      height:280px;
      object-fit:cover;
      border-radius:10px;
      margin-top:20px;
      border:2px solid gold;
    }

    .file-box{
      background:white;
      color:black;
      padding:15px;
      border-radius:10px;
      margin-top:20px;
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

  </style>

</head>
<jsp:include page="chat-box.jsp" />
<body>

<div class="box">

  <h2>SỬA SẢN PHẨM</h2>

  <form action="<%= request.getContextPath() %>/update-product"
        method="post"
        enctype="multipart/form-data">

    <input type="hidden"
           name="id"
           value="<%= g.getId() %>">

    <input type="text"
           name="gameName"
           value="<%= g.getGameName() %>"
           required>

    <input type="text"
           name="accountName"
           value="<%= g.getAccountName() %>"
           required>

    <input type="number"
           name="price"
           value="<%= g.getPrice() %>"
           min="0"
           required>

    <!-- FIX STATUS -->
    <select name="status" required>
      <option value="AVAILABLE" <%= "AVAILABLE".equals(g.getStatus()) ? "selected" : "" %>>AVAILABLE</option>
      <option value="SOLD" <%= "SOLD".equals(g.getStatus()) ? "selected" : "" %>>SOLD</option>
      <option value="PENDING" <%= "PENDING".equals(g.getStatus()) ? "selected" : "" %>>PENDING</option>
    </select>

    <!-- IMAGE -->
    <img class="preview"
         src="<%= g.getImage() != null ? g.getImage() : "https://via.placeholder.com/400" %>">

    <div class="file-box">

      <label>Chọn ảnh mới:</label>

      <input type="file"
             name="image"
             accept="image/*">

    </div>

    <button type="submit">
      UPDATE PRODUCT
    </button>

  </form>

</div>

</body>

</html>