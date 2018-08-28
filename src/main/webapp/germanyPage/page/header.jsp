<%@ page pageEncoding="UTF-8" %>
<div class="index_top">
    <div class="index_logo">
        <div class="fl bz-logo">
            <a href="${pageContext.request.contextPath}/italyPage/page/booklist.jsp?adminId=${sessionScope.adminMsg.id}"><img
                    src="${pageContext.request.contextPath}/italyPage/img/sp3_3.png"/></a>
        </div>
        <div class="fl search">
            <input id="search_box" type="text" name="search_box" placeholder="Finde es, geh einkaufen ..."
                   class="search_box fl"/>
            <input type="button" onclick="search();" name="search_btn" value="" class="fl search_btn"/>
        </div>
        <div class="fr my">
            <input id="changeLang" type="button" value="中文/Chinesisch" onclick="changeLang()" class="fl my_commodity"/>
            <!-- <input id="btnLogin" type="button" value="Login" onclick="toLogin()" class="fl my_commodity"/>
            <input type="button" value="Reg" onclick="toRegist()" class="fl my_order"/>
            <input type="button" value="Negozio" onclick="toAdmin()" class="fl my_order"/> -->
        </div>
        <script type="text/javascript">
            function changeLang() {
                var href = location.href;
                location.href = href.replace("italyPage", "chinaPage");
            }
            function jumpToPage(url) {
                location.href = url + "?adminId=${sessionScope.adminMsg.id}"
            }
            function toLogin() {
                jumpToPage("${pageContext.request.contextPath}/italyPage/page/login.jsp");
            }
            function toRegist() {
                jumpToPage("${pageContext.request.contextPath}/italyPage/page/register.jsp");
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
                window.location = "${pageContext.request.contextPath}/italyPage/page/car.jsp?adminId=${sessionScope.adminMsg.id}";
            }
            function toOrder() {
                console.log(userLogin);
                if (userLogin != "") {
                    // console.log("非空");
                    window.location = "${pageContext.request.contextPath}/italyPage/page/order.jsp?adminId=${sessionScope.adminMsg.id}";
                }
                else {
                    window.location = "${pageContext.request.contextPath}/italyPage/page/login.jsp"
                }
            }
        </script>

    </div>
</div>
<div class="banner_box">
    <div class="long_banner" style="padding-left: 224px;">
        <div class="lord_box">
            <button type="button" onclick="toCart()" class="lord_commodity">Einkaufswagen</button>
            <button type="button" onclick="toOrder()" class="lord_order">Meine Bestellung</button>
        </div>
        <p style="font-family:'楷体';text-shadow:5px 8px 12px rgba(255,116,1,0.6);margin: 0 auto;text-align: center;font-size: 50px;line-height:  120px;">
            ${sessionScope.shopMsg.name2}
        </p>
    </div>
</div>