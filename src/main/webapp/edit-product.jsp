<%@ page import="model.GameAccount" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  GameAccount g =
          (GameAccount)
                  request.getAttribute("game");

  if(g == null){

    response.sendRedirect(
            request.getContextPath()
                    + "/products"
    );

    return;
  }

  String img =
          (g.getImage() != null
                  &&
                  !g.getImage().isEmpty())

                  ?

                  g.getImage()

                  :

                  "default.jpg";

  String message =
          (String) session.getAttribute("message");

  String error =
          (String) session.getAttribute("error");
%>

<!DOCTYPE html>
<html>

<head>

  <title>Edit Product</title>

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

    /* ================= BOX ================= */

    .box{

      width:600px;

      background:rgba(20,20,20,0.92);

      margin:50px auto;

      padding:35px;

      border-radius:20px;

      border:2px solid gold;

      backdrop-filter:blur(10px);

      box-shadow:
              0 0 25px rgba(255,215,0,0.2);
    }

    /* ================= TITLE ================= */

    h2{

      text-align:center;

      color:gold;

      margin-bottom:30px;

      font-size:38px;

      text-shadow:0 0 10px gold;
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

    /* ================= INPUT ================= */

    input,
    select{

      width:100%;

      padding:15px;

      margin-top:15px;

      border:none;

      border-radius:12px;

      box-sizing:border-box;

      font-size:16px;

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

    /* ================= PREVIEW ================= */

    .preview{

      width:100%;

      height:320px;

      object-fit:cover;

      border-radius:15px;

      margin-top:20px;

      border:2px solid gold;

      background:black;
    }

    /* ================= FILE BOX ================= */

    .file-box{

      background:rgba(255,255,255,0.08);

      color:white;

      padding:18px;

      border-radius:12px;

      margin-top:20px;

      border:1px solid rgba(255,215,0,0.3);
    }

    /* ================= BUTTON ================= */

    button{

      width:100%;

      padding:16px;

      margin-top:28px;

      background:gold;

      border:none;

      border-radius:12px;

      font-weight:bold;

      font-size:18px;

      cursor:pointer;

      transition:0.3s;
    }

    button:hover{

      transform:translateY(-2px);

      box-shadow:0 0 20px gold;
    }

    /* ================= BACK ================= */

    .back-btn{

      display:block;

      margin-top:22px;

      text-align:center;

      background:#001f54;

      color:white;

      padding:14px;

      text-decoration:none;

      border-radius:12px;

      transition:0.3s;
    }

    .back-btn:hover{

      background:#003b99;

      box-shadow:0 0 15px #007bff;
    }

    /* ================= RESPONSIVE ================= */

    @media(max-width:700px){

      .box{

        width:95%;
      }
    }

  </style>

</head>

<body>

<div class="box">

  <h2>

    SỬA SẢN PHẨM

  </h2>

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

  <!-- FORM -->

  <form action="<%= request.getContextPath() %>/update-product"
        method="post"
        enctype="multipart/form-data">

    <!-- ID -->

    <input type="hidden"
           name="id"
           value="<%= g.getId() %>">

    <!-- GAME -->

    <input type="text"
           name="gameName"
           value="<%= g.getGameName() %>"
           required>

    <!-- ACCOUNT -->

    <input type="text"
           name="accountName"
           value="<%= g.getAccountName() %>"
           required>

    <!-- PRICE -->

    <input type="number"
           name="price"
           value="<%= g.getPrice() %>"
           min="0"
           required>

    <!-- STATUS -->

    <select name="status"
            required>

      <option value="AVAILABLE"
              <%= "AVAILABLE".equals(g.getStatus())
                      ? "selected"
                      : "" %>>

        AVAILABLE

      </option>

      <option value="PENDING"
              <%= "PENDING".equals(g.getStatus())
                      ? "selected"
                      : "" %>>

        PENDING

      </option>

      <option value="SOLD"
              <%= "SOLD".equals(g.getStatus())
                      ? "selected"
                      : "" %>>

        SOLD

      </option>

    </select>

    <!-- MAIN IMAGE PREVIEW -->

    <img id="preview"
         class="preview"
         src="<%= request.getContextPath() %>/image?name=<%= img %>">

    <!-- MAIN IMAGE -->

    <div class="file-box">

      <label>

        Chọn ảnh chính mới:

      </label>

      <br><br>

      <input type="file"
             name="image"
             accept="image/*">

    </div>

    <!-- SUB IMAGES -->

    <div class="file-box">

      <label>

        Thêm ảnh phụ:

      </label>

      <br><br>

      <input type="file"
             name="subImages"
             accept="image/*"
             multiple>

    </div>

    <!-- BUTTON -->

    <button type="submit"
            onclick="this.disabled=true;this.form.submit();">

      UPDATE PRODUCT

    </button>

  </form>

  <!-- BACK -->

  <a class="back-btn"
     href="<%= request.getContextPath() %>/products">

    ← QUAY LẠI SHOP

  </a>

</div>

<!-- CHAT -->

<jsp:include page="chat-box.jsp"/>

<script>

  // =========================
  // PREVIEW MAIN IMAGE
  // =========================

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