<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="model.SupportMessage" %>
<%@ page import="model.User" %>

<%
    request.setCharacterEncoding("UTF-8");

    response.setContentType(
            "text/html;charset=UTF-8"
    );

    response.setCharacterEncoding("UTF-8");

    User user =
            (User) session.getAttribute("user");

    List<SupportMessage> chatList =
            (List<SupportMessage>)
                    request.getAttribute("chatList");
%>

<meta charset="UTF-8">

<style>

    .support-chat-btn{
        position:fixed;
        bottom:25px;
        right:25px;
        width:65px;
        height:65px;
        border-radius:50%;
        background:gold;
        color:black;
        font-size:28px;
        border:none;
        cursor:pointer;
        z-index:999999;
        box-shadow:0 0 15px gold;
    }

    .support-chat-box{
        position:fixed;
        bottom:100px;
        right:25px;
        width:360px;
        height:520px;

        background:#121212;

        border:2px solid gold;
        border-radius:18px;

        overflow:hidden;

        display:none;
        flex-direction:column;

        z-index:999999;

        box-shadow:0 0 25px rgba(0,0,0,0.7);

        font-family:Arial, sans-serif;
    }

    .support-chat-header{

        background:#8b0000;

        color:white;

        padding:15px;

        font-size:18px;

        font-weight:bold;

        text-align:center;

        letter-spacing:1px;
    }

    .support-chat-messages{

        flex:1;

        padding:15px;

        overflow-y:auto;

        background:#1c1c1c;

        display:flex;

        flex-direction:column;

        gap:12px;
    }

    .support-msg{

        padding:12px 14px;

        border-radius:14px;

        max-width:85%;

        word-wrap:break-word;

        overflow-wrap:break-word;

        white-space:pre-wrap;

        line-height:1.5;

        font-size:14px;

        animation:fadeIn .2s ease;
    }

    .support-user{

        background:#0057d8;

        color:white;

        margin-left:auto;

        text-align:left;
    }

    .support-admin{

        background:#8b0000;

        color:white;

        margin-right:auto;

        text-align:left;
    }

    .support-name{

        font-size:12px;

        font-weight:bold;

        opacity:0.8;

        margin-bottom:6px;

        display:block;
    }

    .support-chat-form{

        display:flex;

        border-top:1px solid #333;

        background:#181818;
    }

    .support-chat-form input{

        flex:1;

        padding:14px;

        border:none;

        outline:none;

        background:#222;

        color:white;

        font-size:14px;

        font-family:Arial, sans-serif;
    }

    .support-chat-form input::placeholder{

        color:#aaa;
    }

    .support-chat-form button{

        width:90px;

        border:none;

        background:gold;

        color:black;

        font-weight:bold;

        cursor:pointer;

        transition:0.2s;
    }

    .support-chat-form button:hover{

        background:#ffd700;
    }

    @keyframes fadeIn{

        from{
            opacity:0;
            transform:translateY(10px);
        }

        to{
            opacity:1;
            transform:translateY(0);
        }
    }

</style>

<button class="support-chat-btn"
        onclick="toggleSupportChat()">

    💬

</button>

<div class="support-chat-box"
     id="supportChatBox">

    <div class="support-chat-header">

        HỖ TRỢ TRỰC TUYẾN

    </div>

    <div class="support-chat-messages"
         id="supportMessages">

        <%
            if(chatList != null){

                for(SupportMessage s : chatList){

                    boolean isAdmin =
                            "ADMIN".equals(
                                    s.getSenderRole()
                            );
        %>

        <div class="support-msg <%= isAdmin ? "support-admin" : "support-user" %>">

            <span class="support-name">

                <%= isAdmin ? "👑 ADMIN" : "👤 USER" %>

            </span>

            <%= s.getMessage() %>

        </div>

        <%
                }
            }
        %>

    </div>

    <form class="support-chat-form"
          action="send-message"
          method="post">

        <input type="text"
               name="message"
               placeholder="Nhập tin nhắn..."
               required>

        <button type="submit">

            GỬI

        </button>

    </form>

</div>

<script>

    function toggleSupportChat(){

        let box =
            document.getElementById(
                "supportChatBox"
            );

        if(box.style.display === "flex"){

            box.style.display = "none";

        } else {

            box.style.display = "flex";

            let msg =
                document.getElementById(
                    "supportMessages"
                );

            msg.scrollTop =
                msg.scrollHeight;
        }
    }

</script>