<%@ page import="java.util.List" %>
<%@ page import="model.GameAccount" %>
<%@ page import="model.User" %>
<%@ page import="dao.CartDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    CartDAO cartDAO = new CartDAO();
    List<GameAccount> cart = cartDAO.getCartByUser(user.getId());

    double total = 0;
    if (cart != null) {
        for (GameAccount g : cart) {
            total += g.getPrice();
        }
    }

    boolean isEmpty = (cart == null || cart.isEmpty());
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng — Game Store</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        /* ── Reset ── */
        *, *::before, *::after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* ── Tokens ── */
        :root {
            --bg:        #0a0a0b;
            --surface:   #111113;
            --surface-2: #18181b;
            --border:    rgba(255,255,255,0.07);
            --border-h:  rgba(255,255,255,0.14);
            --text:      #f4f4f5;
            --muted:     #71717a;
            --gold:      #f5c842;
            --gold-dim:  rgba(245,200,66,0.12);
            --red:        #ef4444;
            --red-dim:    rgba(239,68,68,0.1);
            --blue:       #3b82f6;
            --blue-dim:   rgba(59,130,246,0.1);
            --green:      #22c55e;
            --green-dim:  rgba(34,197,94,0.1);
            --radius-sm:  8px;
            --radius-md:  14px;
            --radius-lg:  20px;
        }

        /* ── Base ── */
        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
            line-height: 1.5;
        }

        a { text-decoration: none; color: inherit; }

        /* ── Layout ── */
        .page {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px 60px;
        }

        /* ── Header ── */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 24px 0 28px;
            border-bottom: 1px solid var(--border);
            margin-bottom: 32px;
        }

        .header-brand {
            display: flex;
            align-items: baseline;
            gap: 10px;
        }

        .header-brand h1 {
            font-family: 'Syne', sans-serif;
            font-size: 22px;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: var(--text);
        }

        .item-count {
            font-size: 12px;
            font-weight: 500;
            padding: 3px 10px;
            border-radius: 99px;
            background: var(--gold-dim);
            color: var(--gold);
            border: 1px solid rgba(245,200,66,0.2);
        }

        .back-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            font-weight: 500;
            color: var(--muted);
            padding: 8px 16px;
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            background: var(--surface);
            cursor: pointer;
            transition: color 0.2s, border-color 0.2s;
        }

        .back-btn:hover {
            color: var(--text);
            border-color: var(--border-h);
        }

        /* ── Cart grid ── */
        .cart-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-bottom: 24px;
        }

        /* ── Cart item card ── */
        .cart-item {
            display: grid;
            grid-template-columns: 80px 1fr;
            gap: 16px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 18px;
            cursor: pointer;
            transition: border-color 0.2s, background 0.2s;
        }

        .cart-item:hover {
            border-color: var(--border-h);
            background: var(--surface-2);
        }

        /* Thumbnail */
        .item-thumb {
            width: 80px;
            height: 80px;
            border-radius: var(--radius-md);
            overflow: hidden;
            flex-shrink: 0;
            background: var(--surface-2);
            border: 1px solid var(--border);
        }

        .item-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        /* Body */
        .item-body {
            display: flex;
            flex-direction: column;
            gap: 8px;
            min-width: 0;
        }

        .item-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 8px;
        }

        .item-name {
            font-family: 'Syne', sans-serif;
            font-size: 15px;
            font-weight: 700;
            color: var(--text);
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .item-price {
            font-family: 'Syne', sans-serif;
            font-size: 15px;
            font-weight: 700;
            color: var(--gold);
            white-space: nowrap;
        }

        /* Meta row */
        .item-meta {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .meta-chip {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 12px;
            color: var(--muted);
        }

        .meta-chip svg {
            width: 13px;
            height: 13px;
            flex-shrink: 0;
            opacity: 0.6;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            font-size: 11px;
            font-weight: 500;
            padding: 2px 9px;
            border-radius: 99px;
            background: var(--green-dim);
            color: var(--green);
            border: 1px solid rgba(34,197,94,0.2);
        }

        .status-dot {
            width: 5px;
            height: 5px;
            border-radius: 50%;
            background: var(--green);
        }

        /* Action buttons */
        .item-actions {
            display: flex;
            gap: 8px;
            margin-top: 2px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 12px;
            font-weight: 500;
            padding: 7px 13px;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border);
            background: transparent;
            color: var(--muted);
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn svg { width: 13px; height: 13px; }

        .btn-remove:hover {
            color: var(--red);
            border-color: rgba(239,68,68,0.35);
            background: var(--red-dim);
        }

        .btn-buy {
            color: var(--blue);
            border-color: rgba(59,130,246,0.3);
            background: var(--blue-dim);
        }

        .btn-buy:hover {
            background: rgba(59,130,246,0.18);
            border-color: rgba(59,130,246,0.5);
        }

        /* ── Summary box ── */
        .summary {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 24px;
        }

        .summary-title {
            font-family: 'Syne', sans-serif;
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--muted);
            margin-bottom: 18px;
        }

        .summary-rows {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-bottom: 18px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            color: var(--muted);
        }

        .summary-row span:last-child { color: var(--text); }

        .summary-sep {
            border: none;
            border-top: 1px solid var(--border);
            margin: 18px 0;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            margin-bottom: 20px;
        }

        .summary-total .label {
            font-size: 15px;
            font-weight: 500;
            color: var(--text);
        }

        .summary-total .amount {
            font-family: 'Syne', sans-serif;
            font-size: 26px;
            font-weight: 800;
            color: var(--gold);
        }

        .checkout-btn {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 14px;
            font-family: 'Syne', sans-serif;
            font-size: 15px;
            font-weight: 700;
            border: none;
            border-radius: var(--radius-md);
            background: var(--gold);
            color: #0a0a0b;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.15s;
        }

        .checkout-btn:hover {
            opacity: 0.92;
            transform: translateY(-1px);
        }

        .checkout-btn svg { width: 18px; height: 18px; }

        /* ── Empty state ── */
        .empty-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 14px;
            padding: 80px 20px;
            text-align: center;
        }

        .empty-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--surface-2);
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .empty-icon svg { width: 28px; height: 28px; color: var(--muted); }

        .empty-title {
            font-family: 'Syne', sans-serif;
            font-size: 20px;
            font-weight: 800;
            color: var(--text);
        }

        .empty-sub {
            font-size: 14px;
            color: var(--muted);
            max-width: 280px;
        }

        .shop-link {
            margin-top: 6px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 22px;
            border-radius: var(--radius-md);
            background: var(--gold);
            color: #0a0a0b;
            font-family: 'Syne', sans-serif;
            font-size: 13px;
            font-weight: 700;
            transition: opacity 0.2s;
        }

        .shop-link:hover { opacity: 0.88; }

        /* ── Responsive ── */
        @media (max-width: 520px) {
            .cart-item { grid-template-columns: 60px 1fr; gap: 12px; padding: 14px; }
            .item-thumb { width: 60px; height: 60px; }
            .item-name { font-size: 14px; }
        }
    </style>
</head>
<body>

<div class="page">

    <!-- Header -->
    <header class="header">
        <div class="header-brand">
            <h1>Giỏ hàng</h1>
            <% if (!isEmpty) { %>
            <span class="item-count"><%= cart.size() %> sản phẩm</span>
            <% } %>
        </div>
        <a href="products" class="back-btn">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="14" height="14"><path d="M19 12H5M12 5l-7 7 7 7"/></svg>
            Quay lại shop
        </a>
    </header>

    <!-- Cart content -->
    <% if (!isEmpty) { %>

    <!-- Item list -->
    <div class="cart-list">
        <% for (GameAccount g : cart) { %>
        <div class="cart-item" onclick="goDetail(<%= g.getId() %>)">

            <div class="item-thumb">
                <img src="<%= request.getContextPath() %>/image?name=<%= g.getImage() %>"
                     alt="<%= g.getGameName() %>"
                     onerror="this.style.display='none'">
            </div>

            <div class="item-body">
                <div class="item-top">
                    <span class="item-name"><%= g.getGameName() %></span>
                    <span class="item-price"><%= String.format("%,.0f", g.getPrice()) %>đ</span>
                </div>

                <div class="item-meta">
                        <span class="meta-chip">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg>
                            <%= g.getAccountName() %>
                        </span>
                    <span class="status-badge">
                            <span class="status-dot"></span>
                            <%= g.getStatus() %>
                        </span>
                </div>

                <div class="item-actions">
                    <a class="btn btn-remove"
                       href="remove-cart?id=<%= g.getId() %>"
                       onclick="event.stopPropagation()">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/><path d="M10 11v6M14 11v6"/><path d="M9 6V4h6v2"/></svg>
                        Xoá
                    </a>
                    <a class="btn btn-buy"
                       href="buy-now?id=<%= g.getId() %>"
                       onclick="event.stopPropagation()">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
                        Mua ngay
                    </a>
                </div>
            </div>

        </div>
        <% } %>
    </div>

    <!-- Summary -->
    <div class="summary">
        <p class="summary-title">Tóm tắt đơn hàng</p>

        <div class="summary-rows">
            <div class="summary-row">
                <span>Số lượng</span>
                <span><%= cart.size() %> sản phẩm</span>
            </div>
            <div class="summary-row">
                <span>Phí xử lý</span>
                <span>Miễn phí</span>
            </div>
        </div>

        <hr class="summary-sep">

        <div class="summary-total">
            <span class="label">Tổng thanh toán</span>
            <span class="amount"><%= String.format("%,.0f", total) %>đ</span>
        </div>

        <form action="checkout-cart" method="post">
            <button type="submit" class="checkout-btn">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
                Thanh toán tất cả
            </button>
        </form>
    </div>

    <% } else { %>

    <!-- Empty state -->
    <div class="empty-state">
        <div class="empty-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        </div>
        <p class="empty-title">Giỏ hàng trống</p>
        <p class="empty-sub">Bạn chưa thêm tài khoản game nào vào giỏ hàng.</p>
        <a href="products" class="shop-link">Khám phá shop</a>
    </div>

    <% } %>

</div>

<script>
    function goDetail(id) {
        window.location.href = "account-detail?id=" + id;
    }
</script>

</body>
</html>
