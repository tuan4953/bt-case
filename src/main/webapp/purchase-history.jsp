<%@ page import="java.util.List" %>
<%@ page import="model.GameAccount" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<GameAccount> history =
            (List<GameAccount>) request.getAttribute("history");

    Integer totalPurchased =
            (Integer) request.getAttribute("totalPurchased");

    Double totalSpent =
            (Double) request.getAttribute("totalSpent");

    if(totalPurchased == null) totalPurchased = 0;
    if(totalSpent == null) totalSpent = 0.0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Lịch sử mua acc</title>
    <meta charset="UTF-8">

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            font-family:'Segoe UI',sans-serif;
            background:
                    linear-gradient(rgba(0,0,0,0.88),rgba(0,0,0,0.92)),
                    url('https://images.unsplash.com/photo-1542751110-97427bbecf20');
            background-size:cover;
            background-attachment:fixed;
            color:white;
            min-height:100vh;
        }

        a{
            text-decoration:none;
        }

        .header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            padding:18px 40px;
            background:rgba(15,15,15,0.78);
            backdrop-filter:blur(14px);
            border-bottom:1px solid rgba(255,215,0,0.2);
        }

        .logo{
            font-size:28px;
            font-weight:900;
            color:gold;
            text-shadow:0 0 10px gold;
        }

        .back-btn{
            padding:12px 18px;
            border-radius:10px;
            background:gold;
            color:black;
            font-weight:bold;
            transition:0.3s;
        }

        .back-btn:hover{
            transform:translateY(-2px);
        }

        .page-title{
            text-align:center;
            padding:40px 20px 25px;
        }

        .page-title h1{
            font-size:48px;
            color:gold;
            text-shadow:0 0 15px gold;
        }

        .stats-container{
            width:95%;
            margin:auto;
            display:grid;
            grid-template-columns:1fr;
            gap:18px;
            margin-bottom:30px;
        }

        .stats-box{
            background:linear-gradient(145deg,rgba(25,25,25,0.95),rgba(12,12,12,0.95));
            border:1px solid rgba(255,215,0,0.18);
            border-radius:20px;
            padding:25px;
            text-align:center;
            box-shadow:0 0 20px rgba(255,215,0,0.15);
        }

        .stats-box h2{
            font-size:18px;
            color:#ccc;
            margin-bottom:12px;
        }

        .stats-box .value{
            font-size:38px;
            font-weight:900;
            color:gold;
            text-shadow:0 0 12px rgba(255,215,0,0.4);
        }

        .table-container{
            width:95%;
            margin:auto;
            overflow:auto;
            border-radius:20px;
            background:rgba(15,15,15,0.92);
            border:1px solid rgba(255,215,0,0.15);
        }

        table{
            width:100%;
            border-collapse:collapse;
            min-width:900px;
        }

        th{
            background:linear-gradient(90deg,#7a0000,#a30000);
            padding:18px;
            font-size:15px;
        }

        td{
            padding:16px;
            text-align:center;
            border-bottom:1px solid rgba(255,255,255,0.08);
            font-size:14px;
        }

        tr:hover{
            background:rgba(255,215,0,0.06);
        }

        .paid{
            color:#00ff95;
            font-weight:bold;
        }

        .pass-box{
            display:flex;
            justify-content:center;
            align-items:center;
            gap:8px;
        }

        .pass-text{
            color:gold;
            font-weight:bold;
            letter-spacing:1px;
        }

        .show-pass-btn{
            padding:6px 12px;
            border:none;
            border-radius:8px;
            background:gold;
            color:black;
            font-weight:bold;
            cursor:pointer;
        }

        .show-pass-btn:hover{
            background:#ffd700;
        }

        .footer{
            margin-top:50px;
            padding:30px;
            text-align:center;
            background:#090909;
            border-top:1px solid rgba(255,215,0,0.2);
        }

        .footer h2{
            color:gold;
            margin-bottom:10px;
        }

        .footer p{
            color:#aaa;
            margin-top:8px;
        }

        @media(min-width:700px){
            .stats-container{
                grid-template-columns:repeat(2,1fr);
            }

            .page-title h1{
                font-size:55px;
            }
        }
    </style>
</head>

<body>

<div class="header">
    <div class="logo">
        🎮 GAME STORE
    </div>

    <a class="back-btn" href="home.jsp">
        ← QUAY LẠI HOME
    </a>
</div>

<div class="page-title">
    <h1>📜 LỊCH SỬ MUA ACC</h1>
</div>

<div class="stats-container">
    <div class="stats-box">
        <h2>📦 TỔNG ACC ĐÃ MUA</h2>
        <div class="value"><%= totalPurchased %></div>
    </div>

    <div class="stats-box">
        <h2>💰 TỔNG TIỀN ĐÃ THANH TOÁN</h2>
        <div class="value"><%= String.format("%,.0f",totalSpent) %>đ</div>
    </div>
</div>

<div class="table-container">
    <table>
        <tr>
            <th>Game</th>
            <th>Tên acc</th>
            <th>Tài khoản</th>
            <th>Mật khẩu</th>
            <th>Giá</th>
            <th>Trạng thái</th>
        </tr>

        <%
            if(history != null){
                for(GameAccount g : history){
        %>

        <tr>
            <td><%= g.getGameName() %></td>

            <td><%= g.getAccountName() %></td>

            <td><%= g.getAccountName() %></td>

            <td>
                <div class="pass-box">
                    <span class="pass-text" id="pass-<%= g.getId() %>">
                        ********
                    </span>

                    <button class="show-pass-btn"
                            type="button"
                            onclick="togglePass('<%= g.getId() %>','<%= g.getAccountPass() %>',this)">
                        Xem
                    </button>
                </div>
            </td>

            <td><%= String.format("%,.0f",g.getPrice()) %>đ</td>

            <td class="paid">ĐÃ THANH TOÁN</td>
        </tr>

        <%
                }
            }
        %>
    </table>
</div>

<div class="footer">
    <h2>🎮 GAME STORE</h2>
    <p>Lịch sử giao dịch acc game</p>
    <p>Uy tín • Tự động • Nhanh chóng</p>
</div>

<jsp:include page="chat-box.jsp"/>

<script>
    function togglePass(id, pass, btn){
        const passText = document.getElementById("pass-" + id);

        if(passText.innerText.trim() === "********"){
            passText.innerText = pass;
            btn.innerText = "Ẩn";
        }else{
            passText.innerText = "********";
            btn.innerText = "Xem";
        }
    }
</script>

</body>
</html>