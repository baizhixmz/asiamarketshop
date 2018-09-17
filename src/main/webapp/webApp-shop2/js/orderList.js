$(function(){
	// 判断登录
	function getCookie(cookieName) {
	    var strCookie = document.cookie;
	    var arrCookie = strCookie.split("; ");
	    for(var i = 0; i < arrCookie.length; i++){
	        var arr = arrCookie[i].split("=");
	        if(cookieName == arr[0]){
	            return arr[1];
	        }
	    }
	    return "";
	}
	var username = getCookie("JSESSIONID");
	// document.cookie="JSESSIONID="+username;

	if(true) {
			$.ajax({
				url: getHostName()+'/order/findMyOrder',
				type: 'POST',
				dataType: 'JSON',
				success:function(data){
					if(data!=""){
						$.each(JSON.parse(data),function(index,ele){
							
							var status = ele.sorderEntity.orderStatus;
							if(status == "待处理"){
								status = "Ausstehend";
							}else if(status == "已处理"){
								status = "Verarbeitet";
							}else{
								status = "Storniert";
							}
							
							var totalNum = 0;
									var orderListheaderStr = `<div class="orderDetail">
											<div class="orderListHeader">
									        	<div class="orderNumber" >Numero:${ele.sorderEntity.orderNum}</div>
									        	<div class="orderStatus">Stato: <span style="color:#d8505c ">${status}</span></div>
									        </div>
										</div>`;
								$("#cart-shop").append(orderListheaderStr);
								var goodsInfo = JSON.parse(data)[index].cartCarVO;

								$.each(goodsInfo,function(GoodsIndex,GoodsEle){
									
									var name = GoodsEle.sproductEntity.name;
				                	
				                	var nameArr = name.split("/");
				                	
				                	var pname;
				                	
				                	if(nameArr.length == 1){
				                		pname = nameArr[0];
				                	}else{
				                		pname = nameArr[1];
				                	}
									
									totalNum+=GoodsEle.count;
									// console.log(GoodsEle);
									var orderListContentrStr = `<div class="item"><div class="cart-shop-content">
											            <div class="cart-shop-content-right">
											                <a href="#" class="product-img">
											                    <img src="http://mainriversoft.com${GoodsEle.sproductEntity.imgsrc}" alt=""/>
											                </a>
											                <div class="product-info">
											                    <a href="#" class="info-txt">${pname}</a>
											                    <div class="option">
											                        <div class="pull-left">
											                    		<p class="price">Prezzo unitario：€ <b>${GoodsEle.sproductEntity.price}</b></p>
											                            <span class="num">Quantità d'acquisto：<b>${GoodsEle.count}</b></span>
											                        </div>
											                    </div>
											                </div>
											            </div>
											        </div>
										        </div>`;
									$(".orderListHeader").last().after(orderListContentrStr);
								});

								var r;
								$.ajax({
												url: getHostName()+'/order/findOrderType',
												type: 'POST',
												dataType: 'JSON',
												async: false,
												data:{orderNum:ele.sorderEntity.orderNum},
												success:function(result){
													console.log(JSON.parse(result).qtime);
													r = JSON.parse(result).qtime;
												}
											});
								console.log(r == null);
								
								var type = "";
								
								if(r == null){
									type = "Mailing";
								}else{
									type = "Abholung";
								}
								
								
								var orderListFooterStr = `<div class="orderListFooter">
															<div>Lieferart：${type}</div>&nbsp;
												        	<div>Totale<span class="totalNum"> ${totalNum} </span>prodotti totale： <span class="totalPrice" style="color:#d8505c">€ ${ele.sorderEntity.orderSalary}</span></div>
												        </div>`;

					        	$(".item .cart-shop-content").last().after(orderListFooterStr);

						})
					}
					else{
						$("#cart-shop").empty().html("Il tuo ordine è vuoto");
					}
				}
			})
		}else {
			window.location.href="../webApp-shop2/login.jsp";
		}
})