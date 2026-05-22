<%@ page import="java.util.*" %>
<%@ page import="model.GameAccount" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);

    User user=(User)session.getAttribute("user");

    List<GameAccount> list=
            (List<GameAccount>)request.getAttribute("list");

    String keyword=request.getParameter("keyword");

    if(keyword==null) keyword="";

    int pageSize=12;

    int pageIndex=1;

    if(request.getParameter("page")!=null){

        pageIndex=
                Integer.parseInt(
                        request.getParameter("page")
                );
    }

    if(pageIndex<1) pageIndex=1;

    String message=
            (String)session.getAttribute("message");

    String error=
            (String)session.getAttribute("error");

    List<GameAccount> availableList=
            new ArrayList<>();

    if(list!=null){

        for(GameAccount g:list){

            if(!"SOLD".equalsIgnoreCase(g.getStatus())
                    &&
                    !"DELETED".equalsIgnoreCase(g.getStatus())){

                availableList.add(g);
            }
        }
    }

    int total=availableList.size();

    int totalPage=
            (int)Math.ceil(total/(double)pageSize);

    if(totalPage<1) totalPage=1;

    if(pageIndex>totalPage){

        pageIndex=totalPage;
    }

    int start=(pageIndex-1)*pageSize;

    int end=
            Math.min(start+pageSize,total);

    List<GameAccount> pageList=null;

    if(start<total){

        pageList=
                availableList.subList(start,end);
    }
%>

<!DOCTYPE html>
<html>

<head>

    <title>GAME STORE</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700;900&family=Rajdhani:wght@400;600;700&display=swap" rel="stylesheet">

    <style>

        /* ===== RESET & BASE ===== */
        *, *::before, *::after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --gold:       #f5c518;
            --gold-dim:   #c9a00a;
            --gold-glow:  rgba(245,197,24,0.18);
            --red:        #e02020;
            --red-dark:   #a01010;
            --green:      #0dbe6c;
            --blue:       #1a6eff;
            --bg:         #080b10;
            --bg2:        #0e1219;
            --bg3:        #151c27;
            --surface:    rgba(255,255,255,0.04);
            --border:     rgba(255,255,255,0.07);
            --border-gold:rgba(245,197,24,0.22);
            --text:       #f0f0f0;
            --muted:      #8899aa;
            --font-display: 'Orbitron', sans-serif;
            --font-body:    'Rajdhani', sans-serif;
            --radius-sm:  8px;
            --radius-md:  14px;
            --radius-lg:  20px;
            --transition: 0.25s cubic-bezier(.4,0,.2,1);
        }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'Arial', sans-serif;
            background-color: var(--bg);
            background-image:
                    radial-gradient(ellipse 80% 50% at 50% -10%, rgba(245,197,24,0.08) 0%, transparent 60%),
                    url('https://images.unsplash.com/photo-1542751110-97427bbecf20?w=1400&q=60');
            background-size: cover;
            background-attachment: fixed;
            background-blend-mode: overlay;
            color: var(--text);
            min-height: 100vh;
        }

        a { text-decoration: none; color: inherit; }

        /* ===== TOAST ===== */
        #toastBox {
            position: fixed;
            top: 20px;
            right: 16px;
            z-index: 999999;
            display: flex;
            flex-direction: column;
            gap: 10px;
            pointer-events: none;
        }

        .toast {
            min-width: 280px;
            max-width: 340px;
            padding: 14px 18px;
            border-radius: var(--radius-md);
            color: white;
            font-family: var(--font-body);
            font-weight: 600;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: toastIn 0.4s ease, toastOut 0.4s ease 3.5s forwards;
            border: 1px solid rgba(255,255,255,0.1);
        }

        .toast-success {
            background: linear-gradient(135deg, #0a3d26, #0d5233);
            border-left: 4px solid var(--green);
        }

        .toast-error {
            background: linear-gradient(135deg, #3d0a0a, #521111);
            border-left: 4px solid var(--red);
        }

        @keyframes toastIn {
            from { opacity:0; transform: translateX(60px) scale(0.96); }
            to   { opacity:1; transform: translateX(0)    scale(1); }
        }

        @keyframes toastOut {
            to   { opacity:0; transform: translateX(60px) scale(0.94); }
        }

        /* ===== HEADER ===== */
        .header {
            position: sticky;
            top: 0;
            z-index: 9999;
            padding: 14px 16px;
            background: rgba(8,11,16,0.90);
            backdrop-filter: blur(18px) saturate(160%);
            -webkit-backdrop-filter: blur(18px) saturate(160%);
            border-bottom: 1px solid var(--border-gold);
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-family: var(--font-display);
            font-size: 20px;
            font-weight: 900;
            color: var(--gold);
            letter-spacing: 1px;
            text-shadow: 0 0 20px rgba(245,197,24,0.5);
            transition: var(--transition);
        }

        .logo:hover { opacity: 0.85; }

        .balance-box {
            padding: 8px 14px;
            border-radius: 30px;
            background: rgba(245,197,24,0.1);
            border: 1px solid var(--border-gold);
            color: var(--gold);
            font-family: var(--font-display);
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .menu {
            display: flex;
            align-items: center;
            gap: 6px;
            flex-wrap: wrap;
        }

        .menu a {
            padding: 8px 12px;
            border-radius: var(--radius-sm);
            font-size: 13px;
            font-weight: 700;
            color: var(--muted);
            background: var(--surface);
            border: 1px solid var(--border);
            transition: var(--transition);
            white-space: nowrap;
            letter-spacing: 0.3px;
        }

        .menu a:hover {
            color: var(--gold);
            border-color: var(--border-gold);
            background: var(--gold-glow);
        }

        /* ===== HERO ===== */
        .hero {
            text-align: center;
            padding: 40px 20px 20px;
            position: relative;
        }

        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(ellipse 60% 80% at 50% 100%, rgba(245,197,24,0.06) 0%, transparent 70%);
            pointer-events: none;
        }

        .hero h1 {
            font-family: var(--font-display);
            font-size: clamp(28px, 8vw, 58px);
            font-weight: 900;
            color: var(--gold);
            text-shadow: 0 0 30px rgba(245,197,24,0.4), 0 0 60px rgba(245,197,24,0.15);
            letter-spacing: 2px;
            line-height: 1.15;
        }

        .hero p {
            margin-top: 10px;
            color: var(--muted);
            font-size: 15px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .hero-tags {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 16px;
            flex-wrap: wrap;
        }

        .hero-tag {
            padding: 5px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.5px;
            border: 1px solid var(--border-gold);
            background: var(--gold-glow);
            color: var(--gold);
        }

        /* ===== SEARCH ===== */
        .search-wrap {
            padding: 0 16px;
            max-width: 560px;
            margin: 20px auto;
        }

        .search-box {
            display: flex;
            border-radius: var(--radius-md);
            overflow: hidden;
            background: var(--bg2);
            border: 1px solid var(--border-gold);
            transition: var(--transition);
        }

        .search-box:focus-within {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(245,197,24,0.12);
        }

        .search-box input {
            flex: 1;
            border: none;
            outline: none;
            background: transparent;
            padding: 14px 16px;
            color: var(--text);
            font-family: var(--font-body);
            font-size: 14px;
            font-weight: 600;
        }

        .search-box input::placeholder { color: var(--muted); }

        .search-box button {
            padding: 0 22px;
            border: none;
            background: var(--gold);
            color: #000;
            font-family: var(--font-display);
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
            cursor: pointer;
            transition: var(--transition);
        }

        .search-box button:hover { background: #ffd740; }

        /* ===== STATS BAR ===== */
        .stats-bar {
            display: flex;
            justify-content: center;
            gap: 6px;
            padding: 0 16px 20px;
            flex-wrap: wrap;
        }

        .stat-pill {
            padding: 6px 16px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 700;
            background: var(--bg3);
            border: 1px solid var(--border);
            color: var(--muted);
        }

        .stat-pill span { color: var(--gold); }

        /* ===== PRODUCTS GRID ===== */
        .container-products {
            width: 100%;
            padding: 0 12px 30px;
            display: grid;
            grid-template-columns: 1fr;
            gap: 14px;
        }

        /* ===== CARD ===== */
        .card-product {
            background: var(--bg2);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            overflow: hidden;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .card-product::before {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: var(--radius-lg);
            background: linear-gradient(135deg, rgba(245,197,24,0.04) 0%, transparent 50%);
            pointer-events: none;
            opacity: 0;
            transition: var(--transition);
        }

        .card-product:hover {
            border-color: rgba(245,197,24,0.5);
            transform: translateY(-4px);
            box-shadow:
                    0 12px 40px rgba(0,0,0,0.5),
                    0 0 0 1px rgba(245,197,24,0.15);
        }

        .card-product:hover::before { opacity: 1; }

        .card-img-wrap {
            position: relative;
            overflow: hidden;
            height: 200px;
        }

        .card-product img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .card-product:hover img { transform: scale(1.06); }

        .card-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            font-family: var(--font-display);
            letter-spacing: 0.5px;
            background: rgba(0,0,0,0.75);
            border: 1px solid var(--border-gold);
            color: var(--gold);
            backdrop-filter: blur(6px);
        }

        .card-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 80px;
            background: linear-gradient(to top, var(--bg2), transparent);
        }

        .product-title {
            padding: 12px 14px 8px;
            font-family: var(--font-display);
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 1px;
            color: var(--text);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .product-info {
            padding: 0 14px 10px;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .info-row {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            font-weight: 600;
            color: var(--muted);
        }

        .info-row .label {
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            color: var(--muted);
            min-width: 38px;
        }

        .info-row .value { color: var(--text); }

        .status-badge {
            display: inline-block;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.5px;
            background: rgba(13,190,108,0.12);
            color: var(--green);
            border: 1px solid rgba(13,190,108,0.3);
        }

        .divider {
            height: 1px;
            background: var(--border);
            margin: 6px 14px;
        }

        .product-price {
            text-align: center;
            font-family: var(--font-display);
            font-size: 26px;
            font-weight: 900;
            color: var(--gold);
            text-shadow: 0 0 15px rgba(245,197,24,0.3);
            padding: 4px 14px 10px;
            letter-spacing: 1px;
        }

        /* ===== BUTTONS ===== */
        .product-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            padding: 0 12px 12px;
        }

        .product-buttons a,
        .product-buttons button {
            border: none;
            padding: 11px 8px;
            border-radius: var(--radius-sm);
            font-family: var(--font-body);
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: var(--transition);
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        .product-buttons a:hover,
        .product-buttons button:hover {
            transform: translateY(-2px);
            filter: brightness(1.15);
        }

        .product-buttons a:active,
        .product-buttons button:active {
            transform: scale(0.97);
        }

        .btn-cart {
            background: rgba(13,190,108,0.15);
            color: #0dbe6c;
            border: 1px solid rgba(13,190,108,0.35) !important;
        }

        .btn-buy {
            background: rgba(26,110,255,0.15);
            color: #5b9eff;
            border: 1px solid rgba(26,110,255,0.35) !important;
        }

        .btn-edit {
            background: rgba(245,197,24,0.12);
            color: var(--gold);
            border: 1px solid var(--border-gold) !important;
        }

        .btn-delete {
            background: rgba(224,32,32,0.12);
            color: #ff6b6b;
            border: 1px solid rgba(224,32,32,0.3) !important;
        }

        /* ===== EMPTY STATE ===== */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted);
            grid-column: 1 / -1;
        }

        .empty-state .empty-icon {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.4;
        }

        .empty-state p {
            font-size: 16px;
            font-weight: 600;
        }

        /* ===== PAGINATION ===== */
        .pagination-box {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            padding: 10px 16px 50px;
            flex-wrap: wrap;
        }

        .page-btn {
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: var(--radius-sm);
            background: var(--bg3);
            color: var(--muted);
            border: 1px solid var(--border);
            transition: var(--transition);
            font-family: var(--font-display);
            font-size: 12px;
            font-weight: 700;
        }

        .page-btn:hover {
            color: var(--gold);
            border-color: var(--border-gold);
            background: var(--gold-glow);
        }

        .active-page {
            background: var(--gold);
            color: #000 !important;
            border-color: var(--gold);
            box-shadow: 0 0 16px rgba(245,197,24,0.35);
        }

        /* ===== FOOTER ===== */
        .footer {
            padding: 30px 20px;
            text-align: center;
            background: var(--bg2);
            border-top: 1px solid var(--border-gold);
        }

        .footer h2 {
            font-family: var(--font-display);
            font-size: 20px;
            color: var(--gold);
            margin-bottom: 12px;
            letter-spacing: 1px;
        }

        .footer p {
            color: var(--muted);
            font-size: 13px;
            font-weight: 600;
            line-height: 2;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 16px;
            margin-top: 14px;
            flex-wrap: wrap;
        }

        .footer-links a {
            font-size: 13px;
            font-weight: 700;
            color: var(--muted);
            transition: var(--transition);
        }

        .footer-links a:hover { color: var(--gold); }

        /* ===== DELETE MODAL ===== */
        #deleteModal {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.75);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 99999;
            padding: 16px;
            backdrop-filter: blur(6px);
        }

        .delete-box {
            width: 100%;
            max-width: 340px;
            background: var(--bg2);
            border: 1px solid rgba(224,32,32,0.4);
            border-radius: var(--radius-lg);
            padding: 28px 24px;
            text-align: center;
            box-shadow: 0 0 60px rgba(224,32,32,0.15);
        }

        .delete-icon {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: rgba(224,32,32,0.1);
            border: 1px solid rgba(224,32,32,0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin: 0 auto 16px;
        }

        .delete-box h2 {
            font-family: var(--font-display);
            color: #ff6b6b;
            font-size: 16px;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }

        .delete-box p {
            color: var(--muted);
            font-size: 14px;
            font-weight: 600;
            line-height: 1.6;
            margin-bottom: 24px;
        }

        .delete-actions {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .delete-actions button {
            padding: 12px;
            border: none;
            border-radius: var(--radius-sm);
            font-family: var(--font-body);
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
        }

        .delete-actions button:hover { transform: translateY(-2px); }

        .btn-cancel {
            background: var(--bg3);
            color: var(--muted);
            border: 1px solid var(--border) !important;
        }

        .btn-confirm {
            background: var(--red);
            color: white;
        }

        .btn-confirm:hover { background: var(--red-dark); }

        /* ===== TABLET ===== */
        @media (min-width: 600px) {

            .container-products {
                padding: 0 16px 30px;
                grid-template-columns: repeat(2, 1fr);
                gap: 16px;
            }

            .header {
                flex-direction: row;
                align-items: center;
                padding: 14px 24px;
            }

            .header-top { display: contents; }

            .menu { order: 2; }

            .logo { order: 1; }

            .stats-bar { padding: 0 24px 20px; }

            .search-wrap {
                padding: 0 24px;
                max-width: 640px;
            }
        }

        /* ===== DESKTOP ===== */
        @media (min-width: 1000px) {

            .container-products {
                max-width: 1400px;
                margin: 0 auto;
                padding: 0 24px 40px;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
            }
        }

        @media (min-width: 1280px) {

            .container-products {
                grid-template-columns: repeat(4, 1fr);
            }

            .header { padding: 14px 40px; }

            .logo { font-size: 22px; }
        }

        /* ===== ANIMATIONS ===== */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .card-product {
            animation: fadeUp 0.4s ease both;
        }

    </style>

</head>

<body>

<div id="toastBox"></div>

<div class="header">

    <div class="header-top">

        <a href="home.jsp" class="logo">⚡ GAME STORE</a>

        <%
            if(user!=null && !"ADMIN".equals(user.getRole())){
        %>
        <div class="balance-box">
            💰 <%= (int)user.getBalance() %>đ
        </div>
        <%
            }
        %>

    </div>

    <div class="menu">

        <a href="home.jsp">🏠 Home</a>

        <a href="products">🛍 Shop</a>

        <%
            if(user!=null && !"ADMIN".equals(user.getRole())){
        %>

        <a href="cart">🛒 Giỏ hàng</a>

        <a href="purchase-history">📜 Lịch sử</a>

        <a href="deposit.jsp">💳 Nạp tiền</a>

        <%
            }
        %>

        <%
            if(user!=null && "ADMIN".equals(user.getRole())){
        %>

        <a href="add-product.jsp">➕ Thêm acc</a>
        <a href="admin-dashboard"> 📊 DASHBOARD </a>
        <%
            }
        %>

        <a href="logout">🚪 Logout</a>

    </div>

</div>

<div class="hero">

    <h1>SHOP ACC GAME</h1>

    <p>Hệ thống bán acc game tự động • Uy tín • Giá rẻ</p>

    <div class="hero-tags">
        <span class="hero-tag">✅ Uy tín</span>
        <span class="hero-tag">⚡ Giao ngay</span>
        <span class="hero-tag">🔒 Bảo mật</span>
        <span class="hero-tag">🎮 Giá tốt</span>
    </div>

</div>

<form action="products" method="get">

    <div class="search-wrap">
        <div class="search-box">

            <input type="text"
                   name="keyword"
                   placeholder="🔍 Tìm kiếm acc game..."
                   value="<%= keyword %>">

            <button type="submit">SEARCH</button>

        </div>
    </div>

</form>

<div class="stats-bar">
    <div class="stat-pill">Tổng: <span><%= total %></span> acc</div>
    <div class="stat-pill">Trang <span><%= pageIndex %></span>/<span><%= totalPage %></span></div>
    <%
        if(!keyword.isEmpty()){
    %>
    <div class="stat-pill">Từ khoá: <span>"<%= keyword %>"</span></div>
    <%
        }
    %>
</div>

<div class="container-products">

    <%
        if(pageList!=null && !pageList.isEmpty()){

            int cardIndex = 0;

            for(GameAccount g:pageList){

                String img=
                        (g.getImage()!=null && !g.getImage().isEmpty())
                                ? g.getImage()
                                : "default.jpg";

                cardIndex++;
    %>

    <div class="card-product"
         style="animation-delay: <%= (cardIndex * 0.05) %>s"
         data-url="account-detail?id=<%= g.getId() %>">

        <div class="card-img-wrap">

            <img src="<%= request.getContextPath() %>/image?name=<%= img %>"
                 alt="<%= g.getGameName() %>"
                 loading="lazy">

            <div class="card-badge"><%= g.getGameName() %></div>

            <div class="card-overlay"></div>

        </div>

        <div class="product-title"><%= g.getAccountName() %></div>

        <div class="product-info">

            <div class="info-row">
                <span class="label">Game</span>
                <span class="value"><%= g.getGameName() %></span>
            </div>

            <div class="info-row">
                <span class="label">Acc</span>
                <span class="value"><%= g.getAccountName() %></span>
            </div>

            <div class="info-row">
                <span class="label">Status</span>
                <span class="status-badge"><%= g.getStatus() %></span>
            </div>

        </div>

        <div class="divider"></div>

        <div class="product-price"><%= (int)g.getPrice() %>đ</div>

        <div class="product-buttons">

            <%
                if(user!=null && "ADMIN".equals(user.getRole())){
            %>

            <a class="btn-edit"
               href="edit-product?id=<%= g.getId() %>">
                ✏ Sửa
            </a>

            <button class="btn-delete"
                    onclick="openDelete(event,<%= g.getId() %>)">
                🗑 Xoá
            </button>

            <%
            }else if(user!=null){
            %>

            <a class="btn-cart"
               href="add-to-cart?id=<%= g.getId() %>">
                🛒 Giỏ hàng
            </a>

            <a class="btn-buy"
               href="buy-now?id=<%= g.getId() %>">
                💳 Mua ngay
            </a>

            <%
                }
            %>

        </div>

    </div>

    <%
        }
    } else {
    %>

    <div class="empty-state">
        <div class="empty-icon">🎮</div>
        <p>Không tìm thấy sản phẩm nào</p>
    </div>

    <%
        }
    %>

</div>

<div class="pagination-box">

    <%
        for(int i=1;i<=totalPage;i++){
    %>

    <a class="page-btn <%= (i==pageIndex ? "active-page" : "") %>"
       href="products?page=<%= i %>&keyword=<%= keyword %>">
        <%= i %>
    </a>

    <%
        }
    %>

</div>

<div class="footer">

    <h2>⚡ GAME STORE</h2>

    <p>Hệ thống bán acc game tự động</p>

    <p>Hỗ trợ 24/7 • Uy tín • Nhanh chóng</p>

    <div class="footer-links">
        <a href="home.jsp">Home</a>
        <a href="products">Shop</a>
        <a href="cart">Giỏ hàng</a>
        <a href="deposit.jsp">Nạp tiền</a>
    </div>

    <p style="margin-top:16px; font-size:12px; opacity:0.5;">© 2026 Game Store. All rights reserved.</p>

</div>

<div id="deleteModal">

    <div class="delete-box">

        <div class="delete-icon">⚠️</div>

        <h2>XÁC NHẬN XOÁ</h2>

        <p>Bạn có chắc muốn xoá tài khoản này không? Hành động này không thể hoàn tác.</p>

        <div class="delete-actions">

            <button class="btn-cancel" onclick="closeDelete()">Huỷ</button>

            <button class="btn-confirm" onclick="confirmDelete()">Xoá</button>

        </div>

    </div>

</div>

<jsp:include page="chat-box.jsp"/>

<script>

    document.querySelectorAll(".card-product").forEach(card => {

        card.addEventListener("click", function(e) {

            if(e.target.closest("a") || e.target.closest("button")) return;

            const url = this.getAttribute("data-url");

            if(url) window.location.href = url;
        });
    });

    let deleteId = 0;

    function openDelete(event, id) {

        event.stopPropagation();

        deleteId = id;

        document.getElementById("deleteModal").style.display = "flex";
    }

    function closeDelete() {

        document.getElementById("deleteModal").style.display = "none";
    }

    function confirmDelete() {

        window.location.href = "delete-product?id=" + deleteId;
    }

    window.addEventListener("DOMContentLoaded", function() {

        const toastBox = document.getElementById("toastBox");

        <% if(message != null){ %>

        toastBox.innerHTML += `
<div class="toast toast-success">
✅ <%= message %>
</div>`;

        <% session.removeAttribute("message"); } %>

        <% if(error != null){ %>

        toastBox.innerHTML += `
<div class="toast toast-error">
❌ <%= error %>
</div>`;

        <% session.removeAttribute("error"); } %>

        setTimeout(() => { toastBox.innerHTML = ""; }, 4000);

    });

</script>

</body>
</html>
