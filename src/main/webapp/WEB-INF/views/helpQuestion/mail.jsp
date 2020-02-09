<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="UTF-8">
<title>愛料理首頁</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Truckage Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />

<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
			function hideURLbar(){ window.scrollTo(0,1); } 
</script>
<!-- //for-mobile-apps ${pageContext.request.contextPath}-->
<link href="${pageContext.request.contextPath}/css/bootstrap.css"
	rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet" type="text/css" media="all" />
<!-- js -->
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<!-- //js -->
<!-- load-more -->

<!-- //load-more -->
<link
	href='//fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>
<link
	href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic'
	rel='stylesheet' type='text/css'>

</head>
<body>
	<!-- header -->
	<jsp:include page="/WEB-INF/views/fragment/TopNav.jsp" />

	<div class="services-breadcrumb">
		<div class="container">
			<ul>
				<li><a href="index.html">Home</a><i>|</i></li>
				<li>Mail Us</li>
			</ul>
		</div>
	</div>
	<!-- //banner1 -->

	<!-- mail -->
	<div class="mail">
		<div class="container">
			<h3>聯絡我們</h3>

			<div class="col-md-10 wthree_contact_left"
				style="padding: 0 200px 0 200px; width: 100%">
				<br>
				<br>
				<form action="<c:url value='/sendQuestion'/>" method="post" id="commontForm">
					<div class="col-md-6 wthree_contact_left_grid">
						<input type="text" name="Email" value="Email*"
							class="email"
							onfocus="this.value = '';"
							onblur="checkmail()" required=""/>
					</div>
					<div class="col-md-6 wthree_contact_left_grid">
						<input type="text" name="Title" value="Title*"
							class="required "
							onfocus="this.value = '';"
							onblur="" required=""/>
					</div>
					<div class="clearfix"></div>
					<textarea name="Message" onfocus="this.value = '';"
						onblur="if (this.value == '') {this.value = 'Message...';}"
						required="" >Message...</textarea>
					<input class="submit" type="submit" value="提交"> 
					<input type="reset" value="清除">
				</form>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	<!-- //mail -->
	<!-- footer -->
	
	<!-- //footer -->
	<!-- for bootstrap working -->
	<script>
	$().ready(function() {
		$("#commontForm").validate();
	})
		function checkmail() {
			var e = document.getElementsByName('Email').value;
// 			if (!/(\S)+[@]{1}(\S)+[.]{1}(\w)+/.test(e)) {
// 				alert("请输入格式正确的 e-mail 地址！");
// 			}

// 			if(e.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)!= -1){
// 			    alert("true");
// 			}else{
// 			    alert("false");
// 			}​
//  		}
	</script>
	<!-- //for bootstrap working -->



</body>
</html>