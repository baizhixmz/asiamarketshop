<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="${pageContext.request.contextPath}/webApp-shop/js/ContextPath.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>创建订单</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/iconfont.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="js/layui/css/layui.css">
    <link rel="stylesheet" href="js/jiaoben5653/css/pickuptime.css" />
    <style type="text/css">
    	.createList {
		    position: fixed;
		    right: 0;
		    bottom: 50px;
		    left: 0;
		    display: -webkit-flex;
		    display:    -moz-flex;
		    display:     -ms-flex;
		    display:      -o-flex;
		    display:         flex;
		
		    width: 100%;
		    height: 40px;
		    padding-left: 10px;
		
		    background: rgba(0, 0, 0, .8);
		
		    align-items: center;
		    justify-content: flex-end;
		}
		
		.createList .btnPrice {
		    width: 100px;
		    height: 40px;
		    line-height: 40px;
		    text-align: center;
		    color: #fff;
		}
		
		.createList .btnPay {
		    height: 40px;
		    line-height: 40px;
		    background: orange;
		    flex: 0 0 100px;
		    text-align: center;
		    color: #fff;
		}
		
		.test {
			height: 40px;
			line-height: 40px;
			padding-left: 10px;
			border-bottom: 1px solid #f2f2f2;
		}
</style>
		
    </style>
	<script type="text/javascript" src="js/jiaoben5653/js/pickuptime.min.js" ></script>
    <script src="js/lib/zepto.min.js"></script>
	<script type="text/javascript" src="js/layui/layui.js"></script>
	<script src="js/createOrder.js"></script>
	<script type="text/javascript">
		var temp;
		layui.use('element', function(){
		  	 var element = layui.element;
			  
			 //一些事件监听
			 element.on('tab(demo)', function(data){
			    console.log(data);
			 });
			 
			  
			 element.on('tab(docDemoTabBrief)', function(data){
				  var str1 = `<a href="#" onclick="createOrder1()">创建订单</a>`;
				  var str2 = `<a href="#" onclick="createOrder2()">创建订单</a>`;
				  temp = data.index;
				  if(data.index == 0){
					  $("#msg").hide();
					  $("#btnPay").show();
					  $("#btnPay").empty();
					  $("#btnPay").append(str2);
					  getShoppingCarList();
				  }else{
					  $("#order_context").empty();
					  $("#btnPay").empty();
					  $("#btnPay").append(str1);
					  getShoppingCarList();
					  console.log($("#o_price").text()>=20);
					  if($("#o_price").text() < 20){
						  $("#btnPay").hide();
						  $("#msg").show();
						  //$("#btnPrice").html("您的订单未达到包邮价格");
					  }
				  }
				  
			});
			  
		});
		
		
		$(function(){
			$("#msg").hide();
			$.ajax({
				  type: 'POST',
				  url: "${pageContext.request.contextPath}/user/findOneById",
				  data: "cookieId=${sessionScope.user.cookieid}",
				  success: function(data){
					  //console.log(data);
					  $("#name").attr("value",data.name);
					  $("#phone").attr("value",data.phone);
					  $("#name1").attr("value",data.name);
					  $("#phone1").attr("value",data.phone);
					  $("#address").attr("value",data.address);
				  },
				  dataType: "json"
			});
			
		});
		
		function checkMobiles(theForm) {
		    return /^((13|15|18|14|17)+\d{9})$/.test(theForm);
		}
		
	</script>
</head>
<body>
<!-- 头部 -->
<header>
    <div class="left"></div>
    <div class="title">创建订单</div>
    <div class="right"></div>
</header>

<div id="cart-shop" style="margin-top:50px;" >
	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief"> 
		<ul class="layui-tab-title">
		<li class="layui-this">上门取货</li>
		<li>邮寄</li>
		</ul>
		<div class="layui-tab-content">
			<div class="layui-tab-item layui-show">
				<ul>
					<li>&nbsp;&nbsp;&nbsp;姓名：<input type="text" id="name1" name="name1"/></li>
					<li>手机号：<input type="text" id="phone1" name="phone1"/><span id="tt"></span></li>
					<li class='test' id='test'>选择取货时间</li>
				</ul>
				
				<script type="text/javascript">
					$(document).ready(function(){
						$('#test').on('click',function(){
							//数字为正整数，0表示当天可取
							pickuptime.init(0,function(data){
								console.log(data.split(" "));//回调
								$("#test").html(data.split(" "));
							});
						});
					});
				</script>
			</div>
			<div class="layui-tab-item" id="sh">
				填写收货信息
				<hr>
				<div>
					<table style="border-collapse:separate; border-spacing:0px 10px;">
						<tr>
							<td>收件人：</td>
							<td><input type="text" id="name"/></td>
						</tr>
						<tr>
							<td>联系电话：</td>
							<td>
								<input type="text" id="phone"/>
								
							</td>
						</tr>
						<tr>
							<td>详细地址：</td>
							<td><input type="text" id="address"/></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>      
	订单信息
	<hr>
	<div id="order_context"></div>
</div>
<!-- 创建订单 -->
<script>

    function createOrder1() {
    	
    	var name = $("#name").val();
    	var phone = $("#phone").val();
    	var address = $("#address").val();
    	
    	var patt =  /^[0-9]+$/;
    	
    	var f = checkMobiles(phone);
		
    	    	
	    	if(temp == 1 && name!="" && phone!="" && address!=""){
	    		
	    		if(patt.test(phone)){
		    		var totalPrice = $("#btnPrice").text().substring(2);
			        $.ajax({
			            url: getHostName() + '/order/createOrder',
			            type: 'POST',
			            dataType: 'JSON',
			            data: {salary: totalPrice,name:name,phone:phone,address:address},
			            success: function (data) {
			            	location.href="${pageContext.request.contextPath}/webApp-shop/orderList.jsp";
			            }
			        }); 
	    		}else{
	    			
	    			alert("请填写正确的手机号！！！");
	    			
	    		}
	    	}else{
	    		
	    		if(name == ""){
	    			alert("请填写收货人！");
	    		}else if(phone == ""){
	    			alert("请填写联系方式！");
	    		}else if(address == ""){
	    			alert("请填写收货地址！");
	    		}
	    		
	    	}
        
    }
    
	function createOrder2() {
    	
    	var totalPrice = $("#btnPrice").text().substring(2);
    	
    	var qtime = $("#test").text();
    	var name1 = $("#name1").val();
    	var phone1 = $("#phone1").val();
    	
    	var patt =  /^[0-9]+$/;
    	
    	var f = checkMobiles(phone);     
	    	if(qtime != "" && name1 != "" && phone1 != "" && qtime != "选择取货时间"){
			    
	    		if(patt.test(phone)){
	    		
		    		$.ajax({
					    url: getHostName() + '/order/createOrder',
					    type: 'POST',
					    dataType: 'JSON',
					    data: {salary: totalPrice,name:name1,phone:phone1,qtime:qtime},
					    success: function (data) {
					    	location.href="${pageContext.request.contextPath}/webApp-shop/orderList.jsp";
					    }
				    });
	    		}else{
	    			alert("Bitte geben Sie die richtige Handynummer ein!");
	    		}
	    	}else{
	    		
	    		if(name1  == ""){
	    			alert("请填写取件人！");
	    		}else if(phone1 == ""){
	    			alert("请填写手机号！");
	    		}else if(qtime == "" || qtime == "选择取货时间"){
	    			alert("请选择取货时间！");
	    		}
	    		
	    	}
    	
    }
    
</script>

<div id="createList" class="createList">
	<div id="msg">最低包邮价：${sessionScope.shopMsg.minPrice}</div>
    <div id="btnPrice" class="btnPrice">€ <span id="o_price">0.00</span></div>
    <div id="btnPay" class="btnPay" ><a href="#" onclick="createOrder2()">创建订单</a></div>
</div>

<!-- 底部 -->
<footer>
    <ul>
        <a href="home.jsp">
            <li>
                <i class="iconfont icon-category"></i>
                <span>选购</span>
            </li>
        </a>
        <a href="shoppingCar.jsp">
            <li>
                <i class="iconfont icon-cart"></i>
                <span>购物车</span>
            </li>
        </a>
        <a href="orderList.jsp">
            <li>
                <i class="iconfont icon-account"></i>
                <span>我的订单</span>
            </li>
        </a>
    </ul>
</footer>

</body>
</html>