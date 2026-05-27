<%@ page import="java.util.List" %>
<%@ page import="model.SupportMessage" %>

<%
    List<SupportMessage> list =
            (List<SupportMessage>)
                    request.getAttribute("chatList");
%>

<html>

<head>

    <title>Admin Chat</title>

    <style>

        body{
            background:#111;
            color:white;
            font-family:Arial;
            padding:30px;
        }

        table{
            width:100%;
            border-collapse:collapse;
        }

        th,td{
            border:1px solid gold;
            padding:15px;
        }

        th{
            background:#8b0000;
        }

    </style>

</head>

<body>

<h1>CHAT HỖ TRỢ</h1>

<table>

    <tr>

        <th>User ID</th>
        <th>Role</th>
        <th>Message</th>

    </tr>

    <%
        for(SupportMessage s : list){
    %>

    <tr>

        <td>
            <%= s.getUserId() %>
        </td>

        <td>
            <%= s.getSenderRole() %>
        </td>

        <td>
            <%= s.getMessage() %>
        </td>

    </tr>

    <%
        }
    %>

</table>

</body>
</html>