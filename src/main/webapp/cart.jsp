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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --bg:         #f5f5f4;
            --surface:    #ffffff;
            --surface-2:  #fafaf9;
            --border:     rgba(0,0,0,0.08);
            --border-h:   rgba(0,0,0,0.14);
            --text:       #1c1c1c;
            --muted:      #78716c;
            --amber:      #d97706;
            --amber-bg:   #fffbeb;
            --amber-bd:   rgba(217,119,6,0.25);
            --red:        #dc2626;
            --red-bg:     #fef2f2;
            --red-bd:     rgba(220,38,38,0.2);
            --blue:       #2563eb;
            --blue-bg:    #eff6ff;
            --blue-bd:    rgba(37,99,235,0.2);
            --green:      #16a34a;
            --green-bg:   #f0fdf4;
            --green-bd:   rgba(22,163,74,0.2);
            --r-sm:       8px;
            --r-md:       12px;
            --r-lg:       16px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
            line-height: 1.5;
        }

        a { text-decoration: none; color: inherit; }

        /* ── Layout ── */
        .page {
            max-width: 860px;
            margin: 0 auto;
            padding: 0 20px 60px;
        }

        /* ── Header ── */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 28px 0 24px;
            border-bottom: 1px solid var(--border);
            margin-bottom: 28px;
        }

        .header-brand {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-brand h1 {
            font-size: 20px;
            font-weight: 600;
            color: var(--text);
            letter-spacing: -0.3px;
        }

        .item-count {
            font-size: 12px;
            font-weight: 500;
            padding: 3px 10px;
            border-radius: 99px;
            background: var(--amber-bg);
            color: var(--amber);
            border: 1px solid var(--amber-bd);
        }

        .back-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 13px;
            font-weight: 500;
            color: var(--muted);
            padding: 8px 14px;
            border: 1px solid var(--border);
            border-radius: var(--r-sm);
            background: var(--surface);
            cursor: pointer;
            transition: color 0.18s, border-color 0.18s;
        }

        .back-btn:hover {
            color: var(--text);
            border-color: var(--border-h);
        }

        .back-btn svg { width: 14px; height: 14px; }

        /* ── Cart list ── */
        .cart-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 16px;
        }

        /* ── Cart item ── */
        .cart-item {
            display: grid;
            grid-template-columns: 32px 72px 1fr;
            gap: 14px;
            align-items: center;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--r-lg);
            padding: 14px 16px;
            cursor: pointer;
            transition: border-color 0.18s, box-shadow 0.18s;
        }

        .cart-item:hover {
            border-color: var(--border-h);
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
        }

        /* Checkbox */
        .check-wrap {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .cart-check {
            width: 17px;
            height: 17px;
            accent-color: var(--amber);
            cursor: pointer;
            flex-shrink: 0;
        }

        /* Thumbnail */
        .item-thumb {
            width: 72px;
            height: 72px;
            border-radius: var(--r-md);
            overflow: hidden;
            background: var(--surface-2);
            border: 1px solid var(--border);
            flex-shrink: 0;
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
            gap: 5px;
            min-width: 0;
        }

        .item-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 10px;
        }

        .item-name {
            font-size: 14px;
            font-weight: 500;
            color: var(--text);
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .item-price {
            font-size: 14px;
            font-weight: 600;
            color: var(--amber);
            white-space: nowrap;
            flex-shrink: 0;
        }

        /* Meta */
        .item-meta {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }

        .meta-chip {
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 12px;
            color: var(--muted);
        }

        .meta-chip svg { width: 13px; height: 13px; opacity: 0.65; }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            font-size: 11px;
            font-weight: 500;
            padding: 2px 8px;
            border-radius: 99px;
            background: var(--green-bg);
            color: var(--green);
            border: 1px solid var(--green-bd);
        }

        .status-dot {
            width: 5px;
            height: 5px;
            border-radius: 50%;
            background: var(--green);
        }

        /* Actions */
        .item-actions {
            display: flex;
            gap: 6px;
            margin-top: 2px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            font-size: 12px;
            font-weight: 500;
            padding: 5px 11px;
            border-radius: var(--r-sm);
            border: 1px solid var(--border);
            background: transparent;
            color: var(--muted);
            cursor: pointer;
            text-decoration: none;
            transition: all 0.18s;
        }

        .btn svg { width: 13px; height: 13px; }

        .btn-remove:hover {
            color: var(--red);
            border-color: var(--red-bd);
            background: var(--red-bg);
        }

        .btn-buy {
            color: var(--blue);
            border-color: var(--blue-bd);
            background: var(--blue-bg);
        }

        .btn-buy:hover {
            border-color: rgba(37,99,235,0.4);
            background: #dbeafe;
        }

        /* ── Summary ── */
        .summary {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--r-lg);
            padding: 20px 22px;
        }

        .summary-title {
            font-size: 11px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.07em;
            color: var(--muted);
            margin-bottom: 14px;
        }

        .summary-rows {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 14px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            color: var(--muted);
        }

        .summary-row span:last-child { color: var(--text); }

        .summary-sep {
            border: none;
            border-top: 1px solid var(--border);
            margin: 14px 0;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            margin-bottom: 16px;
        }

        .summary-total .label {
            font-size: 14px;
            font-weight: 500;
            color: var(--text);
        }

        .summary-total .amount {
            font-size: 22px;
            font-weight: 600;
            color: var(--amber);
            letter-spacing: -0.5px;
        }

        .checkout-btn {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            padding: 13px;
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            font-weight: 600;
            border: none;
            border-radius: var(--r-md);
            background: var(--amber);
            color: #fff;
            cursor: pointer;
            transition: opacity 0.18s, transform 0.15s;
        }

        .checkout-btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .checkout-btn svg { width: 17px; height: 17px; }

        /* ── Empty state ── */
        .empty-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 12px;
            padding: 80px 20px;
            text-align: center;
        }

        .empty-icon {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: var(--surface);
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .empty-icon svg { width: 26px; height: 26px; color: var(--muted); }

        .empty-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--text);
        }

        .empty-sub {
            font-size: 13px;
            color: var(--muted);
            max-width: 260px;
        }

        .shop-link {
            margin-top: 6px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 20px;
            border-radius: var(--r-md);
            background: var(--amber);
            color: #fff;
            font-size: 13px;
            font-weight: 600;
            transition: opacity 0.18s;
        }

        .shop-link:hover { opacity: 0.88; }

        /* ── Responsive ── */
        @media (max-width: 520px) {
            .cart-item { grid-template-columns: 28px 56px 1fr; gap: 10px; padding: 12px; }
            .item-thumb { width: 56px; height: 56px; }
            .item-name { font-size: 13px; }
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
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5M12 5l-7 7 7 7"/></svg>
            Quay lại shop
        </a>
    </header>

    <!-- Cart content -->
    <% if (!isEmpty) { %>

    <div class="cart-list">
        <% for (GameAccount g : cart) { %>
        <div class="cart-item" onclick="goDetail(<%= g.getId() %>)">

            <div class="check-wrap">
                <input type="checkbox"
                       name="selectedIds"
                       value="<%= g.getId() %>"
                       class="cart-check"
                       data-price="<%= g.getPrice() %>"
                       checked
                       onclick="event.stopPropagation()">
            </div>

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
            <span class="amount"><span id="totalPrice"><%= String.format("%,.0f", total) %></span>đ</span>
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

    function updateTotal() {
        let total = 0;
        document.querySelectorAll(".cart-check").forEach(cb => {
            if (cb.checked) total += Number(cb.dataset.price);
        });
        document.getElementById("totalPrice").innerText = total.toLocaleString('vi-VN');
    }

    document.querySelectorAll(".cart-check").forEach(cb => {
        cb.addEventListener("change", updateTotal);
    });

    updateTotal();
</script>

</body>
</html>
