<%@ page import="java.util.List" %>
<%@ page import="model.GameAccount" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<GameAccount> history =
            (List<GameAccount>)
                    request.getAttribute("history");
%>

<html>

<head>

    <title>Lịch sử mua</title>

    <style>

        body{
            background:#111;
            color:white;
            font-family:Arial;
            padding:30px;
        }
        .header{
            background:#1c1c1c;
            padding:20px 40px;
            border-bottom:2px solid gold;

            display:flex;
            justify-content:space-between;
            align-items:center;
        }
        h1{
            text-align:center;
            color:gold;
        }

        table{
            width:100%;
            border-collapse:collapse;
        }

        th,td{
            border:1px solid gold;
            padding:15px;
            text-align:center;
        }

        th{
            background:#8b0000;
        }

    </style>

</head>
<jsp:include page="chat-box.jsp" />
<body>

<div class="header">

    <div class="logo">
        SHOP ACC GAME
    </div>

    <a class="back-btn"
       href="home.jsp">

        ← QUAY LẠI HOME

    </a>

</div>
<h1>LỊCH SỬ MUA ACC</h1>

<table>

    <tr>

        <th>Game</th>
        <th>Acc</th>
        <th>Giá</th>
        <th>Trạng thái</th>

    </tr>

    <%
        if(history != null){

            for(GameAccount g : history){
    %>

    <tr>

        <td>
            <%= g.getGameName() %>
        </td>

        <td>
            <%= g.getAccountName() %>
        </td>

        <td>
            <%= (int)g.getPrice() %>đ
        </td>

        <td>
            ĐÃ THANH TOÁN
        </td>

    </tr>

    <%
            }
        }
    %>

</table>

</body>
</html>