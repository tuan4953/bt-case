<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.GameAccount" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");

    List<GameAccount> list =
            (List<GameAccount>) request.getAttribute("list");

    String keyword = request.getParameter("keyword");

    if(keyword == null){
        keyword = "";
    }

    int pageSize = 16;
    int pageIndex = 1;

    if(request.getParameter("page") != null){

        pageIndex =
                Integer.parseInt(
                        request.getParameter("page")
                );
    }

    if(pageIndex < 1){
        pageIndex = 1;
    }

    String message =
            (String) session.getAttribute("message");

    List<GameAccount> availableList =
            new ArrayList<>();

    if(list != null){

        for(GameAccount g : list){

            if(!"SOLD".equals(g.getStatus())){

                availableList.add(g);
            }
        }
    }

    int total = availableList.size();

    int totalPage =
            (int)Math.ceil(
                    total / (double) pageSize
            );

    if(totalPage < 1){
        totalPage = 1;
    }

    if(pageIndex > totalPage){
        pageIndex = totalPage;
    }

    int start =
            (pageIndex - 1) * pageSize;

    int end =
            Math.min(start + pageSize, total);

    List<GameAccount> pageList = null;

    if(start < total){

        pageList =
                availableList.subList(start, end);
    }
%>

<html>

<head>

    <title>SHOP ACC GAME</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            font-family:Arial;
            background:
                    linear-gradient(rgba(0,0,0,0.75),
                    rgba(0,0,0,0.85)),
                    url('https://img.thuthuatphanmem.vn/uploads/2018/09/27/anh-nen-4k-cho-desktop_105907396.jpg');

            background-size:cover;
            background-attachment:fixed;
            color:white;
        }

        /* ================= HEADER ================= */

        .header{

            position:sticky;
            top:0;
            z-index:9999;

            display:flex;
            justify-content:space-between;
            align-items:center;

            padding:15px 40px;

            background:rgba(0,0,0,0.6);

            backdrop-filter:blur(10px);

            border-bottom:1px solid rgba(255,215,0,0.3);
        }

        .logo{
            font-size:30px;
            font-weight:bold;
            color:gold;
            text-shadow:0 0 10px gold;
        }

        .menu{
            display:flex;
            align-items:center;
            gap:12px;
        }

        .menu a{
            text-decoration:none;
            color:white;
            padding:10px 18px;
            border-radius:10px;
            transition:0.3s;
            font-weight:bold;
            background:rgba(255,255,255,0.08);
        }

        .menu a:hover{
            background:gold;
            color:black;
            transform:translateY(-2px);
        }

        .balance-box{
            background:#111;
            border:1px solid gold;
            padding:10px 18px;
            border-radius:10px;
            color:gold;
            font-weight:bold;
        }

        /* ================= TITLE ================= */

        .main-title{
            text-align:center;
            margin-top:40px;
        }

        .main-title h1{
            font-size:60px;
            color:gold;
            text-shadow:0 0 20px gold;
        }

        .main-title p{
            margin-top:10px;
            color:#ddd;
            font-size:18px;
        }

        /* ================= SEARCH ================= */

        .search-box{

            width:500px;
            margin:35px auto;

            display:flex;

            background:rgba(255,255,255,0.08);

            border-radius:15px;

            overflow:hidden;

            border:1px solid rgba(255,215,0,0.3);
        }

        .search-box input{

            flex:1;
            padding:15px;

            border:none;
            outline:none;

            background:transparent;

            color:white;

            font-size:15px;
        }

        .search-box button{

            width:120px;

            border:none;

            background:gold;

            color:black;

            font-weight:bold;

            cursor:pointer;
        }

        /* ================= SUCCESS ================= */

        .success-box{

            width:500px;
            margin:20px auto;

            background:#00aa00;

            padding:15px;

            border-radius:12px;

            text-align:center;

            font-weight:bold;
        }

        /* ================= PRODUCTS ================= */

        .container-products{

            width:95%;
            margin:auto;

            display:grid;

            grid-template-columns:repeat(4,1fr);

            gap:25px;

            padding:30px 0;
        }

        .card-product{

            background:rgba(20,20,20,0.95);

            border:2px solid gold;

            border-radius:18px;

            overflow:hidden;

            transition:0.35s;

            box-shadow:0 0 15px rgba(0,0,0,0.5);
        }

        .card-product:hover{

            transform:translateY(-8px) scale(1.02);

            box-shadow:0 0 25px gold;
        }

        .card-product img{

            width:100%;
            height:240px;

            object-fit:cover;
        }

        .product-title{

            background:#8b0000;

            padding:14px;

            text-align:center;

            font-size:20px;

            font-weight:bold;
        }

        .product-info{

            padding:18px;

            line-height:32px;

            font-size:15px;
        }

        .product-price{

            color:gold;

            font-size:28px;

            font-weight:bold;

            text-align:center;

            margin-bottom:15px;
        }

        .product-buttons{

            padding:18px;

            display:flex;

            justify-content:center;

            gap:10px;

            flex-wrap:wrap;
        }

        .product-buttons a,
        .product-buttons button{

            border:none;

            padding:10px 15px;

            border-radius:10px;

            font-size:13px;

            font-weight:bold;

            cursor:pointer;

            text-decoration:none;

            transition:0.3s;
        }

        .btn-cart{
            background:#00a651;
            color:white;
        }

        .btn-buy{
            background:#007bff;
            color:white;
        }

        .btn-edit{
            background:#ffc107;
            color:black;
        }

        .btn-delete{
            background:#8b0000;
            color:white;
        }

        .product-buttons a:hover,
        .product-buttons button:hover{

            transform:translateY(-2px);
            opacity:0.9;
        }

        /* ================= PAGINATION ================= */

        .pagination-box{

            display:flex;

            justify-content:center;

            gap:10px;

            margin:40px 0;
        }

        .page-btn{

            padding:10px 16px;

            border-radius:10px;

            text-decoration:none;

            background:#111;

            color:white;

            border:1px solid gold;

            transition:0.3s;
        }

        .page-btn:hover,
        .active-page{

            background:gold;
            color:black;
        }

        /* ================= FOOTER ================= */

        .footer{

            margin-top:50px;

            padding:35px;

            background:#0a0a0a;

            text-align:center;

            border-top:2px solid gold;
        }

        .footer h2{
            color:gold;
            margin-bottom:10px;
        }

        .footer p{
            color:#ccc;
            margin:5px 0;
        }

    </style>

</head>

<body>

<!-- HEADER -->

<div class="header">

    <div class="logo">

        🎮 GAME STORE

    </div>

    <div class="menu">

        <a href="home">HOME</a>

        <a href="products">SHOP</a>

        <%
            if(user != null &&
                    !"ADMIN".equals(user.getRole())){
        %>

        <a href="cart">
            🛒 GIỎ HÀNG
        </a>

        <a href="purchase-history">
            📜 BILL
        </a>

        <a href="deposit.jsp">
            💰 NẠP TIỀN
        </a>

        <div class="balance-box">

            💵
            <%= (int)user.getBalance() %>đ

        </div>

        <%
            }
        %>

        <%
            if(user != null &&
                    "ADMIN".equals(user.getRole())){
        %>

        <a href="add-product.jsp">
            ➕ THÊM ACC
        </a>

        <%
            }
        %>

        <a href="logout">
            🚪 LOGOUT
        </a>

    </div>

</div>

<!-- TITLE -->

<div class="main-title">

    <h1>SHOP ACC GAME</h1>

    <p>
        Kho acc game chất lượng - giá rẻ - tự động
    </p>

</div>

<!-- SEARCH -->

<form action="products"
      method="get">

    <div class="search-box">

        <input type="text"
               name="keyword"
               placeholder="🔍 Tìm kiếm acc game..."
               value="<%= keyword %>">

        <button type="submit">

            SEARCH

        </button>

    </div>

</form>

<!-- MESSAGE -->

<%
    if(message != null){
%>

<div class="success-box">

    <%= message %>

</div>

<%
        session.removeAttribute("message");
    }
%>

<!-- PRODUCTS -->

<div class="container-products">

    <%
        if(pageList != null &&
                !pageList.isEmpty()){

            for(GameAccount g : pageList){

                String img =
                        (g.getImage() != null &&
                                !g.getImage().isEmpty())
                                ? g.getImage()
                                : "default.jpg";
    %>

    <div class="card-product">

        <img src="<%= request.getContextPath() %>/image?name=<%= img %>">

        <div class="product-title">

            <%= g.getGameName() %>

        </div>

        <div class="product-info">

            🎮 Acc:
            <%= g.getAccountName() %>

            <br>

            📌 Trạng thái:
            <%= g.getStatus() %>

        </div>

        <div class="product-price">

            <%= (int)g.getPrice() %>đ

        </div>

        <div class="product-buttons">

            <%
                if(user != null &&
                        "ADMIN".equals(user.getRole())){
            %>

            <a class="btn-edit"
               href="edit-product?id=<%= g.getId() %>">

                SỬA

            </a>

            <button class="btn-delete"
                    onclick="openDelete(<%= g.getId() %>)">

                XOÁ

            </button>

            <%
            } else if(user != null){
            %>

            <a class="btn-cart"
               href="add-to-cart?id=<%= g.getId() %>">

                🛒 GIỎ

            </a>

            <a class="btn-buy"
               href="buy-now?id=<%= g.getId() %>"
               onclick="return confirm('Xác nhận mua acc này?')">

                💳 MUA

            </a>

            <%
                }
            %>

        </div>

    </div>

    <%
            }
        }
    %>

</div>

<!-- PAGINATION -->

<div class="pagination-box">

    <%
        for(int i = 1; i <= totalPage; i++){
    %>

    <a class="page-btn <%= (i == pageIndex ? "active-page" : "") %>"
       href="products?page=<%= i %>&keyword=<%= keyword %>">

        <%= i %>

    </a>

    <%
        }
    %>

</div>

<!-- FOOTER -->

<div class="footer">

    <h2>🎮 GAME STORE</h2>

    <p>
        Hệ thống bán acc game tự động
    </p>

    <p>
        Hỗ trợ 24/7 - Uy tín - Nhanh chóng
    </p>

    <p>
        © 2026 Game Store
    </p>

</div>

<!-- CHAT BOX -->

<jsp:include page="chat-box.jsp"/>

<script>

    function openDelete(id){

        if(confirm("Bạn có chắc muốn xoá acc này?")){

            window.location =
                "delete-product?id=" + id;
        }
    }

</script>

</body>
</html>