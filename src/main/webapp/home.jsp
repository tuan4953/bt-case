<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  User user =
          (User) session.getAttribute("user");

  // CHƯA LOGIN
  if(user == null){

    response.sendRedirect("login.jsp");
    return;
  }
%>

<html>

<head>

  <title>HOME</title>

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
      --gold:        #f5c518;
      --gold-dim:    #c9a00a;
      --gold-glow:   rgba(245,197,24,0.18);
      --red:         #e02020;
      --red-dark:    #8b0000;
      --bg:          #080b10;
      --bg2:         #0e1219;
      --bg3:         #151c27;
      --surface:     rgba(255,255,255,0.04);
      --border:      rgba(255,255,255,0.07);
      --border-gold: rgba(245,197,24,0.22);
      --text:        #f0f0f0;
      --muted:       #8899aa;
      --font-display: 'Orbitron', sans-serif;
      --font-body:    'Rajdhani', sans-serif;
      --radius-sm:   8px;
      --radius-md:   14px;
      --radius-lg:   20px;
      --transition:  0.25s cubic-bezier(.4,0,.2,1);
    }

    html { scroll-behavior: smooth; }

    body {
      font-family: var(--font-body);
      background-color: var(--bg);
      color: var(--text);
      min-height: 100vh;
      overflow-x: hidden;
    }

    a { text-decoration: none; color: inherit; }

    /* ===== HEADER ===== */
    .header {
      width: 100%;
      padding: 14px 16px;
      background: rgba(8,11,16,0.95);
      backdrop-filter: blur(18px);
      -webkit-backdrop-filter: blur(18px);
      border-bottom: 1px solid var(--border-gold);
      position: sticky;
      top: 0;
      z-index: 999;
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 12px;
    }

    .logo {
      font-family: var(--font-display);
      font-size: 18px;
      font-weight: 900;
      color: var(--gold);
      letter-spacing: 1px;
      text-shadow: 0 0 20px rgba(245,197,24,0.45);
      white-space: nowrap;
      flex-shrink: 0;
    }

    .header-right {
      display: flex;
      align-items: center;
      gap: 10px;
      flex-wrap: wrap;
      justify-content: flex-end;
    }

    .user-box {
      font-family: var(--font-body);
      font-size: 14px;
      font-weight: 700;
      color: var(--muted);
      white-space: nowrap;
    }

    .user-box span {
      color: var(--gold);
    }

    .btn-logout {
      background: rgba(224,32,32,0.15);
      color: #ff6b6b;
      border: 1px solid rgba(224,32,32,0.3);
      padding: 8px 16px;
      border-radius: var(--radius-sm);
      font-family: var(--font-body);
      font-size: 13px;
      font-weight: 700;
      letter-spacing: 0.5px;
      transition: var(--transition);
      white-space: nowrap;
    }

    .btn-logout:hover {
      background: var(--red);
      color: white;
      border-color: var(--red);
    }

    /* ===== BANNER ===== */
    .banner {
      width: 100%;
      min-height: 260px;
      background:
              linear-gradient(rgba(0,0,0,0.6), rgba(8,11,16,0.95)),
              url('https://images7.alphacoders.com/133/1338701.png') center/cover no-repeat;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      text-align: center;
      padding: 40px 20px;
      gap: 14px;
      position: relative;
    }

    .banner::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      height: 80px;
      background: linear-gradient(to bottom, transparent, var(--bg));
      pointer-events: none;
    }

    .banner h1 {
      font-family: var(--font-display);
      font-size: clamp(22px, 6vw, 58px);
      font-weight: 900;
      color: var(--gold);
      text-shadow: 0 0 30px rgba(245,197,24,0.5), 0 0 60px rgba(245,197,24,0.15);
      letter-spacing: 2px;
      line-height: 1.2;
      position: relative;
      z-index: 1;
    }

    .banner-sub {
      font-size: clamp(13px, 3vw, 18px);
      color: var(--muted);
      font-weight: 600;
      letter-spacing: 0.5px;
      position: relative;
      z-index: 1;
    }

    .banner-tags {
      display: flex;
      justify-content: center;
      gap: 8px;
      flex-wrap: wrap;
      position: relative;
      z-index: 1;
    }

    .banner-tag {
      padding: 5px 14px;
      border-radius: 30px;
      font-size: 12px;
      font-weight: 700;
      letter-spacing: 0.5px;
      border: 1px solid var(--border-gold);
      background: var(--gold-glow);
      color: var(--gold);
    }

    /* ===== SECTION TITLE ===== */
    .section-title {
      text-align: center;
      font-family: var(--font-display);
      font-size: clamp(18px, 5vw, 36px);
      font-weight: 900;
      color: var(--gold);
      letter-spacing: 2px;
      padding: 40px 16px 30px;
      text-shadow: 0 0 20px rgba(245,197,24,0.3);
    }

    /* ===== BOX GRID ===== */
    .box-area {
      display: grid;
      grid-template-columns: 1fr;
      gap: 14px;
      padding: 0 14px 50px;
      max-width: 1300px;
      margin: 0 auto;
    }

    /* ===== BOX CARD ===== */
    .box {
      background: var(--bg2);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      padding: 28px 22px;
      text-align: center;
      transition: var(--transition);
      cursor: pointer;
      position: relative;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .box::before {
      content: '';
      position: absolute;
      inset: 0;
      background: linear-gradient(135deg, rgba(245,197,24,0.04) 0%, transparent 60%);
      opacity: 0;
      transition: var(--transition);
      pointer-events: none;
    }

    .box::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 2px;
      background: linear-gradient(90deg, transparent, var(--gold), transparent);
      opacity: 0;
      transition: var(--transition);
    }

    .box:hover {
      border-color: rgba(245,197,24,0.45);
      transform: translateY(-5px);
      box-shadow: 0 16px 40px rgba(0,0,0,0.5), 0 0 0 1px rgba(245,197,24,0.12);
    }

    .box:hover::before,
    .box:hover::after {
      opacity: 1;
    }

    .icon {
      font-size: 52px;
      margin-bottom: 16px;
      line-height: 1;
      filter: drop-shadow(0 0 10px rgba(245,197,24,0.3));
      transition: var(--transition);
    }

    .box:hover .icon {
      transform: scale(1.1);
      filter: drop-shadow(0 0 18px rgba(245,197,24,0.5));
    }

    .box h2 {
      font-family: var(--font-display);
      color: var(--gold);
      margin-bottom: 12px;
      font-size: clamp(16px, 4vw, 22px);
      font-weight: 700;
      letter-spacing: 1px;
    }

    .box p {
      color: var(--muted);
      line-height: 1.7;
      font-size: 14px;
      font-weight: 600;
      min-height: 0;
      margin-bottom: 20px;
      flex: 1;
    }

    .go-btn {
      display: inline-block;
      padding: 11px 28px;
      background: transparent;
      color: var(--gold);
      border: 1px solid var(--border-gold);
      border-radius: var(--radius-sm);
      font-family: var(--font-display);
      font-size: 12px;
      font-weight: 700;
      letter-spacing: 1px;
      transition: var(--transition);
      text-decoration: none;
      position: relative;
      z-index: 1;
    }

    .go-btn:hover {
      background: var(--gold);
      color: #000;
      border-color: var(--gold);
      box-shadow: 0 0 20px rgba(245,197,24,0.3);
    }

    /* ===== FOOTER ===== */
    .footer {
      background: var(--bg2);
      border-top: 1px solid var(--border-gold);
      padding: 28px 20px;
      text-align: center;
    }

    .footer h3 {
      font-family: var(--font-display);
      color: var(--gold);
      font-size: 18px;
      letter-spacing: 1px;
      margin-bottom: 12px;
    }

    .footer p {
      color: var(--muted);
      font-size: 13px;
      font-weight: 600;
      line-height: 2;
    }

    /* ===== ANIMATIONS ===== */
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(24px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    .box {
      animation: fadeUp 0.5s ease both;
    }

    .box:nth-child(1) { animation-delay: 0.05s; }
    .box:nth-child(2) { animation-delay: 0.12s; }
    .box:nth-child(3) { animation-delay: 0.19s; }
    .box:nth-child(4) { animation-delay: 0.26s; }

    /* ===== TABLET ===== */
    @media (min-width: 600px) {

      .header { padding: 14px 24px; }

      .logo { font-size: 22px; }

      .banner { min-height: 300px; }

      .box-area {
        grid-template-columns: repeat(2, 1fr);
        gap: 18px;
        padding: 0 20px 50px;
      }

      .icon { font-size: 58px; }
    }

    /* ===== DESKTOP ===== */
    @media (min-width: 1000px) {

      .header { padding: 14px 40px; }

      .logo { font-size: 26px; }

      .banner { min-height: 360px; }

      .box-area {
        grid-template-columns: repeat(4, 1fr);
        gap: 24px;
        padding: 0 24px 60px;
      }

      .icon { font-size: 64px; }

      .box { padding: 36px 28px; }

      .box p { min-height: 72px; }
    }

  </style>

</head>

<jsp:include page="chat-box.jsp" />

<body>

<div class="header">

  <div class="logo">⚡ GAME STORE</div>

  <div class="header-right">

    <div class="user-box">
      Xin chào, <span><%= user.getUsername() %></span>
    </div>

    <a href="logout" class="btn-logout">🚪 LOGOUT</a>

  </div>

</div>

<div class="banner">

  <h1>HỆ THỐNG SHOP ACC GAME</h1>

  <p class="banner-sub">Mua bán tài khoản game uy tín • Tự động • An toàn</p>

  <div class="banner-tags">
    <span class="banner-tag">✅ Uy tín</span>
    <span class="banner-tag">⚡ Giao ngay</span>
    <span class="banner-tag">🔒 Bảo mật</span>
    <span class="banner-tag">🎮 Giá tốt</span>
  </div>

</div>

<div class="section-title">CHỨC NĂNG WEBSITE</div>

<div class="box-area">

  <!-- PRODUCTS -->
  <div class="box" onclick="location.href='products'">

    <div class="icon">🎮</div>

    <h2>SHOP ACC</h2>

    <p>Xem toàn bộ acc game, tìm kiếm và mua acc nhanh chóng.</p>

    <a class="go-btn" href="products">VÀO SHOP</a>

  </div>

  <!-- GIẢI TRÍ -->
  <div class="box" onclick="location.href='taixiu.jsp'">

    <div class="icon">🎲</div>

    <h2>GIẢI TRÍ</h2>

    <p>Khu vực giải trí, mini game và hiệu ứng website.</p>

    <a class="go-btn" href="taixiu.jsp">TRUY CẬP</a>

  </div>

  <!-- NẠP TIỀN -->
  <div class="box" onclick="location.href='deposit.jsp'">

    <div class="icon">💰</div>

    <h2>NẠP TIỀN</h2>

    <p>Nạp tiền trực tiếp vào tài khoản để mua acc game.</p>

    <a class="go-btn" href="deposit.jsp">NẠP NGAY</a>

  </div>

  <!-- LỊCH SỬ -->
  <div class="box" onclick="location.href='purchase-history'">

    <div class="icon">📜</div>

    <h2>BILL & LỊCH SỬ</h2>

    <p>Xem lại acc đã mua, bill và lịch sử giao dịch.</p>

    <a class="go-btn" href="purchase-history">XEM BILL</a>

  </div>

</div>

<div class="footer">

  <h3>⚡ GAME STORE</h3>

  <p>© 2026 All Rights Reserved</p>

  <p>JSP Servlet + MySQL</p>

</div>

</body>

</html>
