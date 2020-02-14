<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="UTF-8">
<head>
<!-- 卡車套版 -->
<script type="application/x-javascript">
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
			function hideURLbar(){ window.scrollTo(0,1); } 


</script>
<link href="${pageContext.request.contextPath}/css/bootstrap.css"
	rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet" type="text/css" media="all" />
<link
	href='//fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>
<link
	href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- //卡車套版 -->
<style>
#reddiv {
	/* background-color: crimson; */
	/* 1. 試試看在這裡，加入三個屬性設定，可以模仿網頁上，將圖片固定在右下角? */
	/* 2. 在這邊設定一張圖片並調整大小 */
	width: 70px;
	height: 70px;
	position: fixed;
	right: 10px;
	bottom: 85px;
	border-radius: 50%;
	background-color: white;
	background-image:
		url("${pageContext.request.contextPath}/images/icook-logo.png");
	/* background-size: contain; */
	background-size: 100%;
	background-repeat: no-repeat;
	z-index: 1;
}

.messagetemp {
	border-radius: 37px 37px 37px 37px;
	-moz-border-radius: 37px 37px 37px 37px;
	-webkit-border-radius: 37px 37px 37px 37px;
	border: 0px solid #e6e6e6;
	background-color: #e6e6e6;
	margin-top: 0.5px;
	width: 50%;
	height: 50%;
	word-wrap: break-word;
	display: inline-block !important;
	display: inline;
}

#messagetemp {
	width: 85%;
	margin-top: 11px;
	margin-bottom: 11px;
	margin-left: 14px;
	font-family: Microsoft JhengHei;
	font-size: 15px;
}

#text {
	width: 75%;
	padding: 6px;
	border: 1px solid #ccc;
	border-radius: 4px;
	resize: vertical;
}

#sendbutton {
	color: black;
	padding: 8px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	background-color: #e6e6e6;
}

#sendmessage {
	margin-top: 10px;
}
</style>
</head>

<body>
	<header>
		<div id="dialog_div_reddiv" title="客戶問題"></div>
		<div class="header">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<!-- 確定一下網頁名稱 -->
					<div class="logo">
						<a class="navbar-brand" href=<c:url value='/' />> <img
							alt="首頁"
							src="${pageContext.request.contextPath}/css/images/Logo.jpg"
							height=50px;>
						</a>
						<!-- 							<h1><a class="navbar-brand" href=<c:url value='/' />>iCook</a></h1> -->
					</div>
				</div>
				<div class="w3l_header_right">
					<c:choose>
						<c:when test="${empty LoginOK}">
							<ul>
								<li><a href=<c:url value='/login/loginView'/>
									style="margin: 10px" onclick="closeWebSocket()"><span
										class="glyphicon glyphicon-user" aria-hidden="true"></span>登入</a></li>
								<li><a href=<c:url value='/SignUp/memberSignUp' />
									style="margin: 10px"><span class="glyphicon glyphicon-user"
										aria-hidden="true"></span>註冊</a></li>
							</ul>
						</c:when>
						<c:otherwise>
							<div id='reddiv' onclick="sendMessage('${LoginOK.nickname}',${LoginOK.userId})"></div>
							<ul>
                                <li style="width:50px; height:60px;"><img style="border-radius: 50%;border: 1px solid rgba(255,0,0,1.00);" src="<c:url value='/getPicMem/${LoginOK.userId}' />" alt=" " class="img-responsive"/></li>
								<li><h4>Hello, ${LoginOK.nickname} !!</h4>
								<li><a href=<c:url value='/login/logout'/>
									style="margin: 10px"><span class="glyphicon glyphicon-user"
										aria-hidden="true"></span>登出</a></li>
								<li><a href=<c:url value='/SignUp/memUpdate'/>
									style="margin: 10px"><span class="glyphicon glyphicon-user"
										aria-hidden="true"></span>會員資料</a></li>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
		<c:choose>
			<c:when test="${!empty LoginOK}">
				<div class="logo_nav">
					<div class="container">
						<nav class="navbar navbar-default">
							<!-- Brand and toggle get grouped for better mobile display -->
							<!-- 					<div class="navbar-header"> -->
							<!-- 					  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> -->
							<!-- 						<span class="sr-only">Toggle navigation</span> -->
							<!-- 						<span class="icon-bar"></span> -->
							<!-- 						<span class="icon-bar"></span> -->
							<!-- 						<span class="icon-bar"></span> -->
							<!-- 					  </button> -->
							<!-- 					  確定一下網頁名稱 -->
							<!-- 						<div class="logo"> -->
							<!-- 							<h1><a class="navbar-brand">i<span>c</span>ook</a></h1> -->
							<!-- 						</div> -->
							<!-- 					</div> -->
							<!-- Collect the nav links, forms, and other content for toggling -->
							<div class="collapse navbar-collapse nav-wil"
								id="bs-example-navbar-collapse-1">
								<nav class="link-effect-2 fixed-top" id="link-effect-2">
									<ul class="nav navbar-nav">
										<li class="active"><a href=<c:url value='/' />><span
												data-hover="Home">首頁</span></a></li>
										<li><a
											href=<c:url value='/recipes/list?userId=${LoginOK.userId}' />><span
												data-hover="Recipe">會員食譜列表</span></a></li>
										<li><a href=<c:url value='/shoppingCart/productList' />><span
												data-hover="Market">市集</span></a></li>
										<li><a href=<c:url value='/MyOrders/Orders?page=1'/>><span
												data-hover="Order">訂單</span></a></li>
										<li><a href=<c:url value='/shoppingCart/shopCart' />><span
												data-hover="Car">購物車<span class="badge" id="cartNo"></span></span></a></li>
										<li><a href=<c:url value='/course/courseHomePage' />><span
												data-hover="Course">課程</span></a></li>
										<li><a href=<c:url value='/helpQuestion' />><span
												data-hover="Help">聯絡我們</span></a></li>
									</ul>
								</nav>
							</div>
							<!-- /.navbar-collapse -->
						</nav>
					</div>
				</div>
			</c:when>
		</c:choose>
		<!-- 	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->
		<%-- 	<script type="text/javascript" src="<c:url value='/WEB-INF/views/js/jquery-2.1.4.min.js' />"></script> --%>
	</header>
	<!-- //header -->
</body>
<script>
	$(document).ready(function() {
		$("#cartNo").text("${ShoppingCart.itemNumber}");
	})
	function getRealPath() {
				var curWwwPath = window.document.location.href;
				var pathName = window.document.location.pathname;
				var projectName = pathName.substring(1, pathName.substr(1).indexOf('/') + 1);
				return projectName;
			}
	
	var websocket = null;
	function sendMessage(nickname,userId) {
		//判断当前浏览器是否支持WebSocket
		if ('WebSocket' in window) {
			websocket = new WebSocket(
					"ws://localhost:8080/icookBackstage02035/websocket");
		} else {
			alert('当前浏览器 Not support websocket')
		}

		//连接发生错误的回调方法
		websocket.onerror = function() {
			setMessageInnerHTML("WebSocket连接发生错误");
		};

		//连接成功建立的回调方法
		websocket.onopen = function() {
		}

		//接收到消息的回调方法
		websocket.onmessage = function(event) {
			var message = JSON.parse(event.data);
			if(message.type === "客戶") {
				setMessageInnerHTML(message.text, message.name);
			}
			else {
				setMessageInnerHTML(message.text, message.name);
			}
		}

		//连接关闭的回调方法
		websocket.onclose = function() {
		}

		//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
		window.onbeforeunload = function() {
			closeWebSocket();
		}

		var temp = "<div id='sendmessage'><input type='text' id='text' placeholder=''><button id='sendbutton' onclick=\"send("+ userId +",'"+ nickname +"')\" type='button'>傳送</button></div> <hr/><div id='message'>";
		// 		    var temp = "<input id='text' type='text'/><button onclick='send()'>傳送</button><hr/><div id='message'>"
		$("#dialog_div_reddiv").html(temp);
		$("#dialog_div_reddiv").dialog("open");
	}

	$(function() {
		$("#dialog_div_reddiv").dialog({
			//固定視窗
			maxHeight : 510,
			maxWidth : 370,
			minHeight : 510,
			minWidth : 370,
			position : {
				my : "center",
				at : "left+1800px top+550px",
				of : window
			},
			//拖移設定
			draggable : true,
			//dialog建立自動開啟設定
			autoOpen : false,
			//視窗外無法操作設定
			modal : false,
			//open事件發生時, 將dialog樣式右上的x顯示
			open : function(event, ui) {
				$(".ui-dialog-titlebar-close").show();
			},
		// 			        buttons: {
		// 			            "發送": function() {
		// 			            	send();
		// 			            }
		// 			        }
		});
	});
	//关闭WebSocket连接
	function closeWebSocket() {
		websocket.close();
	}

	//发送消息
	function send(userId,nickname) {
		var message = document.getElementById('text').value;
		saveMessage(userId,message);
		var msg = {
			    text: message,
			    id: userId,
			    name: nickname,
			    type: "客戶"
			  };
		websocket.send(JSON.stringify(msg));
	}
	function saveMessage(userId,message) {
		var packageName = getRealPath();
		$.ajax({
			type : "GET",
			url : "/" + packageName + "/WebSocket",
			data:{ Message: message , Id : userId },
			dataType : "text",
			success : function(data) {
			},
			error : function(error) {
			},
		});
	}
	//将消息显示在网页上
	function setMessageInnerHTML(innerHTML, nickname) {
		// 	        document.getElementById('message').innerHTML += nickname + "<br><div class='messagetemp'><div id='messagetemp'>" + innerHTML + "</div></div><br/><br>";
		$("#message").prepend(nickname + "<br><div class='messagetemp'><div id='messagetemp'>" + innerHTML + "</div></div><br/><br>");
	}
</script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>