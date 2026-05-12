<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");

    long dbBalance = (user != null) ? (long) user.getBalance() : 0;
    String username = (user != null) ? user.getUsername() : "Khách";
    boolean loggedIn = (user != null);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tài Xỉu - SunWin</title>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Exo+2:wght@300;400;600;700;800&display=swap');

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        :root{
            --gold:#FFD700;
            --gold2:#FFA500;
            --dark:#07070f;
            --panel:#16162a;
            --border:rgba(255,215,0,.18);

            --green:#00ff88;
            --red:#ff3366;
        }

        body{
            min-height:100vh;
            overflow-x:hidden;
            background:#050510;
            color:white;
            font-family:'Exo 2',sans-serif;
            position:relative;
        }

        body::before{
            content:'';
            position:fixed;
            inset:0;
            z-index:0;

            background:
                    radial-gradient(circle at 20% 20%, rgba(255,0,0,.12), transparent 40%),
                    radial-gradient(circle at 80% 20%, rgba(0,255,150,.10), transparent 40%),
                    radial-gradient(circle at 50% 100%, rgba(255,200,0,.08), transparent 50%);
        }

        /* ================= HEADER ================= */

        .header{
            width:100%;
            height:86px;

            position:sticky;
            top:0;
            z-index:999;

            display:flex;
            align-items:center;
            justify-content:space-between;

            padding:0 30px;

            background:rgba(5,5,15,.92);
            backdrop-filter:blur(12px);

            border-bottom:1px solid rgba(255,215,0,.15);
        }

        .logo{
            font-size:30px;
            font-weight:900;
            font-family:'Orbitron',sans-serif;

            background:linear-gradient(135deg,#FFD700,#ff8c00);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;

            letter-spacing:3px;
        }

        .back-btn{
            text-decoration:none;

            color:#FFD700;
            font-weight:700;

            border:1px solid rgba(255,215,0,.3);

            padding:12px 22px;
            border-radius:14px;

            transition:.25s;
            background:rgba(255,215,0,.05);
        }

        .back-btn:hover{
            transform:translateY(-2px);
            background:rgba(255,215,0,.12);
            box-shadow:0 0 20px rgba(255,215,0,.2);
        }

        .user-box{
            color:#999;
            font-size:14px;
        }

        .user-box span{
            color:#FFD700;
            font-weight:700;
        }

        /* ================= MAIN ================= */

        .main{
            position:relative;
            z-index:2;

            width:100%;
            max-width:900px;

            margin:auto;
            padding:30px 15px 60px;
        }

        .game-title{
            text-align:center;
            margin-bottom:28px;
        }

        .game-title h1{
            font-size:62px;
            font-family:'Orbitron',sans-serif;

            background:linear-gradient(135deg,#FFD700,#ff8c00);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;

            letter-spacing:8px;
        }

        .game-title p{
            margin-top:8px;
            color:#a88a30;
            letter-spacing:7px;
            font-size:12px;
        }

        /* ================= BALANCE ================= */

        .balance-bar{
            background:#141428;
            border:1px solid rgba(255,215,0,.18);

            border-radius:18px;

            padding:18px 25px;

            display:flex;
            align-items:center;
            justify-content:space-between;

            margin-bottom:20px;

            box-shadow:0 10px 40px rgba(0,0,0,.45);
        }

        .balance-left{
            display:flex;
            gap:40px;
        }

        .balance-item small{
            display:block;
            color:#777;
            margin-bottom:5px;
            text-transform:uppercase;
            font-size:11px;
        }

        .balance-item h2{
            font-size:28px;
            color:#FFD700;
            font-family:'Orbitron',sans-serif;
        }

        .balance-item h3{
            font-size:24px;
            color:#00ff88;
            font-family:'Orbitron',sans-serif;
        }

        .nap-btn{
            border:none;
            cursor:pointer;

            background:linear-gradient(135deg,#00c853,#009624);

            color:white;
            font-weight:700;

            padding:14px 24px;
            border-radius:14px;

            transition:.25s;
        }

        .nap-btn:hover{
            transform:scale(1.05);
        }

        /* ================= HISTORY ================= */

        .history{
            margin-bottom:18px;
        }

        .history-title{
            color:#666;
            margin-bottom:8px;
            font-size:12px;
        }

        .history-list{
            display:flex;
            flex-wrap:wrap;
            gap:8px;
        }

        .history-item{
            width:34px;
            height:34px;
            border-radius:50%;

            display:flex;
            align-items:center;
            justify-content:center;

            font-size:12px;
            font-weight:700;
        }

        .history-item.tai{
            background:rgba(255,50,100,.2);
            color:var(--red);
            border:1px solid var(--red);
        }

        .history-item.xiu{
            background:rgba(0,255,136,.2);
            color:var(--green);
            border:1px solid var(--green);
        }

        /* ================= GAME CARD ================= */

        .game-card{
            background:#16162a;
            border:1px solid rgba(255,215,0,.16);

            border-radius:24px;

            padding:25px;
            margin-bottom:20px;

            position:relative;
            overflow:hidden;

            box-shadow:0 15px 40px rgba(0,0,0,.45);
        }

        .phase-row{
            display:flex;
            justify-content:space-between;
            align-items:center;

            margin-bottom:20px;
        }

        .phase{
            padding:8px 18px;
            border-radius:50px;

            font-weight:700;
            font-size:13px;
        }

        .phase.bet{
            background:rgba(0,255,136,.1);
            color:var(--green);
            border:1px solid rgba(0,255,136,.3);
        }

        .phase.shake{
            background:rgba(255,215,0,.1);
            color:#FFD700;
            border:1px solid rgba(255,215,0,.3);
        }

        .phase.result{
            background:rgba(255,50,100,.1);
            color:var(--red);
            border:1px solid rgba(255,50,100,.3);
        }

        .timer{
            width:70px;
            height:70px;

            border-radius:50%;

            border:4px solid #FFD700;

            display:flex;
            align-items:center;
            justify-content:center;

            font-size:24px;
            font-weight:700;

            font-family:'Orbitron',sans-serif;
        }

        /* ================= BOWL ================= */

        .scene{
            height:340px;

            position:relative;

            display:flex;
            align-items:center;
            justify-content:center;
        }

        .bowl{
            position:absolute;
            z-index:5;

            transition:.7s;

            transform-origin:center bottom;
        }

        /* LẮC */

        .bowl.shake{
            animation:bowlShake .12s infinite;
        }

        /* MỞ BÁT */

        .bowl.open{
            transform:
                    translateY(-180px)
                    rotate(-16deg)
                    scale(.92);

            opacity:0;
        }

        /* FLOAT */

        .bowl.idle{
            animation:bowlFloat 3s ease-in-out infinite;
        }

        /* FLOAT EFFECT */

        @keyframes bowlFloat{

            0%,100%{
                transform:translateY(0px);
            }

            50%{
                transform:translateY(-6px);
            }
        }

        /* SHAKE EFFECT */

        @keyframes bowlShake{

            0%{
                transform:
                        translateX(-8px)
                        rotate(-6deg);
            }

            50%{
                transform:
                        translateX(8px)
                        rotate(6deg);
            }

            100%{
                transform:
                        translateX(-8px)
                        rotate(-6deg);
            }
        }

        @keyframes shake{
            0%{ transform:translateX(-6px) rotate(-5deg);}
            50%{ transform:translateX(6px) rotate(5deg);}
            100%{ transform:translateX(-6px) rotate(-5deg);}
        }

        /* ================= DICE ================= */

        .dice-wrap{
            position:absolute;

            display:flex;
            gap:16px;

            opacity:0;
            transition:.5s;
        }

        .dice-wrap.show{
            opacity:1;
        }

        .dice{
            width:70px;
            height:70px;

            background:white;
            border-radius:16px;

            position:relative;

            box-shadow:
                    0 10px 25px rgba(0,0,0,.45),
                    inset 0 2px 0 rgba(255,255,255,.9);

            transform:scale(0) rotate(180deg);

            transition:.45s;
        }

        .dice.show{
            transform:scale(1) rotate(0deg);
        }

        .dot{
            width:12px;
            height:12px;

            border-radius:50%;

            background:#d50000;

            position:absolute;
        }

        .p1{top:10px;left:10px;}
        .p2{top:10px;left:50%;transform:translateX(-50%);}
        .p3{top:10px;right:10px;}

        .p4{top:50%;left:10px;transform:translateY(-50%);}
        .p5{top:50%;left:50%;transform:translate(-50%,-50%);}
        .p6{top:50%;right:10px;transform:translateY(-50%);}

        .p7{bottom:10px;left:10px;}
        .p8{bottom:10px;left:50%;transform:translateX(-50%);}
        .p9{bottom:10px;right:10px;}

        /* ================= RESULT ================= */

        .result{
            margin-top:20px;
            text-align:center;
            min-height:120px;
        }

        .sum{
            font-size:62px;
            font-family:'Orbitron',sans-serif;
            font-weight:900;
        }

        .result-label{
            font-size:34px;
            font-weight:900;
            letter-spacing:6px;
        }

        .result-label.tai{
            color:var(--red);
        }

        .result-label.xiu{
            color:var(--green);
        }

        /* ================= BET ================= */

        .bet-panel{
            background:#16162a;
            border:1px solid rgba(255,215,0,.16);

            border-radius:24px;
            padding:22px;
        }

        .bet-choice{
            display:grid;
            grid-template-columns:1fr 1fr;
            gap:16px;

            margin-bottom:18px;
        }

        .choice{
            border:none;
            cursor:pointer;

            border-radius:18px;

            padding:25px;

            color:white;

            transition:.25s;
        }

        .choice:hover{
            transform:translateY(-5px);
        }

        .choice.active{
            transform:scale(1.03);
        }

        .choice.tai{
            background:linear-gradient(135deg,#5e0d1c,#8e102c);
        }

        .choice.xiu{
            background:linear-gradient(135deg,#0d5e3f,#0f8b5c);
        }

        .choice h2{
            font-size:34px;
            font-family:'Orbitron',sans-serif;
        }

        .choice p{
            margin-top:8px;
            color:#ddd;
        }

        .chips{
            display:flex;
            flex-wrap:wrap;
            gap:10px;

            margin-bottom:18px;
        }

        .chip{
            width:65px;
            height:65px;

            border-radius:50%;

            display:flex;
            align-items:center;
            justify-content:center;

            font-weight:700;
            cursor:pointer;

            transition:.25s;
        }

        .chip:hover{
            transform:translateY(-5px) scale(1.05);
        }

        .chip.k5{background:#d32f2f;}
        .chip.k10{background:#1976d2;}
        .chip.k50{background:#00c853;}
        .chip.k100{background:#8e24aa;}
        .chip.k500{background:#ffb300;color:black;}
        .chip.k1m{background:#ff6d00;}

        .bet-input-row{
            display:flex;
            gap:10px;
        }

        .bet-input{
            flex:1;

            background:#0f0f1d;
            border:1px solid rgba(255,255,255,.08);

            border-radius:14px;

            padding:0 18px;

            height:54px;

            color:white;
            font-size:20px;
            font-weight:700;
        }

        .bet-btn{
            border:none;
            cursor:pointer;

            background:linear-gradient(135deg,#FFD700,#ff9800);

            color:black;
            font-weight:900;

            border-radius:14px;

            padding:0 28px;

            font-size:16px;
        }

        /* ================= TOAST ================= */

        .toast{
            position:fixed;

            top:25px;
            left:50%;

            transform:translateX(-50%) translateY(-120px);

            z-index:99999;

            padding:15px 30px;
            border-radius:14px;

            font-weight:700;

            transition:.4s;
        }

        .toast.show{
            transform:translateX(-50%) translateY(0);
        }

        .toast.win{
            background:#00c853;
        }

        .toast.lose{
            background:#d50000;
        }

        .toast.info{
            background:#ff9800;
            color:black;
        }

        @media(max-width:768px){

            .header{
                padding:0 15px;
            }

            .logo{
                font-size:18px;
            }

            .game-title h1{
                font-size:42px;
            }

            .balance-bar{
                flex-direction:column;
                gap:18px;
            }

            .bet-choice{
                grid-template-columns:1fr;
            }

            .bet-input-row{
                flex-direction:column;
            }
        }
    </style>
</head>

<body>

<div class="toast" id="toast"></div>

<!-- HEADER -->
<div class="header">

    <div class="logo">
        SHOP ACC GAME
    </div>

    <a class="back-btn"
       href="home.jsp">

        ← QUAY LẠI HOME

    </a>

    <div class="user-box">
        <% if(loggedIn){ %>
        Xin chào, <span><%= username %></span>
        <% } else { %>
        Khách
        <% } %>
    </div>

</div>

<div class="main">

    <!-- TITLE -->
    <div class="game-title">
        <h1>🎲 TÀI XỈU</h1>
        <p>TRỰC TUYẾN · 3 XÚC XẮC · 1:1</p>
    </div>

    <!-- BALANCE -->
    <div class="balance-bar">

        <div class="balance-left">

            <div class="balance-item">
                <small>Số dư</small>
                <h2 id="balanceEl">
                    <%= String.format("%,d", dbBalance).replace(',', '.') %>
                </h2>
            </div>

            <div class="balance-item">
                <small>Đang cược</small>
                <h3 id="betingEl">0</h3>
            </div>

        </div>

        <button class="nap-btn" onclick="doNap()">
            + Nạp tiền
        </button>

    </div>

    <!-- HISTORY -->
    <div class="history">

        <div class="history-title">
            LỊCH SỬ:
        </div>

        <div class="history-list" id="historyList"></div>

    </div>

    <!-- GAME -->
    <div class="game-card">

        <div class="phase-row">

            <div class="phase bet" id="phaseEl">
                ĐẶT CƯỢC
            </div>

            <div class="timer" id="timerEl">
                20
            </div>

        </div>

        <div class="scene">

            <!-- DICE -->
            <div class="dice-wrap" id="diceWrap">

                <div class="dice" id="dice1"></div>
                <div class="dice" id="dice2"></div>
                <div class="dice" id="dice3"></div>

            </div>

            <!-- BOWL -->
            <div class="bowl" id="bowl">

                <svg width="240"
                     height="200"
                     viewBox="0 0 240 200"
                     xmlns="http://www.w3.org/2000/svg">

                    <defs>

                        <radialGradient id="bowlBody"
                                        cx="40%"
                                        cy="30%"
                                        r="70%">

                            <stop offset="0%"
                                  stop-color="#9B7320"/>

                            <stop offset="50%"
                                  stop-color="#6B4E10"/>

                            <stop offset="100%"
                                  stop-color="#2E2004"/>

                        </radialGradient>

                        <radialGradient id="bowlInside"
                                        cx="50%"
                                        cy="50%"
                                        r="50%">

                            <stop offset="0%"
                                  stop-color="#1c1c1c"/>

                            <stop offset="100%"
                                  stop-color="#080808"/>

                        </radialGradient>

                    </defs>

                    <!-- Shadow -->
                    <ellipse cx="120"
                             cy="175"
                             rx="90"
                             ry="12"
                             fill="rgba(0,0,0,.4)"/>

                    <!-- Body -->
                    <path d="
            M 32 98
            Q 26 162 120 170
            Q 214 162 208 98
            L 197 85
            Q 191 77 120 75
            Q 49 77 43 85
            Z"

                          fill="url(#bowlBody)"
                          stroke="#C8A020"
                          stroke-width="2"/>

                    <!-- Inside -->
                    <path d="
            M 48 98
            Q 44 154 120 162
            Q 196 154 192 98
            L 183 90
            Q 178 84 120 82
            Q 62 84 57 90
            Z"

                          fill="url(#bowlInside)"/>

                    <!-- Top -->
                    <ellipse cx="120"
                             cy="88"
                             rx="82"
                             ry="14"

                             fill="url(#bowlBody)"
                             stroke="#FFD700"
                             stroke-width="2"/>

                    <!-- Handle -->
                    <rect x="106"
                          y="55"
                          width="28"
                          height="24"
                          rx="5"

                          fill="#B8860B"
                          stroke="#FFD700"
                          stroke-width="1.5"/>

                    <ellipse cx="120"
                             cy="75"
                             rx="30"
                             ry="10"

                             fill="#B8860B"
                             stroke="#FFD700"
                             stroke-width="2"/>

                </svg>

            </div>

        </div>

        <!-- RESULT -->
        <div class="result" id="resultEl">
            <div style="color:#666;">
                Đang chờ kết quả...
            </div>
        </div>

    </div>

    <!-- BET -->
    <div class="bet-panel">

        <div class="bet-choice">

            <button class="choice tai" id="taiBtn"
                    onclick="chooseSide('tai')">

                <h2>TÀI</h2>
                <p>11 → 18</p>

            </button>

            <button class="choice xiu" id="xiuBtn"
                    onclick="chooseSide('xiu')">

                <h2>XỈU</h2>
                <p>3 → 10</p>

            </button>

        </div>

        <!-- CHIPS -->
        <div class="chips">

            <div class="chip k5" onclick="addMoney(5000)">5K</div>
            <div class="chip k10" onclick="addMoney(10000)">10K</div>
            <div class="chip k50" onclick="addMoney(50000)">50K</div>
            <div class="chip k100" onclick="addMoney(100000)">100K</div>
            <div class="chip k500" onclick="addMoney(500000)">500K</div>
            <div class="chip k1m" onclick="addMoney(1000000)">1M</div>

        </div>

        <div class="bet-input-row">

            <input
                    type="text"
                    class="bet-input"
                    id="betInput"
                    readonly
                    placeholder="0"
            >

            <button class="bet-btn" onclick="confirmBet()">
                ĐẶT CƯỢC
            </button>

        </div>

    </div>

</div>

<script>

    let balance = <%= dbBalance %>;

    let totalBet = 0;

    let selectedSide = null;

    let historyData = [];

    let timer = 20;

    let phase = 'bet';

    let currentBet = 0;

    let savedBet = {
        side:null,
        amount:0
    };

    const balanceEl = document.getElementById('balanceEl');
    const betingEl = document.getElementById('betingEl');

    const timerEl = document.getElementById('timerEl');

    const phaseEl = document.getElementById('phaseEl');

    const bowl = document.getElementById('bowl');

    const resultEl = document.getElementById('resultEl');

    const historyList = document.getElementById('historyList');

    const diceWrap = document.getElementById('diceWrap');

    const toast = document.getElementById('toast');

    const betInput = document.getElementById('betInput');

    function updateUI(){

        balanceEl.innerText =
            balance.toLocaleString('vi-VN');

        betingEl.innerText =
            totalBet.toLocaleString('vi-VN');

        timerEl.innerText = timer;

        betInput.value =
            currentBet > 0
                ? currentBet.toLocaleString('vi-VN')
                : '';
    }

    function chooseSide(side){

        if(phase !== 'bet') return;

        selectedSide = side;

        document.getElementById('taiBtn')
            .classList.remove('active');

        document.getElementById('xiuBtn')
            .classList.remove('active');

        document.getElementById(side + 'Btn')
            .classList.add('active');
    }

    function addMoney(amount){

        if(phase !== 'bet') return;

        if(!selectedSide){
            showToast('Hãy chọn Tài hoặc Xỉu','info');
            return;
        }

        currentBet += amount;

        updateUI();
    }

    function confirmBet(){

        if(phase !== 'bet') return;

        if(currentBet <= 0){
            showToast('Nhập tiền cược','info');
            return;
        }

        if(balance < currentBet){
            showToast('Không đủ số dư','lose');
            return;
        }

        balance -= currentBet;

        totalBet = currentBet;

        savedBet.side = selectedSide;
        savedBet.amount = currentBet;

        currentBet = 0;

        updateUI();

        showToast('Đặt cược thành công','win');
    }

    function startGameLoop(){

        let loop = setInterval(()=>{

            timer--;

            updateUI();

            if(timer <= 0){

                clearInterval(loop);

                if(phase === 'bet'){
                    startShake();
                }
                else{
                    resetGame();
                }
            }

        },1000);
    }

    function startShake(){

        phase = 'shake';

        phaseEl.innerText = 'ĐANG LẮC';
        phaseEl.className = 'phase shake';

        bowl.classList.add('shake');

        timer = 3;

        updateUI();

        setTimeout(()=>{

            bowl.classList.remove('shake');

            revealResult();

        },3000);
    }

    function revealResult(){

        phase = 'result';

        phaseEl.innerText = 'KẾT QUẢ';
        phaseEl.className = 'phase result';

        bowl.classList.add('open');

        // ====== 3 XÚC XẮC THẬT ======

        let dice1 = Math.floor(Math.random() * 6) + 1;
        let dice2 = Math.floor(Math.random() * 6) + 1;
        let dice3 = Math.floor(Math.random() * 6) + 1;

        let sum = dice1 + dice2 + dice3;

        let result =
            sum >= 11
                ? 'tai'
                : 'xiu';

        // ====== HIỆN XÚC XẮC ======

        renderDice('dice1', dice1);
        renderDice('dice2', dice2);
        renderDice('dice3', dice3);

        diceWrap.classList.add('show');

        setTimeout(()=>{

            document.querySelectorAll('.dice')
                .forEach(x=>x.classList.add('show'));

        },100);

        // ====== RESULT ======

        resultEl.innerHTML = `
            <div class="sum">${sum}</div>

            <div class="result-label ${result}">
                ${result.toUpperCase()}
            </div>

            <div style="margin-top:12px;font-size:18px;">
                🎲 ${dice1} - ${dice2} - ${dice3}
            </div>
        `;

        // ====== LOGIC 3 XÚC XẮC ======

        /*
            XỈU = 4 -> 10
            TÀI = 11 -> 17

            Bộ ba:
            111 / 222 / 333 / 444 / 555 / 666
            => nhà cái ăn
         */

        let isTriple =
            dice1 === dice2 &&
            dice2 === dice3;

        if(isTriple){

            resultEl.innerHTML += `
                <div style="
                    margin-top:10px;
                    color:#FFD700;
                    font-weight:700;
                ">
                    ⚠ BỘ BA - NHÀ CÁI ĂN
                </div>
            `;
        }

        // ====== PAYOUT ======

        if(savedBet.amount > 0){

            if(!isTriple && savedBet.side === result){

                let winMoney =
                    savedBet.amount * 2;

                balance += winMoney;

                showToast(
                    '+' +
                    winMoney.toLocaleString('vi-VN') +
                    '₫',
                    'win'
                );

            }else{

                showToast(
                    'Bạn đã thua',
                    'lose'
                );
            }
        }

        // ====== HISTORY ======

        historyData.push(result);

        if(historyData.length > 12){
            historyData.shift();
        }

        historyList.innerHTML =
            historyData.map(function(x){

                return `
            <div class="history-item ` + x + `">
                ` + (x === 'tai' ? 'T' : 'X') + `
            </div>
        `;

            }).join('');

        updateUI();

        timer = 5;

        startGameLoop();
    }

    function resetGame(){

        phase = 'bet';

        phaseEl.innerText = 'ĐẶT CƯỢC';
        phaseEl.className = 'phase bet';

        timer = 20;

        totalBet = 0;

        savedBet = {
            side:null,
            amount:0
        };

        currentBet = 0;

        selectedSide = null;

        document.getElementById('taiBtn')
            .classList.remove('active');

        document.getElementById('xiuBtn')
            .classList.remove('active');

        bowl.className = 'bowl';

        diceWrap.classList.remove('show');

        document.querySelectorAll('.dice')
            .forEach(x=>{
                x.classList.remove('show');
                x.innerHTML = '';
            });

        resultEl.innerHTML = `
            <div style="color:#666;">
                Đang chờ kết quả...
            </div>
        `;

        updateUI();

        startGameLoop();
    }

    function renderDice(id, value){

        const dice =
            document.getElementById(id);

        dice.innerHTML = '';

        const map = {

            1:['p5'],

            2:['p1','p9'],

            3:['p1','p5','p9'],

            4:['p1','p3','p7','p9'],

            5:['p1','p3','p5','p7','p9'],

            6:['p1','p3','p4','p6','p7','p9']
        };

        map[value].forEach(pos=>{

            const dot =
                document.createElement('div');

            dot.className =
                'dot ' + pos;

            dice.appendChild(dot);
        });
    }

    function showToast(msg,type){

        toast.innerText = msg;

        toast.className =
            'toast show ' + type;

        setTimeout(()=>{
            toast.className = 'toast';
        },2500);
    }

    function doNap(){

        alert(
            'Chức năng nạp tiền sẽ kết nối server sau'
        );
    }

    // START
    updateUI();
    startGameLoop();

</script>

</body>
</html>