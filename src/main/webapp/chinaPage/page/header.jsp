<%@ page pageEncoding="UTF-8" %>
<div class="index_top">
    <div class="index_logo">
        <div class="fl bz-logo">
            <a href="${pageContext.request.contextPath}/chinaPage/page/booklist.jsp?adminId=${sessionScope.adminMsg.id}"><img
                    src="${pageContext.request.contextPath}/chinaPage/img/sp3_3.png"/></a>
        </div>
        <div class="fl search">
            <input id="search_box" type="text" name="search_box" placeholder="找一找，逛一逛……" class="search_box fl"/>
            <input type="button" onclick="search();" name="search_btn" value="" class="fl search_btn"/>
        </div>
        <div class="fr my">
            <input id="changeLang" type="button" value="德文/German" onclick="changeLang()" class="fl my_commodity"/>
            <!--
            <input id="btnLogin" type="button" value="登录" onclick="toLogin()" class="fl my_commodity"/>
            <input type="button" value="注册" onclick="toRegist()" class="fl my_order"/>
            <input type="button" value="成为商家" onclick="toAdmin()" class="fl my_order"/> 
            -->
        </div>
        <script type="text/javascript" src="${pageContext.request.contextPath}/chinaPage/js/jquery.min.js"></script>
        <script type="text/javascript">
			
			$(function(){
				var flag = IsPC(); 
				console.log(flag);
				if(!true){
					window.location.replace("pageError.jsp");
					
				}
				if(getCookie("userId") == ""){
					setCookie("userId",getUUID());
					var ci = getCookie("userId");
					$.ajax({
						  type: 'POST',
						  url: "${pageContext.request.contextPath}/user/register",
						  data: "cookieId="+ci,
						  success: function(data){
							  console.log("success");
						  },
						  dataType: "json"
					});
				}
				//获取用户信息
				$.ajax({
					  type: 'POST',
					  url: "${pageContext.request.contextPath}/user/getUser",
					  data: "cookieId="+getCookie("userId"),
					  success: function(data){
						  console.log("success");
					  },
					  dataType: "json"
				});
				
				console.log("cookie:"+getCookie("userId"));
				
			});
			function IsPC() {
				var userAgentInfo = navigator.userAgent;
				var Agents = ["Android", "iPhone",
							"SymbianOS", "Windows Phone",
							"iPad", "iPod"];
				var flag = true;
				for (var v = 0; v < Agents.length; v++) {
					if (userAgentInfo.indexOf(Agents[v]) > 0) {
						flag = false;
						break;
					}
				}
				return flag;
			}
			
			function setCookie(name,value) { 
			    var Days = 30; 
			    var exp = new Date(); 
			    exp.setTime(exp.getTime() + Days*24*60*60*1000); 
			    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString(); 
			}
			
			function getCookie(c_name){
				if (document.cookie.length>0){
					c_start=document.cookie.indexOf(c_name + "=");
					if (c_start != -1){ 
						c_start += c_name.length + 1;
				    	c_end=document.cookie.indexOf(";",c_start);
				    	if (c_end == -1) 
				    		c_end = document.cookie.length;
				    	return unescape(document.cookie.substring(c_start,c_end))
				  	}else{
				  		
				  	}
				}
				return ""
			}
			function getUUID() {
		        return 'xxxx-xxxx-xxxx-xxxx-xxxx'.replace(/[xy]/g, function(c) {
		            var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
		            return v.toString(16);
		        });
		    }
			
		
		</script>
        <script type="text/javascript">
            function changeLang() {
                var href = location.href;
                location.href = href.replace("chinaPage", "italyPage");
            }
            function jumpToPage(url) {
                location.href = url + "?adminId=${sessionScope.adminMsg.id}"
            }
            function toLogin() {
                jumpToPage("${pageContext.request.contextPath}/chinaPage/page/login.jsp");
            }
            function toRegist() {
                jumpToPage("${pageContext.request.contextPath}/chinaPage/page/register.jsp");
            }
            function toAdmin() {
                location.href = "http://mainriversoft.com/file/toabout";
            }
        </script>

        <script type="text/javascript">
            function search() {
                if (${sessionScope.adminMsg.username eq "SuperAdmin"}) {
                    condition = "where flag='Y' and name like '%25" + $('#search_box').val() + "%25'";
                } else {
                    condition = "where admin_id='${sessionScope.adminMsg.id}' and name like '%25" + $('#search_box').val() + "%25'";
                }
                createBookDetail(1, condition);
            }
        </script>

        <script>
            var userLogin = "${sessionScope.user}";
            if (userLogin != "") {

                $("#btnLogin").css("display", "none");
            }


            function toCart() {
                window.location = "${pageContext.request.contextPath}/chinaPage/page/car.jsp?adminId=${sessionScope.adminMsg.id}";
            }
            function toOrder() {
                console.log(userLogin);
                if (userLogin != "") {
                    // console.log("非空");
                    window.location = "${pageContext.request.contextPath}/chinaPage/page/order.jsp?adminId=${sessionScope.adminMsg.id}";
                }
                else {
                    window.location = "${pageContext.request.contextPath}/chinaPage/page/login.jsp"
                }
            }
        </script>

    </div>
</div>
<div class="banner_box">
    <div class="long_banner" style="padding-left: 224px;">
        <div class="lord_box">
            <input type="button" value="购物车" onclick="toCart()" class="lord_commodity">
            <input type="button" value="我的订单" onclick="toOrder()" class="lord_order">
        </div>
        <p style="font-family:'楷体';text-shadow:5px 8px 12px rgba(255,116,1,0.6);margin: 0 auto;text-align: center;font-size: 50px;line-height:  120px;">
            ${sessionScope.shopMsg.name1}
        </p>
    </div>
</div>