$(document).ready(function() {
	var pageContext = $("#pageContext").val();
//		======================輸入商品數量select==========================		
	//輸入商品數量
		var optionList='';
		for(var optionSet=1;optionSet<=10;optionSet++){
			optionList+='<option>'+optionSet+'</option>';
		}
		$(".selectQty").html(optionList);
		
// 		======================p分頁p==========================
		
		var pageSet = 8;//tip:每個分頁顯示的商品數量
		console.log( typeof(pageSet));//tip:typeof(pageSet)查看型態
		var proCount = $("#proCount").val();//tip:商品數量
		
		//總頁數 , Math.ceil()=無條件進位
		var totalPage = Math.ceil(proCount/pageSet);
		
		var page = 1;//tip:設定第一頁頁碼
		
//		//調整顯示商品筆數(未完)
//		$(".selectCountPage").change(function(){
//			pageSet = $("#selectCountPage").val();
//			console.log("pageSet:"+pageSet);
//			totalPage = Math.ceil(proCount/pageSet);
//			entryPage();
//			buildPage();
//			//因為按鈕在調整筆數後重寫,所以要再讀一次
//// 			$("input[class*='products']").load("productList");
//			$(".btLi").load("");
//			showPagePros();
//		})
		
		
		buildPage();//建立頁碼
		showPagePros();//tip:剛載入就顯示此頁商品數量

		var finalPage; //tip:儲存末頁的頁碼
		//建立頁碼function
		function buildPage(){
			totalPage = Math.ceil(proCount/pageSet);
			var pageList='<li class=\"listPaper\" id=\"listPaper\"><button class=\"btLi ui-button ui-widget ui-corner-all\" id=\"pageFirst\">頁首</button></li><li class=\"listPaper\" id=\"listPaper\"><button class=\"pagePre ui-button ui-widget ui-corner-all\" id=\"pagePre\">上一頁</button></li>';
			for(var thePage=1;thePage<=totalPage;thePage++){
				pageList+='<li class=\"listPaper\" id=\"listPaper\"><button class=\"btLi\" id=\"btLi'+thePage+'\">'+thePage+'</button></li>';
				finalPage=Number(thePage); //tip:儲存末頁的頁碼
			}
			pageList+='<li class=\"listPaper\" id=\"listPaper\"><button class=\"pageNext ui-button ui-widget ui-corner-all\" id=\"pageNext\">下一頁</button></li><li class=\"listPaper\" id=\"listPaper\"><button class=\"btLi ui-button ui-widget ui-corner-all \" id=\"pageLast\">頁尾</button></li>';
			$(".pager").html(pageList);
		}
		console.log("finalPage:"+finalPage);
		//產生到第X頁輸入頁碼
//		function entryPage(){
//			var pageNo='';
//			for(var pageNoSet=1;pageNoSet<=totalPage;pageNoSet++){
//				pageNo+='<option>'+pageNoSet+'</option>';
//			}
//			$(".selectPage").html(pageNo);		
//		}
//		entryPage();
		
		
		
		//select變更頁碼時
//		$(".selectPage").change(function(){
//			page = $("#selectPage").val();
//			var pageBtn = $("#btLi"+page);
//			showPagePros(page);
//			removeLightBtn()
//			lightBtn(pageBtn)
//		});		

		
// 		高亮顯示第一頁的按鈕	
		if(totalPage>0){
			lightBtn($($(".btLi").get(1)));
	}		
// 		hidePreNext(page);//載入時顯示or隱藏的按鈕
		
//		function selectedSet(){
//		//  先取得要移除項目的 index
//			var selectIndex = $("#selectPage").find(":selected").index();
//
//			//  移除選擇的項目
//			$("#selectPage").find(":selected").remove();
//
//			//  判斷移除項目後，原先的index是否還有option，有的話就直接將此option設定為選取狀態
//			//  捲軸就不會往上跑了
//			if ($('#selectPage option').get(selectIndex) != null) {
//			    $('#selectPage option').get(selectIndex).selected = true;
//			}
//			else {
//			    //  沒有項目的話，判斷select理是否還有option
//			    //  有的話，表示移除的項目為最後一個，就設定上一個option為選取狀態
//			    if ($('#selectPage option').length > 0) {
//			        $('#selectPage option').get(selectIndex - 1).selected = true;
//			    }
//			}
//		}
		
		
// 		頁碼按鈕
// 		testBtnEach();
		$(".btLi").click(function(){
			var id = $(this).attr("id");
			var Index = Number(id.replace("btLi",""))
			var thisBtn = $(this);
			if(id=="pageFirst"){
				page = 1;
				thisBtn = $($(".btLi").get(1));
			}
			else if (id=="pageLast"){
				page = finalPage;
				thisBtn = $($(".btLi").get(finalPage));
			}
			else {page = Index;}
//			$('#selectPage option').get(page-1).selected = true;
			showPagePros();
			removeLightBtn()
			lightBtn(thisBtn);
		})
		
// 		上一頁按鈕
		$("#pagePre").click(function(){
			if(page>1){page--;}
//			$('#selectPage option').get(page-1).selected = true;
			showPagePros();
			removeLightBtn()
			lightBtn($($(".btLi").get(page)));
// 			hidePreNext();
		})	
		
// 		下一頁按鈕
		$("#pageNext").click(function(){
			if(page<totalPage){page++;}
//			$('#selectPage option').get(page-1).selected = true;
			showPagePros();
			removeLightBtn()
			lightBtn($($(".btLi").get(page)));
// 			hidePreNext();
		})		
		
// 		指定按鈕加css
		function lightBtn(targetBtn){
			targetBtn.addClass("pointBtnPage");
		}
		
// 		移除所有標記按鈕的css
		function removeLightBtn(){
			$(".pointBtnPage").each(
				function(){
					$(this).removeClass("pointBtnPage");	
				})
		}		

// 		隱藏前進後退按鈕,設定2秒(2000毫秒)
		function hidePreNext(){
			if(page==totalPage){
				$("#pageNext").hide(2000);	
				$("#pageLast").hide(2000);
				$("#pagePre").show(2000);
				$("#pageFirst").show(2000);			
			}else if(page==1){
				$("#pagePre").hide(2000);
				$("#pageFirst").hide(2000);	
				$("#pageNext").show(2000);	
				$("#pageLast").show(2000);	
			}else{
				$("#pageNext").show(2000);
				$("#pagePre").show(2000);	
				$("#pageFirst").show(2000);	
				$("#pageLast").show(2000);	
			}
	}	
		
// 		顯示某分頁商品
		function showPagePros(currentPage){
			$.each($(".products"),function(contentindex){
				if(contentindex>=(page-1)*pageSet && contentindex < page*pageSet){
					$(this).show();	
				}else{$(this).hide();}
			});	
// 			hidePreNext(page);
		}
// ========================Modal content商品內容=========================	
		
		
//	初始關閉所有modal內容
	$(".modalContent").css("display","none");

	
//	動態寫入type的數量、內容(完成,但想試著用ajax寫看看)
	setSelectType();
	function setSelectType(){
		var typeList='';
		var typeContent='';
		var prods = $("#proCount").val();//商品數量
		var typeCount = [];//每個商品的種類數量
		var typeTitle = getAllTypeTitle();//全產品type的陣列
		
		for(var prodSet=1;prodSet<=prods;prodSet++){
			typeCount[prodSet]=$("#typeCount"+prodSet).val();
		}
		
		var typeTitleIndex=0;//產品type的索引
		for(var prod=1;prod<=prods;prod++){
			for(var typeNo=1;typeNo<=typeCount[prod];typeNo++){
				typeList+='<option class=\"proType\">'+typeTitle[typeTitleIndex++]+'</option>';
			}
			$(".proSelect"+prod).html(typeList);
			typeList="";
		}
		
	}
	//取得全產品type的陣列
	function getAllTypeTitle(){
		$("#setMap").append($("input[id*=typeTitle]").map(function(){
			return $(this).val();
		}).get().join(",")
		);
		return $("#setMap").text().split(",");
	}	
	
//	console.log($("select").text());
	var nowIndex = 0 ;
//	設定modal內容的type切換(未完成,切換過去時的option selected不正確)
	$("select").change(function(){
		var targetIndex = $(this).get(0).selectedIndex;//取得被選中項目的索引
		console.log("nowIndex:"+nowIndex);
		console.log("targetIndex:"+targetIndex);
		var selectID = $(this).attr("id");//取得自己元素id
		console.log("selectID:"+selectID);
		
		var selectVal = $(this).val();
		console.log("selectVal:"+selectVal);
		
		var modalContentID = $(this).parents("div[id*=modalContent]").attr("id")//取得祖宗元素modalContent的id
		console.log("modalContentID:"+modalContentID);
		var move = Number(targetIndex)-Number(nowIndex);//位移值
		var index = modalContentID.replace("modalContent","");
		
		modalContentID = "modalContent"+(Number(index)+move);//ID數字部分+位移值就是目標ID了
		console.log("modalContentID2:"+modalContentID);
		$("div[id*=modalContent]").css("display","none");
		$("div[id="+modalContentID+"]").css("display","block");
//		$(this).toggle();
		
		nowIndex = targetIndex;
		console.log("nowIndex2:"+nowIndex);
		
//		if(nowIndex<targetIndex){
//		}
//		else if(nowIndex>targetIndex){
//			
//		}
	})
	
//	設定modal內容的圖片點選時在目標位置放大顯示(未完成)
	var targetImg = $(".targetImg");//目標圖片的櫃子
	var smallImgBox = $(".smallImgBox");//圖片的櫃子
	
	
	$(".smallImg").click(function(){
		id = $(this).attr("id");
		index = id.replace("smallImg","");
		console.log("id:"+id);
		imgSrc = $(this).attr("src");
		console.log("imgSrc:"+imgSrc);
//		console.log("testimggggg:"+testimggggg);
//		addImgEle = '<img src=\"'+   pageContext    +'/'+   testImggg+    '\" width=\"200px\"></img>';
		$("#targetImg"+index).html('<img class="hoverProdImg"  src="' +imgSrc+ '" width="200px">' + '</img>');
//		console.log("img:"+addImgEle);
	})
	
	
	
//	elementPosition();
	//練習抓同class元素、索引	
	function elementPosition(){
		
//		這時會抓到同class=hoverProdImg的第8個(索引7)元素
		var taretElm = $(".hoverProdImg").get(7);
		
//		但抓到只是靜態元素,和能使用的DOM元素不同,
//		要在放入jquery的方法  →  DOM元素 = $(靜態元素) 才會變成DOM元素
		var setElm = $(taretElm);
		
		var testA= $(".hoverProdImg");
//		元素(靜態元素)的方法網站(重要)
//		https://developer.mozilla.org/zh-CN/docs/Web/API/Element
		console.log(testA.get(0));
		console.log(testA.length);
		console.log(testA.get(0).id);
		console.log(testA.get(0).attributes);
		console.log(testA.get(-1).innerHTML);
//		testA.each(function(index,data){
//			console.log(index,data);
//		});
	}		
// ========================a加入購物車a=========================		
	//m判斷是否使用modal
		var useModal = false;
		
    //m判斷是否開啟modal視窗,有開啟就將useModal設為true
   $('.myModal').on('shown.bs.modal', function (e) {
      	console.log("openModal");
      	useModal = true;
   })
	
 //m判斷是否關閉 modal視窗,關閉就將useModal設為false
	$('.myModal').on('hidden.bs.modal', function () {
		console.log("hiddenModal");
		useModal = false;
		
		//將modal內容恢復為初始狀態;
		nowIndex=0;
		$(".modalContent").css("display","none");
		
//		$("select .proType").first().css("background-color","green");
	})

//	按下詳細資料按鈕時,決定要開啟哪個商品modal
	$(".myModal").click(function(){
		var myModalTarget = $(this).attr("data-target");
//		開啟選擇的myModal內的所有第一個modalContent
		$(myModalTarget+" .modalContent").first().css("display","block");
		
	})
	
	var theCount = 0;
	$(".addToCar").click(function(){
		var id = $(this).attr("id");
		
// 		若id =press10,取數字部分10當index
		var	index = id.replace("press","");
//			console.log("buttonIndex:"+index);
		var quantity = $(".quantity"+index);
		let qty = 0;
//			console.log("index:"+index);
//			console.log("useModal:"+useModal);
		if(useModal){
			qty = quantity.val();
//			qty = $(quantity.get(1)).val()
		}else{
			qty = $("#qty"+index).val();
//			console.log("qtyelseID:"+"#qty"+index);
//			console.log("qtyelse:"+qty);
		}
		console.log("$(#qty+index).length:"+$("#qty"+index).length);
		console.log("$(#qty+index).value:"+$("#qty"+index).value);
		console.log("qtyID:"+"#qty"+index);
		console.log("qty:"+qty);
			var product = 
			{ 
				productId   : $("#productId"+index).val(),
				productName : $("#productName"+index).val(),
			 	qty 		: qty,
				typeId      : $("#typeId"+index).val(),
				image1      : $("#image1"+index).val(),
				unitPrice   : $("#unitPrice"+index).val(),
				describe    : $("#describe"+index).val(),
				discount	  : $("#discount"+index).val(),
			};
			//語法:JSON.stringify(物件) = 將物件轉換成JSON格式的字串(就是字串)
			var dataJSONString = JSON.stringify(product);
			console.log(dataJSONString);
			//語法:JSON.parse(JSON格式字串or陣列) = 將JSON格式字串or陣列轉換成JSON物件
			var dataJSONObject = JSON.parse(dataJSONString);
			var url = pageContext+"/shoppingCart/addToCar";
			console.log(dataJSONObject);
			doAjax(url,dataJSONObject);
// 			特別注意!!在控制器@GetMapping的productList_get一定要建立ShoppingCart的session(第46行)
// 			否則就算有註解,${ShoppingCart}雖然不會有事,但${ShoppingCart.itemNumber}一定會死給你看,千萬要小心
// 			alert("加入購物車成功");
			console.log("加入購物車成功");
//			$("#cartNo").load("");
		})
// 		=======================s每x毫秒刷新頁面s==========================			
		
// 		使用ajax不刷新頁面執行控制器or前端(未實驗)
		function doAjax(targetUrl,inputData,outputData){
			$.ajax({
				url:targetUrl,//後端controller的URL
				type:"POST",//用POST的方式
				cache: false,   //是否暫存
// 				contentType: 'application/json; charset=UTF-8',//傳送json格式資料給server時
// 				dataType: "json",
				dataType: "text",
				data: inputData,
// 				data: { key: value }, 傳送給後端的資料,格式為Key/Value  
				success:function(data){   //成功後回傳的資料data,目前沒用到不理他
// 					showNames(data);
					outputData;
					$("#cartNo").text(data);
				},
				error:function(err){ //發生伺服器404、500、304等錯誤時會用此function處理,err封裝錯誤訊息
					console.log(err);
				}
			});
		}
})