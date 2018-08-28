<%@ page contentType="text/html;charset=UTF-8"  language="java" pageEncoding="UTF-8"  %>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
	<head>
		<meta charset="UTF-8">
		<title>购物车</title>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="../css/car-style.css"/>
		<script src="${pageContext.request.contextPath}/chinaPage/js/jquery.min.js"></script>
		<script>
			$(function () {
				
				
				$.ajax({
					url : "${pageContext.request.contextPath}/cartCar/show",
					type : "post",
                    success : function (result) {
					    var  total = 0
                        if(result.length==0){
                                $("#empty").show();
                                $(".table_top").hide();
                                $(".create").hide();
                            }
						for( var  i  in  result){
						    var  obj = result[i];
						    var  littlePrice = obj.sproductEntity.price*obj.count
							total+=littlePrice
							$("#goods").append("<fieldset class='electronic car_table'><legend>"+obj.sproductEntity.categoryName+"</legend>" +
								"<table><tr><td><div hidden>"+obj.sproductEntity.id+"</div></td><td><img style='height: 120px;width: 100px;' src='http://${pageContext.request.serverName}/net_shop_manager/"+obj.sproductEntity.imgsrc+"'/> </td><td>" +
								"<p class='title'>"+obj.sproductEntity.name+"</p><div class='info' style='height:100px;overflow: hidden'>"+obj.sproductEntity.description+"</div></td>" +
								"<td class='txt-cet'>€"+obj.sproductEntity.price+"</td><td class='txt-cet'>" +
								"<input type='number' onblur='chg(this)' onchange='numb()' min='1' name='' id='coun' value='"+obj.count+"' class='count'/></td>" +
								"<td class='txt-cet'>€"+(obj.sproductEntity.price*obj.count).toFixed(2)+"</td><td class='txt-cet'>" +
								"<a href='#' onclick='del(this)' >删除</a></td></tr></table></fieldset>")
                        }
						
						total = total.toFixed(2)
						
                        $("#totalPrice").text(total);
                        
                        //$("#oprice").val(total);
                        
                        if(total == 0){
                        	$("#dd").hide();
                        }
                        
                        $("input:radio[name='ordertype']").change(function(){        
                        	if($(this).val() == "type2"){
                        		$("#totalPrice").text(total);
                        		$("#addr").attr("style","display:block;");
                        		Shipping(total);
                        	}else{
                        		$("#addr").attr("style","display:none;");  
                        		$("#mm").remove();
                        		$(".create").show();
                        	}
                        });
						

        				$.ajax({
        					  type: 'POST',
        					  url: "${pageContext.request.contextPath}/user/findOneById",
        					  data: "cookieId=${sessionScope.user.cookieid}",
        					  success: function(data){
        						
        						  console.log(data);
        						  $("#addressee").attr("value",data.name);
        						  $("#phone").attr("value",data.phone);
        						  $("#address").attr("value",data.address);
        					  },
        					  dataType: "json"
        				});
                        
                    }
				})
            })
            function numb(){
                var num = $("#coun").val();
                if(num*1<=0){
                $("#coun").val(1);
                }
            }
            function del(obj) {
                var  id = $(obj).parent().parent().children(":first").text()
                $.ajax({
                    url : "${pageContext.request.contextPath}/cartCar/dropCartGood",
                    data :  {"id":id},
                    type : "post",
                    success : function (result) {
                        console.log(result)
						location.reload()
                    }
                })
            }

            function chg(obj) {
                var  count =  $(obj).val()
				var  id = $(obj).parent().parent().children(":first").text()
				$.ajax({
                    url : "${pageContext.request.contextPath}/cartCar/changeCount",
					data :  {"id":id,"count":count},
                    type : "post",
					success : function (result) {
						console.log(result)
                        location.reload()
                    }
				})
            }
            
            function Shipping(price){
            	if(price >= ${sessionScope.shopMsg.minPrice}){
                	$("#free").html("<font id='mm' size='2'>您已享受包邮</font>");
                	
                }else{
                	$(".create").hide();
                	$("#free").html("<font id='mm' size='2'>最低包邮价：${sessionScope.shopMsg.minPrice}</font>");
                }
            }
            
		</script>
	</head>
	<body>
		<%@include file="header.jsp"%>
		<table class="table_top" >
			<tr>
                <td style="width:20%"></td>
				<td style="text-align: center;">商品详情</td>
				<td  style="text-align:center"><span style="margin-left:50%">单价</span></td>
				<td>数量</td>
				<td>总价</td>
				<td>操作</td>
			</tr>
		</table>
		<div id="goods">
		
		</div>
		<div id="dd" align="center">
			<input type="radio" name="ordertype" id="ordertype" value="type1" checked="checked"/>到店取货&nbsp;&nbsp;
			<input type="radio" name="ordertype" id="ordertype" value="type2"/>邮寄
		</div>
		
		<div id="addr" style="display: none;">
			<fieldset>
				<legend>填写地址</legend>
				<table>
					<tr>
						<td>
							收件人:<input type="text" id="addressee" name="addressee"/>
						
							联系电话：<input type="text" id="phone" name="phone"/>
							
							收货地址：<input type="text" id="address" name="address"/>
							
						</td>
					</tr>
				</table>
			</fieldset>
		</div>
    <div class="empty" id="empty" hidden>
    <p  style="font-weight:bold;font-size:18px;color:#313131;">您的购物车还是空的，您可以：</p>
    <a href="${pageContext.request.contextPath}/chinaPage/page/booklist.jsp?adminId=${sessionScope.adminMsg.id}" class="btn">去逛逛</a>
    </div>
        <div class="pay_end">
            <div class="total">
                <div class="total_box">
                    <div class="total_price">
                    	总计：<span id="totalPrice">€0.0</span>
                    	<span id="free"></span>
                    	
                    </div>
                     <a href="javascript:void(0)" class="create" onclick="createOrder()" >创建订单</a>
                </div>
            </div>
        </div>
		<%@include file="footer.jsp"%>   
	</body>
    <script type="text/javascript">
        function createOrder(){
        	var name = $("#addressee").val();
        	var phone = $("#phone").val();
        	var address = $("#address").val();
        	
        	
            $.ajax({
                url:"${pageContext.request.contextPath}/order/createOrder.do",
                data:{salary:+$("#totalPrice").text(),name:name,phone:phone,address:address},
                type:"POST",
                success:function(data){
                    location.href ="${pageContext.request.contextPath}/chinaPage/page/order.jsp?adminId=${sessionScope.adminMsg.id}";
                }
            })
        }
    </script>
</html>













