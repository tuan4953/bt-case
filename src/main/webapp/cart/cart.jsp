<%@ page import="java.util.List" %>
<%@ page import="model.GameAccount" %>
<%@ page import="model.User" %>
<%@ page import="dao.CartDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(
                request.getContextPath()
                        + "/auth/login.jsp"
        );
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
            --bg:          #f5f5f4;
            --surface:     #ffffff;
            --surface2:    #fafaf9;
            --border:      rgba(0,0,0,0.08);
            --border-h:    rgba(0,0,0,0.14);
            --text:        #1c1c1c;
            --muted:       #78716c;
            --hint:        #a8a29e;
            --amber:       #BA7517;
            --amber-bg:    #FAEEDA;
            --amber-bd:    #EF9F27;
            --green:       #3B6D11;
            --green-bg:    #EAF3DE;
            --green-bd:    #97C459;
            --blue:        #185FA5;
            --blue-bg:     #E6F1FB;
            --blue-bd:     #85B7EB;
            --red:         #A32D2D;
            --red-bg:      #FCEBEB;
            --red-bd:      #F09595;
            --r-sm:        8px;
            --r-md:        12px;
            --r-lg:        16px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        a { text-decoration: none; color: inherit; }

        /* ── Top bar ── */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 20px;
            background: var(--surface);
            border-bottom: 1px solid var(--border);
        }

        .brand {
            font-size: 15px;
            font-weight: 600;
            color: var(--amber);
            letter-spacing: -0.3px;
        }

        .top-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-greet {
            font-size: 13px;
            color: var(--muted);
        }

        .user-greet b {
            color: var(--text);
            font-weight: 500;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 12px;
            font-weight: 500;
            padding: 7px 13px;
            border-radius: var(--r-sm);
            background: var(--surface2);
            border: 1px solid var(--border);
            color: var(--muted);
            cursor: pointer;
            transition: color 0.18s, border-color 0.18s;
        }

        .logout-btn:hover {
            color: var(--text);
            border-color: var(--border-h);
        }

        /* ── Page ── */
        .page {
            max-width: 860px;
            margin: 0 auto;
            padding: 22px 16px 56px;
        }

        /* ── Page header ── */
        .pg-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .pg-title {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .pg-title h1 {
            font-size: 18px;
            font-weight: 600;
            letter-spacing: -0.3px;
        }

        .item-count {
            font-size: 11px;
            font-weight: 600;
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
            padding: 8px 13px;
            border-radius: var(--r-sm);
            background: var(--surface);
            border: 1px solid var(--border);
            color: var(--muted);
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
            margin-bottom: 14px;
        }

        /* ── Cart item ── */
        .cart-item {
            display: grid;
            grid-template-columns: 28px 70px minmax(0, 1fr);
            gap: 12px;
            align-items: center;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--r-lg);
            padding: 14px 16px;
            cursor: pointer;
            transition: border-color 0.18s;
        }

        .cart-item:hover {
            border-color: var(--border-h);
        }

        .check-wrap {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .cart-check {
            width: 16px;
            height: 16px;
            accent-color: var(--amber);
            cursor: pointer;
            flex-shrink: 0;
        }

        .item-thumb {
            width: 70px;
            height: 70px;
            border-radius: var(--r-md);
            overflow: hidden;
            background: var(--surface2);
            border: 1px solid var(--border);
            flex-shrink: 0;
        }

        .item-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

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
            gap: 8px;
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

        .item-meta {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }

        .meta-chip {
            font-size: 12px;
            color: var(--muted);
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .meta-chip svg { width: 13px; height: 13px; opacity: 0.65; }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            font-size: 11px;
            font-weight: 600;
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

        .item-actions {
            display: flex;
            gap: 6px;
            margin-top: 3px;
            flex-wrap: wrap;
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

        .btn-remove {
            color: var(--red);
            border-color: var(--red-bd);
            background: var(--red-bg);
        }

        .btn-remove:hover {
            border-color: #E24B4A;
        }

        .btn-buy {
            color: var(--blue);
            border-color: var(--blue-bd);
            background: var(--blue-bg);
        }

        .btn-buy:hover {
            border-color: #378ADD;
        }

        /* ── Summary ── */
        .summary {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--r-lg);
            padding: 18px 20px;
        }

        .summary-title {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.07em;
            color: var(--hint);
            margin-bottom: 12px;
        }

        .summary-rows {
            display: flex;
            flex-direction: column;
            gap: 8px;
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
            margin-bottom: 14px;
        }

        .summary-total .label {
            font-size: 14px;
            font-weight: 500;
            color: var(--text);
        }

        .summary-total .amount {
            font-size: 20px;
            font-weight: 700;
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
            padding: 70px 20px;
            text-align: center;
        }

        .empty-icon {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            background: var(--surface);
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
        }

        .empty-icon svg { width: 24px; height: 24px; color: var(--hint); }

        .empty-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .empty-sub {
            font-size: 13px;
            color: var(--muted);
            max-width: 260px;
            margin: 0 auto;
        }

        .shop-link {
            display: inline-block;
            margin-top: 20px;
            background: var(--amber);
            color: #fff;
            padding: 10px 20px;
            border-radius: var(--r-md);
            font-size: 13px;
            font-weight: 600;
            transition: opacity 0.18s;
        }

        .shop-link:hover { opacity: 0.88; }

        /* ── Footer ── */
        .footer {
            margin-top: 8px;
            padding: 24px 20px;
            text-align: center;
            border-top: 1px solid var(--border);
        }

        .footer h3 {
            font-size: 14px;
            font-weight: 600;
            color: var(--amber);
            margin-bottom: 6px;
        }

        .footer p {
            font-size: 12px;
            color: var(--hint);
            margin-top: 4px;
        }

        /* ── Responsive ── */
        @media (max-width: 520px) {
            .cart-item { grid-template-columns: 24px 56px minmax(0, 1fr); gap: 10px; padding: 12px; }
            .item-thumb { width: 56px; height: 56px; }
            .item-name { font-size: 13px; }
            .top-bar { padding: 12px 14px; }
        }
    </style>
</head>
<body>

<!-- Top bar -->
<div class="top-bar">
    <div class="brand">⚡ GAME STORE</div>
    <div class="top-right">
        <span class="user-greet">Xin chào, <b><%= user.getUsername() %></b></span>
        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="14" height="14"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
            Đăng xuất
        </a>
    </div>
</div>

<div class="page">

    <!-- Page header -->
    <div class="pg-header">
        <div class="pg-title">
            <h1>Giỏ hàng</h1>
            <% if (!isEmpty) { %>
            <span class="item-count"><%= cart.size() %> sản phẩm</span>
            <% } %>
        </div>
        <a href="<%= request.getContextPath() %>/products" class="back-btn">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5M12 5l-7 7 7 7"/></svg>
            Quay lại shop
        </a>
    </div>

    <!-- Cart content -->
    <% if (!isEmpty) { %>

    <form action="<%= request.getContextPath() %>/checkout-cart" method="post" id="checkoutForm">

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
                           href="<%= request.getContextPath() %>/remove-cart?id=<%= g.getId() %>"
                           onclick="event.stopPropagation()">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/><path d="M10 11v6M14 11v6"/><path d="M9 6V4h6v2"/></svg>
                            Xoá
                        </a>
                        <a class="btn btn-buy"
                           href="<%= request.getContextPath() %>/buy-now?id=<%= g.getId() %>"
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
                    <span><span id="selectedCount"><%= cart.size() %></span> sản phẩm</span>
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

            <button type="submit" class="checkout-btn">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
                Thanh toán mục đã chọn
            </button>
        </div>

    </form>

    <% } else { %>

    <!-- Empty state -->
    <div class="empty-state">
        <div class="empty-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        </div>
        <p class="empty-title">Giỏ hàng trống</p>
        <p class="empty-sub">Bạn chưa thêm tài khoản game nào vào giỏ hàng.</p>
        <a href="<%= request.getContextPath() %>/products" class="shop-link">Khám phá shop</a>
    </div>

    <% } %>

</div>

<!-- Footer -->
<div class="footer">
    <h3>⚡ GAME STORE</h3>
    <p>© 2026 All Rights Reserved</p>
    <p>JSP Servlet + MySQL</p>
</div>

<script>
    function goDetail(id) {
        window.location.href =
            "<%= request.getContextPath() %>/account-detail?id=" + id;
    }

    function updateTotal() {
        let total = 0;
        let count = 0;

        document.querySelectorAll(".cart-check").forEach(cb => {
            if (cb.checked) {
                total += Number(cb.dataset.price);
                count++;
            }
        });

        document.getElementById("totalPrice").innerText =
            total.toLocaleString('vi-VN');

        const selectedCount =
            document.getElementById("selectedCount");

        if (selectedCount) {
            selectedCount.innerText = count;
        }
    }

    document.querySelectorAll(".cart-check").forEach(cb => {
        cb.addEventListener("change", updateTotal);
    });

    const checkoutForm =
        document.getElementById("checkoutForm");

    if (checkoutForm) {
        checkoutForm.addEventListener("submit", function(e) {
            const checked =
                document.querySelectorAll(".cart-check:checked");

            if (checked.length === 0) {
                e.preventDefault();
                alert("Vui lòng chọn ít nhất 1 acc để thanh toán!");
            }
        });
    }

    updateTotal();
</script>

</body>
</html>
