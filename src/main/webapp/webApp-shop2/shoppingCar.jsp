<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="${pageContext.request.contextPath}/webApp-shop/js/ContextPath.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0">
    <title>Einkaufswagen</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/iconfont.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/shoppingCar.css">
</head>
<body>s
<!-- 头部 -->
<header>
    <div class="left"></div>
    <div class="title1">Einkaufswagen</div>
    <div class="right"></div>
</header>

<div id="cart-shop" class="cart-shop">
    <!-- 购物车为空 -->
    <div id="shopping-car" class="shopping-car">
        <div class="ico-shoppingCar">
            <span class="iconfont icon-cart"></span>
        </div>
        <div class="txt">Einkaufswagen ist leer</div>
        <div>
            <div class="btn btnSure m0"><a href="home.jsp">Geh wieder einkaufen</a></div>
        </div>
    </div>
</div>
<!-- 创建订单 -->
<script>

    function createOrder() {
        var totalPrice = $("#btnPrice").text().substring(2);
        if (${sessionScope.user != null}) {
            $.ajax({
                url: getHostName() + '/order/createOrder',
                type: 'POST',
                dataType: 'JSON',
                data: {salary: totalPrice},
                success: function (data) {
                   location.href="${pageContext.request.contextPath}/webApp-shop2/orderList.jsp";
                }
            })
        }
        else {
            window.location.href = "${pageContext.request.contextPath}/webApp-shop2/login.jsp";
        }
    }
</script>
<div id="createList" class="createList">
    <div id="btnPrice" class="btnPrice">€ 0.00</div>
    <div id="btnPay" class="btnPay"><a href="createOrder.jsp">Bestellung erstellen</a></div>
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
<script src="js/lib/zepto.min.js"></script>
<script src="js/shoppingCar.js"></script>
</body>
</html>