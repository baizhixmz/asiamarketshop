<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<script src="${pageContext.request.contextPath}/webApp-shop/js/ContextPath.js"></script>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<title>Asiamarket</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/iconfont.css">
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" href="css/cate.css">
	<script src="js/lib/zepto.min.js"></script>
	<script src="js/fingerprint.js"></script>
	<script src="js/cate.js"></script>
	<style>
		.addOne{
			display:inline-block;
			width:20px;
			height:20px;
			background-color:#e8401f;
			line-height:20px;
			text-align:center;
			border-radius:10px;
			color:#fff;
			font-weight: bold;
		}
		.minusOne{
			width:20px;
			height:20px;
			border-radius:10px;
			color:#e8401f;
			font-weight: bold;
			line-height:19px;
			text-align:center;
			border:1px solid #e8401f;
		}
		#language{
			font-size: 14px;
			background: #f7f7f7;
			border: 1px solid #dcdcdc;
			padding: 8px 12px 8px 12px;
			margin: 0 6px;
			border-radius: 5px;
			color: #8d8d8d;
			cursor: pointer;
			background-repeat: no-repeat;
		}
		
		.pad_right {
				padding-right: 2em;
			}
			
			#scroll_div {
				height: 26px;
				overflow-y: hidden;
				white-space: nowrap;
				width: 270px;
				
				/* margin-left: 10px; */
			}
			
			#scroll_begin,#scroll_end {
				width: 270px;
				display: inline;
			}
	</style>
	<script>
			function ScrollImgLeft(){ 
				var speed=50;
				var MyMar = null;
				var scroll_begin = document.getElementById("scroll_begin"); 
				var scroll_end = document.getElementById("scroll_end"); 
				var scroll_div = document.getElementById("scroll_div"); 
				scroll_end.innerHTML=scroll_begin.innerHTML; 
				function Marquee(){ 
					if(scroll_end.offsetWidth-scroll_div.scrollLeft<=0) 
						scroll_div.scrollLeft-=scroll_begin.offsetWidth; 
					else
						scroll_div.scrollLeft++; 
				} 
				MyMar=setInterval(Marquee,speed); 
				scroll_div.onmouseover = function(){
					clearInterval(MyMar);
				}
				scroll_div.onmouseout = function(){
					MyMar = setInterval(Marquee,speed); 　　　　
				}  
			}
					
			$(function(){		 
				ScrollImgLeft();
				
				//获取浏览器的唯一标识
				
				getUser();
				
			})
			
			function getUser(){
				
				var cookie = getCookie("userId");
				
				console.log("cookie:"+cookie);
				
				if(cookie == ""){
					//获取浏览器的唯一标识
					var fingerprint = new Fingerprint().get(); 
					
					console.log("fingerprint:"+fingerprint);
					
					$.ajax({
						url: getHostName()+"/user/findOneById",
			            type: 'POST',
			            dataType: 'JSON',
			            data:{cookieId:fingerprint},
			            async: false,
						success:function(data){
							/* console.log(data);
							console.log(data == "");*/	
							if(data == ""){
								register(fingerprint);
							}
							setCookie("userId",fingerprint);
						}
					});
					
				}else{
					$.ajax({
						url: getHostName()+"/user/findOneById",
			            type: 'POST',
			            dataType: 'JSON',
			            data:{cookieId:cookie},
			            async: false,
						success:function(data){
							
						}
					});
				}
				
				
				
			}
			
			
			function register(id){
				
				$.ajax({
					url: getHostName()+"/user/register",
		            type: 'POST',
		            dataType: 'JSON',
		            data:{cookieId:id},
		            async: false,
					success:function(data){
						console.log(data);
					}
				});
				
				
			}
			
			function getCookie(Name) {
				var search = Name + "="//查询检索的值
				var returnvalue = "";//返回值
				if (document.cookie.length > 0) {
					sd = document.cookie.indexOf(search);
					if (sd!= -1) {
						sd += search.length;
						end = document.cookie.indexOf(";", sd);
						if (end == -1)
							end = document.cookie.length;
				        //unescape() 函数可对通过 escape() 编码的字符串进行解码。
						returnvalue = unescape(document.cookie.substring(sd, end))
					}
				} 
				return returnvalue;
			}
			
			function setCookie(name,value){
				var Days = 365;
				var exp = new Date();
				exp.setTime(exp.getTime() + Days*24*60*60*1000);
				document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
			}
			
		</script>
</head>
<body>
	<!-- 头部 -->
	<header>
		<div class="left">${sessionScope.shopMsg.name2}</div>
		<div class="title">
			<input id="language" type="button" name="${sessionScope.adminMsg.mobilePhone}" value="Kontaktnummer" onclick="adminPhone(this);">
		</div>
		<div class="right" style="margin-right: 30px;"><input id="language" type="button" value="China" onclick="toChinaPage();"></div>
		<script>
			// 去中文界面
			function toChinaPage(){
				location.href = getHostName()+"/webApp-shop/home.jsp";
			}
		</script>
	</header>
    <div class="categary">
    	<div class="searchTop">
    		<div class="iptSearch">
    			<input id="iptGoodsName" type="text" placeholder="Bitte geben sie den namen Waren">
    			<div id="btnSearch" class="btn btnSure m0">Suche</div>
    		</div>
    	</div>
        <div id="categary-left" class="categary-left">
            <ul>
        
            </ul>
        </div>
        <div class="categary-right">
        
        	<div id="scroll_div" class="fl">
					<div id="scroll_begin" >
						<font size="2" color="red">
							这个网站为了更好的为你服务使用了cookie，您可以把它关闭，但是网站的功能会受到影响 <span
							class="pad_right"> </span> "This website uses cookies to ensure
							you get the best experience on our website，you can disable it but
							the website will not function properly"
						</font>
	
					</div>
					<div id="scroll_end"></div>
				</div>
        	
            <div class="right-in">
				<ul id="product-info" class="product-info">

				</ul>
            </div>
        </div>
    </div>

    <!-- 商品列表Max -->
    <div id="maxGoodsList" class="maxGoodsList">
    	<div id="maxIn" class="maxIn">
	    	<div class="head">
    			<span class="iconfont icon-cart"></span>
	    	</div>
	    	<ul id="maxShoppingList">

	    	</ul>
    	</div>
    </div>

    <!-- 商品列表Min -->
    <div id="minGoodsList" class="minGoodsList">
    	<div class="sign">
    		<div id="GoodsNum" class="GoodsNum">0</div>
    		<span class="iconfont icon-cart"><span>
    	</div>
    	<div id="btnPrice" class="btnPrice">€ 0.00</div>
		<script>
			// 去结算
			function btnPay(user){
					location.href = getHostName()+"/webApp-shop2/shoppingCar.jsp";
			}
		</script>
    	<div id="btnPay" class="btnPay" onclick="btnPay()">Gehe zur Siedlung</div>
    </div>
	<!-- 模态框 -->
    <div id="mask" class="mask">
    	<div class="close"><span id="close">X</span></div>
    	<p class="txt">Sei sicuro di voler rimuovere questo articolo dal tuo carrello?</p>
    	<div class="btn">
    		<button id="btnSure" class="btnSure">determinare</button>
    		<button id="btnCancel" class="btnCancel">annullato</button>
    	</div>
    </div>

    <div id="maskBody" class="maskBody"></div>
	<!-- 底部 -->
	<footer>
		<ul>
			<a href="home.jsp">
				<li>
					<i class="iconfont icon-category"></i>
					<span>Kaufen</span>
				</li>
			</a>
			<a href="shoppingCar.jsp">
				<li>
					<i class="iconfont icon-cart"></i>
					<span>Einkaufswagen</span>
				</li>
			</a>
			<a href="orderList.jsp">
				<li>
					<i class="iconfont icon-account"></i>
					<span>Meine Bestellung</span>
				</li>
			</a>
		</ul>
	</footer>

	<script>
		$(function(){
			//alert();
			loadRemoteData("${sessionScope.adminMsg.id}","${sessionScope.adminMsg.username}");
		
			$("#adminPhone").click(function(){
				alert("Manager-Kontaktnummer："+$(this).attr("name"));
			});
			
			
		
		})
	</script>
</body>
</html>