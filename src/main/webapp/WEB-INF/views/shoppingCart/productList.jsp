<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"
	import="com.icook.model.ProductTypeBean"
	import="com.icook.model.ProductBean"
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
  /*滑入商品圖的效果*/
  .block_effect:hover {
       /* 加粗的陰影外框 */
       opacity: 0.6; /*o透明度*/
       transition:opacity 0.5s;/*s設定hover的變更速度,格式:指定元素    秒數 */
/*        I陰影外框設定 */
/*         -moz-box-shadow: 0 0 2px 2px #888; */
/*         -webkit-box-shadow: 0 0 2px 2px #888; */
/*         box-shadow: 0 0 2px 2px #5599FF; */
/*         border-color:#5599FF !important; */

/*         width:26%; */
/*         transition:width 1s; */
	}
   .text_decribe{
   		opacity: 0.6; /*o透明度*/
   }
   .text_decribe2{
   		opacity: 0.7; /*o透明度*/
   }
   
   /*輪播圖置中*/
   .carousel-inner > .item > img{
      width: 80%;
      margin: auto;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/fragment/TopNav.jsp" />
	
	
<div class="container align-items-center coverflow">
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
  	<!-- Indicators -->
       <ol class="carousel-indicators">
         <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
         <li data-target="#myCarousel" data-slide-to="1"></li>
         <li data-target="#myCarousel" data-slide-to="2"></li>
       </ol>

       <!-- Wrapper for slides -->
       <div class="carousel-inner">
         <div class="item myModal active" 
         	  data-toggle="modal" data-target="#myModal4"
         	  style="cursor:pointer;">
           <img class="topImg" 
           		src="${pageContext.request.contextPath}/images/coffee_pot000.jpg"/>
         </div>
         <div class="item myModal" 
         	  data-toggle="modal" data-target="#myModal5"
         	  style="cursor:pointer;">
           <img class="topImg"
           		src="${pageContext.request.contextPath}/images/steak000.jpg"/>
         </div>
         <div class="item myModal" 
         	  data-toggle="modal" data-target="#myModal6"
         	  style="cursor:pointer;">
           <img class="topImg" 
           		src="${pageContext.request.contextPath}/images/Baking_home_appliances000.jpg"/>
         </div>
       </div>

       <!-- Left and right controls -->
       <a class="left carousel-control" href="#myCarousel" data-slide="prev">
         <span class="glyphicon glyphicon-chevron-left"></span>
         <span class="sr-only">Previous</span>
       </a>
       <a class="right carousel-control" href="#myCarousel" data-slide="next">
         <span class="glyphicon glyphicon-chevron-right"></span>
         <span class="sr-only">Next</span>
       </a>
	</div>		
	
<!-- 搜尋功能 -->
		<fieldset>
			<form  method="GET" action="productList" class="form-horizontal" style="text-align: center">
				<div class="form-group row" style="margin:5px;">
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
<!-- 	border:solid 1px;background-color:#ffefd0; -->
			<div  class="products myModal col-md-3 block_effect" 
				  data-toggle="modal" data-target="#myModal${proCount}"
				  style="width:400px;height:300px;margin:3px;padding:1rem;text-align:center;cursor:pointer;" 
				   id="divTop${proCount}">
		     	<p>${pros.productID}</p>
		     	<p>
      			<c:choose>
      				<c:when test="${pros.productID==4}">
					    <c:choose>
      						<c:when test="${fn:substring(imgArray[3], 0, 4)=='http'}">
								<img class="img-rounded block_effect" width="300px" height="200px"  
						     	src="${imgArray[3]}"></img>
      						</c:when>
      						<c:otherwise>
								<img class="img-rounded block_effect" width="300px" height="200px"  
						     	src="${pageContext.request.contextPath}/${imgArray[3]}"></img>
      						</c:otherwise>
      					</c:choose>	
      				</c:when>
      				<c:when test="${pros.productID==5}">
					    <c:choose>
      						<c:when test="${fn:substring(imgArray[4], 0, 4)=='http'}">
								<img class="img-rounded block_effect" width="300px" height="200px"  
						     	src="${imgArray[4]}"></img>
      						</c:when>
      						<c:otherwise>
								<img class="img-rounded block_effect" width="300px" height="200px"  
						     	src="${pageContext.request.contextPath}/${imgArray[4]}"></img>
      						</c:otherwise>
      					</c:choose>	
      				</c:when>
      				<c:otherwise>
      					<c:choose>
      						<c:when test="${fn:substring(imgArray[0], 0, 4)=='http'}">
								<img class="img-rounded block_effect" width="300px" height="200px"  
						     	src="${imgArray[0]}"></img>
      						</c:when>
      						<c:otherwise>
								<img class="img-rounded block_effect" width="300px" height="200px"  
						     	src="${pageContext.request.contextPath}/${imgArray[0]}"></img>
      						</c:otherwise>
      					</c:choose>	
      				</c:otherwise>
      			</c:choose>		     	
				</p>
<%-- 				<p>${pros.productName}</p> --%>	
				<p><h3>${pros.productName}</h3></p>
				      			<c:choose>
      				<c:when test="${pros.productID==1}">
						<p class="text_decribe">肉質紮實，纖維細膩，一吃就知道！</p>
      				</c:when>
      				<c:when test="${pros.productID==2}">
						<p class="text_decribe">煎 煮 炒 炸 蒸 一鍋搞定！</p>
      				</c:when>
      				<c:when test="${pros.productID==3}">
						<p class="text_decribe">嚴選高山高麗菜，鮮甜脆感十足。</p>
      				</c:when>
      				<c:when test="${pros.productID==4}">
						<p class="text_decribe">有溫度的手沖壺，攜帶輕便，隨處展現屬於你的簡約時尚。</p>
      				</c:when>
      				<c:when test="${pros.productID==5}">
						<p class="text_decribe">嚴選草飼牛 低脂低熱量 低膽固醇。</p>
      				</c:when>
      				<c:when test="${pros.productID==6}">
      					<p class="text_decribe">皮卡丘、米奇圖案三明治與鬆餅機，輕鬆手作專屬點心！讓你享受烹飪的樂趣，為生活增添色彩。</p>
      				</c:when>
      				<c:otherwise>
						<p class="text_decribe"></p>
      				</c:otherwise>
      			</c:choose>
    			
<%--     				<button name="cmd" id="press${proCount}" class="addToCar btn btn-primary"> --%>
<!-- 							Add To Car -->
<!-- 					</button> -->
<%--  					<button type="button" class="myModal btn btn-primary" data-toggle="modal" data-target="#myModal${proCount}"> --%>
<!--  						詳細資訊 -->
<!--  					</button> -->
<%-- 					購買數量<p><input style="margin:5px;" type="number" class="products${proCount} quantity${proCount}" id="qty${proCount}" value="1" min="1" max="99" /></p> --%>
				</div>
				

 					<!-- Modal商品卡  可加入aria-hidden="true" data-backdrop="static"設定後,只能用[X]or Close來關閉Modal --> 
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
					  	
      					<!-- Modal content商品卡內容-->
      					<div class="modal-content modalContent" id="modalContent${proContentCount}" style="height:800px;">
        					<div class="modal-header" style="text-align:center;">
          						<button type="button" class="close"data-dismiss="modal">&times;</button>
          						<h4 class="modal-title">${pros.productName}(${pbt.typeTitle})</h4>
        					</div>
        					<div class="modal-body" data-ride="carousel" style="height:600px">
      								<div class="item">
      									<div class="proPicture" style="float:left;width:60%;">
      										<div class="targetImg block_effect" id="targetImg${proContentCount}" style="height:300px;text-align:center;">
      											<c:choose>
      												<c:when test="${empty imgArray[vs2.index]}">
						                                <c:choose>
      					                                   <c:when test="${fn:substring(imgArray[0], 0, 4)=='http'}">
																<img class="img-rounded block_effect" 
																	src="${imgArray[0]}" 
																	width="300px" height="200px">
      					                                   </c:when>
      					                                   <c:otherwise>
																<img class="img-rounded block_effect" 
																	src="${pageContext.request.contextPath}/${imgArray[0]}" 
																	width="300px" height="200px">
      					                                   </c:otherwise>
      					                                </c:choose>		
      												</c:when>
      												<c:otherwise>
														<c:choose>
      					                                   <c:when test="${fn:substring(imgArray[0], 0, 4)=='http'}">
																<img class="img-rounded" 
																	src="${imgArray[vs2.index]}" 
																	width="300px" height="200px">
      					                                   </c:when>
      					                                   <c:otherwise>
																<img class="img-rounded" 
																	src="${pageContext.request.contextPath}/${imgArray[vs2.index]}" 
																	width="300px" height="200px">
      					                                   </c:otherwise>
      					                                </c:choose>
      												</c:otherwise>
      											</c:choose>
      										<br><br>
      										<div>
      											<p><h5>【商品資訊】</h5></p>
      											<p class="text_decribe2">${pros.productInfo}</p>
      										</div>
      										</div>
      										<!-- picCount是紀錄圖片數量,並作為索引代號 -->
											<c:set var="picCount" value="${picCount+1}" />
      										<c:forEach items="${imgArray}" var="prodImg" varStatus="vsImg">
      											<input type="hidden" id="testImggg${picCount}" value="${prodImg}"/>
        										<div class="smallImgBox block_effect" id="prodImg${picCount}" style="float:left;margin:2px;cursor:pointer;">
        											<img class="smallImg img-rounded"  id="smallImg${picCount}" src="${pageContext.request.contextPath}/${prodImg}" width="100px">
      											</div>
      										</c:forEach>
      									</div>
      									<div class="proContent" style="float:right;width:40%;">
      										<section>
      											<div class="dropdown">
      												<h5>【款式】</h5>
  						    						<select class="proSelect${proCount}" id="proSelect${proCount}" name="proSelect"
  						    						    style="font-size:10pt;">
													</select>
												</div>
      										</section>
      										<section>
      										<c:choose>
												<c:when test="${empty pbt.discount}">
													<h4>價格:${pbt.unitPrice}</h4>
   												</c:when>
												<c:when test="${pbt.discount==1}">
													<h4>價格:${pbt.unitPrice}</h4>
   												</c:when>
 												<c:otherwise>
   													<p style="color:red;">優惠價:<fmt:formatNumber pattern="#0" value="${pbt.unitPrice*pbt.discount}" type="currency" /></p>
													<p style="text-decoration:line-through;">原價:${pbt.unitPrice}</p>
   												</c:otherwise>
   											</c:choose>
      										<c:choose>
												<c:when test="${pbt.unitStock==0}">
													<p style="color:red">缺貨中</p>
   												</c:when>
												<c:when test="${pbt.unitStock>=10}">
													<p>購買數量
														<select class="selectpicker selectQty products${proContentCount} quantity${proContentCount}" id="qty${proContentCount}"
																style="font-size:10pt;">
														</select>
													</p>
   												</c:when>
 												<c:otherwise>
 													<p>購買數量
														<input style="margin:5px;" type="number" class="products${proContentCount} quantity${proContentCount}" id="qty${proContentCount}" value="1" min="1" max="${pbt.unitStock}" />
													</p>
	   											</c:otherwise>
   											</c:choose>
   											
   											<c:choose>
												<c:when test="${pbt.unitStock==0}">
   													<button class="btn btn-primary">
														到貨後立即通知
													</button>
   												</c:when>
 												<c:otherwise>
   													<button name="cmd" id="press${proContentCount}" class="addToCar btn btn-primary">
														Add To Car
													</button>
   												</c:otherwise>
   											</c:choose>
   											
   											<c:choose>
												<c:when test="${pbt.unitStock<=5 && pbt.unitStock>0}">
													<p style="color:red">商品即將完售</p>
													<p style="color:red">庫存量${pbt.unitStock}</p>
   												</c:when>
												<c:when test="${pbt.unitStock==0}">
   												</c:when>
 												<c:otherwise>
 													<p>庫存量${pbt.unitStock}</p>
   												</c:otherwise>
   											</c:choose>
   											
      										
      										</section>
						                    <input type="hidden" class="products${proContentCount}" id="productId${proContentCount}" name="productId" value="${pros.productID}" />
						                    <input type="hidden" class="products${proContentCount}" id="productName${proContentCount}" name="productName" value="${pros.productName}" />
						                    <input type="hidden" class="products${proContentCount}" id="productInfo${proContentCount}" name="productInfo" value="${pros.productInfo}" />
						                    <input type="hidden" class="products${proContentCount}" id="typeId${proContentCount}"  name="typeId" value="${pbt.typeID}" />
						                    <input type="hidden" class="products${proContentCount}" id="typeTitle${proContentCount}"  name="typeTitle" value="${pbt.typeTitle}" />
						                    <input type="hidden" class="products${proContentCount}" id="image1${proContentCount}"  name="image1" value="${pros.image1}" />
						                    <input type="hidden" class="products${proContentCount}" id="unitPrice${proContentCount}"  name="unitPrice" value="${pbt.unitPrice}" />
						                    <input type="hidden" class="products${proContentCount}" id="unitStock${proContentCount}"  name="unitStock" value="${pbt.unitStock}" />
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
<div class="container" id="setMap" style="display:none;"></div>
<!-- for bootstrap working -->
<!-- 放到head會導致modal無法使用 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/productList.js">
</script>
</body>
</html>
