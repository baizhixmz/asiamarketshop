<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="${pageContext.request.contextPath}/webApp-shop/js/ContextPath.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>Bestellung erstellen</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/iconfont.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="js/layui/css/layui.css">
    <link rel="stylesheet" href="js/jiaoben5653/css/pickuptime.css"/>
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
				  var str1 = `<a href="#" onclick="createOrder1()">Bestellung erstellen</a>`;
				  var str2 = `<a href="#" onclick="createOrder2()">Bestellung erstellen</a>`;
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
					
					  console.log(data);
					  $("#name").attr("value",data.name);
					  $("#phone").attr("value",data.phone);
					  $("#address").attr("value",data.address);
				  },
				  dataType: "json"
			});
		});
		
	</script>
</head>
<body>
<!-- 头部 -->
<header>
    <div class="left"></div>
    <div class="title">Bestellung erstellen</div>
    <div class="right"></div>
</header>

<div id="cart-shop" style="margin-top:50px;" >
	<!-- <div style="width: 100%;">
		<div style="float: right;width: 50%;background-color: lime;">
			<button class="layui-btn layui-btn-fluid layui-btn-primary">邮寄</button>
		</div>
		<div style="width: 50%;background-color: red;">
			<button class="layui-btn layui-btn-fluid layui-btn-primary">上门取货</button>
		</div>
	</div> -->
	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief"> 
		<ul class="layui-tab-title">
		<li class="layui-this">Abholung zu Hause</li>
		<li>Mailing</li>
		</ul>
		<div class="layui-tab-content">
			<div class="layui-tab-item layui-show">
				<ul>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name：<input type="text" id="name1" name="name1"/></li>
					<li>Handynummer：<input type="text" id="phone1" name="phone1"/></li>
					<li class='test' id='test'>Wählen Sie Abholzeit</li>
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
				Boninformationen
							<hr>
							<div>
								<table style="border-collapse:separate; border-spacing:0px 10px;">
									<tr>
										<td>Empfänger：</td>
										<td><input type="text" id="name"/></td>
									</tr>
									<tr>
										<td>Kontaktnummer：</td>
										<td><input type="text" id="phone"/></td>
									</tr>
									<tr>
										<td>Detaillierte Adresse：</td>
										<td><input type="text" id="address"/></td>
									</tr>
								</table>
							</div>
			</div>
		</div>
	</div>      
	Bestellinformationen
	<hr>
	<div id="order_context"></div>
</div>
<!-- 创建订单 -->
<script>

    function createOrder1() {
    	
    	var name = $("#name").val();
    	var phone = $("#phone").val();
    	var address = $("#address").val();
    	
    	if(temp == 1 && name!="" && phone!="" && address!=""){
	        console.log("----------createOrder------------");
    		var totalPrice = $("#btnPrice").text().substring(2);
	        $.ajax({
	            url: getHostName() + '/order/createOrder',
	            type: 'POST',
	            dataType: 'JSON',
	            data: {salary: totalPrice,name:name,phone:phone,address:address},
	            success: function (data) {
	            	location.href="${pageContext.request.contextPath}/webApp-shop/orderList.jsp";
	            }
	        })
    	}else{
    		console.log("----------请填写完整的收货信息------------");
    		alert("Bitte füllen Sie die vollständigen Quittungsinformationen aus");
    	}
        
    }
    
	function createOrder2() {
    	
    	var totalPrice = $("#btnPrice").text().substring(2);
    	var qtime = $("#test").text();
    	var name1 = $("#name1").val();
    	var phone1 = $("#phone").val();
    	$.ajax({
		    url: getHostName() + '/order/createOrder',
		    type: 'POST',
		    dataType: 'JSON',
		    data: {salary: totalPrice,name:name1,phone:phone1,qtime:qtime},
		    success: function (data) {
		    	location.href="${pageContext.request.contextPath}/webApp-shop/orderList.jsp";
		    }
	    })
    }
    
</script>

<div id="createList" class="createList">
	<div id="msg">Mindestpreis：${sessionScope.shopMsg.minPrice}</div>
    <div id="btnPrice" class="btnPrice">€ <span id="o_price">0.00</span></div>
    <div id="btnPay" class="btnPay" ><a href="#" onclick="createOrder2()">Bestellung erstellen</a></div>
</div>

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

</body>
</html>