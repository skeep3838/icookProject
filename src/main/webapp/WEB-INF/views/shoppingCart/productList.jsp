<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"
	import="com.icook.model.ProductTypeBean"
	import="com.icook.model.ProductBean"
%>
	
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>市集</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/css/bootstrap.css"
	rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/css/shoppingCart.css"
	rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/css/jquery-ui.css"
	rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <style>
  .Block_shadow:hover {
       /* 加粗的陰影外框 */
        -moz-box-shadow: 0 0 2px 2px #888;
        -webkit-box-shadow: 0 0 2px 2px #888;
        box-shadow: 0 0 2px 2px #5599FF;
        width:26%;
        border-color:#5599FF !important;
/*         設定hover的變更速度,格式:指定元素    秒數 */
        transition:width 1s;
/*         background-color:#5599FF; */
}
  div >.hoverProdImg:hover {
  		border:solid 1px #5599FF !important;
/*         設定hover的變更速度,格式:指定元素    秒數 */
/*         transition:width 1s; */
/*         background-color:#5599FF; */
}
  fieldset {
      border: 0;
  }
  label {
    display: block;
    margin: 30px 0 0 0;
  }
  .overflow {
	height: 200px;
  }
    
      
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
    width: 70%;
    margin: auto;
}
  </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/fragment/TopNav.jsp" />
	
	
	<!-- 搜尋功能 -->
	<div class="container align-items-center">
		<fieldset>
			<form  method="GET" action="productList" class="form-horizontal" style="text-align: center">
				<div class="form-group row">
				<input class="form-control" type="text" id="productName"
					placeholder="請輸入關鍵字" aria-label="Search" name="productName"/>
				&nbsp;&nbsp;<button class="btnSearch btn btn-outline-success">Search</button>
				</div>
			</form>
		</fieldset>
	</div>


<div class="prosDiv container-fluid">
	<fieldset>
		<c:forEach items="${prosList}" var="pros" varStatus="vs">
			<c:set var="prodsSet" value="${pros.type}"></c:set>
<!-- 			proCount是紀錄商品數量,並作為外部索引代號 -->
			<c:set var="proCount" value="${proCount+1}" />
<!-- 			ImgList = {圖片陣列1(產品1),圖片陣列2(產品2),圖片陣列3(產品2),....圖片陣列n} -->
			<c:set var="imgArray" value="${ImgList[vs.index]}"></c:set>
			<div  class="products col-md-3 Block_shadow" style="background-color:#ffefd0;border:solid 1px;margin:3px;padding:1rem;text-align:center;" id="divTop${proCount}">
				<p><img width="200px" height="200px"  src="${pageContext.request.contextPath}/${imgArray[vs.index]}"></img></p>
<%-- 				<p>${pros.productName}</p> --%>	
				<p>${pros.productName}</p>
    			
    				<button name="cmd" id="press${proCount}" class="addToCar btn btn-primary">
							Add To Car
					</button>
 					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal${proCount}">詳細資訊</button>

				</div>
				

 					<!-- Modal商品明細  可加入aria-hidden="true" data-backdrop="static"設定後,只能用[X]or Close來關閉Modal --> 
  				<div class="modal fade myModal" id="myModal${proCount}" role="dialog">
    				<div class="modal-dialog">	
    				  <c:set var="imgArrayType" value="${ImgList[vs.index]}"></c:set>
					  
					  <c:forEach items="${prodsSet}" var="pbt" varStatus="vs2">
					  
					  <!-- 	proCount是紀錄商品總數量(含款式),並作為索引代號 -->
						<c:set var="proContentCount" value="${proContentCount+1}" />
					  
					  	<c:forEach items="${prodsSet}" var="pbts" varStatus="vs3">
					 	 <!-- 	typeCount是紀錄每項商品有幾種款式 -->
								<c:set var="typeCount" value="${vs3.count}" />
					  	</c:forEach>
					  	<!-- 	取得每項商品款式數量 -->		
						<input type="hidden" id="typeCount${proCount}" value="${typeCount}"/>
					  	
      					<!-- Modal content商品明細內容-->
      					<div class="modal-content modalContent" id="modalContent${proContentCount}">
        					<div class="modal-header">
          						<button type="button" class="close" data-dismiss="modal">&times;</button>
          						<h4 class="modal-title">${pros.productName}(${pbt.typeTitle})</h4>
        					</div>
        					<div class="modal-body" data-ride="carousel">
<!--         						<div id="myCarousel" class="" data-ride="carousel"> -->
 								<!-- Wrapper for slides -->
<!--     							<div class="carousel-inner" role="listbox"> -->
								
      								<div class="item">
      									<div class="proPicture" style="float:left;width:60%;">
      										<div class="targetImg" id="targetImg${proContentCount}" style="text-align:center;">
<%--       											<img src="${pageContext.request.contextPath}/${imgArray[0]}" width="200px"> --%>
      										</div>
      										<!-- picCount是紀錄圖片數量,並作為索引代號 -->
											<c:set var="picCount" value="${picCount+1}" />
      										<c:forEach items="${imgArray}" var="prodImg" varStatus="vsImg">
      											<input type="hidden" id="testImggg${picCount+vsImg.index}" value="${prodImg}"/>
        										<div class="hoverProdImg" id="prodImg${picCount+vsImg.index}" style="float:left;margin:2px;">
        											<img class="smallImg" id="smallImg${picCount+vsImg.index}" src="${pageContext.request.contextPath}/${prodImg}" width="100px">
      											</div>
      										</c:forEach>
      									</div>
      									<div class="proContent" style="float:right;width:40%;">
      										<div class="dropdown">
  						    					<select class="proSelect${proCount}" id="proSelect${proCount}" name="proSelect">
												</select>
											</div>
<!--       										<div class="dropdown"> -->
<!--   												<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Type -->
<!--   												<span class="caret"></span></button> -->
<!--   												<ul class="dropdown-menu proType"> -->
<!--    													<li class="active"><a href="#modalContent1">TypeA</a></li> -->
<!--     												<li><a href="#modalContent2">TypeB</a></li> -->
<!--     												<li><a href="#modalContent3">TypeC</a></li> -->
<!--   												</ul> -->
<!-- 											</div> -->
      										<c:choose>
												<c:when test="${empty pbt.discount}">
													<h4>價格:${pbt.unitPrice}</h4>
   												</c:when>
												<c:when test="${pbt.discount==1}">
													<h4>價格:${pbt.unitPrice}</h4>
   												</c:when>
 												<c:otherwise>
   													<p><h3 style="color:red;">優惠價:<fmt:formatNumber pattern="#0" value="${pbt.unitPrice*pbt.discount}" type="currency" /></h3></p>
													<p><h4 style="text-decoration:line-through;">原價:${pbt.unitPrice}</h4></p>
   												</c:otherwise>
   											</c:choose>
   											<p><input style="margin:5px;" type="number" class="products${proContentCount} quantity${proContentCount}" id="qty${proContentCount}" value="1" min="1" max="99" /></p>
   											<p>庫存${pbt.unitStock}</p>
   											<button name="cmd" id="press${proContentCount}" class="addToCar btn btn-primary">
												Add To Car
											</button>
						                    <input type="hidden" class="products${proContentCount}" id="productId${proContentCount}" name="productId" value="${pros.productID}" />
						                    <input type="hidden" class="products${proContentCount}" id="productName${proContentCount}" name="productName" value="${pros.productName}" />
						                    <input type="hidden" class="products${proContentCount}" id="typeId${proContentCount}"  name="typeId" value="${pbt.typeID}" />
						                    <input type="hidden" class="products${proContentCount}" id="typeTitle${proContentCount}"  name="typeTitle" value="${pbt.typeTitle}" />
						                    <input type="hidden" class="products${proContentCount}" id="image1${proContentCount}"  name="image1" value="${pros.image1}" />
						                    <input type="hidden" class="products${proContentCount}" id="unitPrice${proContentCount}"  name="unitPrice" value="${pbt.unitPrice}" />
						                    <input type="hidden" class="products${proContentCount}" id="describe${proContentCount}"  name="describe" value="${pros.productName}(${pbt.typeTitle})" />
						                    <input type="hidden" class="products${proContentCount}" id="discount${proContentCount}"  name="discount" value="${pbt.discount}" />   					
      									</div>
      								</div>
      							
<!--     							</div> -->
    													
<!--         					</div> -->
        					</div>
        					<div class="modal-footer">
          						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        					</div>
      					</div>
      				  </c:forEach>
      				</div>

			</div>				
			
		</c:forEach>
	</fieldset>
</div>
<div class="container containerPage">
  		<h2 style="margin:20px; text-align:center;">有<c:out value="${proCount}"/>件商品</h2>                
  		<h2 style="margin:20px; text-align:center;">有<c:out value="${picCount}"/>張商品圖</h2>                
<!--   		<h3 style="text-align:center;">每頁&nbsp; -->
<!--   			<select class="selectCountPage" id="selectCountPage"> -->
<!--   				<option>4</option> -->
<!--   				<option selected>8</option> -->
<!--   				<option>12</option> -->
<!--   				<option>36</option> -->
<!--   			</select>項商品 &nbsp; -->
<!--   		到第&nbsp;<select class="selectPage" id="selectPage"></select>&nbsp;頁</h3> -->
  		<ul class="pager"></ul>
</div>
<input type="hidden" id="pageContext" value="${pageContext.request.contextPath}">
<input type="hidden" id="proCount" value="${proCount}">
<div class="container" id="setMap"></div>
<!-- for bootstrap working -->
<!-- 放到head會導致modal無法使用 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/productList.js">
</script>
</body>
</html>
