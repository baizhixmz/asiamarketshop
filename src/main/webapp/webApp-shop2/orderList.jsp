<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<script src="${pageContext.request.contextPath}/webApp-shop/js/ContextPath.js"></script>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<title>Il mio ordine</title>
	<link rel="stylesheet" href="css/reset.css">
	<link rel="stylesheet" href="css/iconfont.css">
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" href="css/footer.css">
	<link rel="stylesheet" href="css/orderList.css">
</head>
<body>
	<!-- 头部 -->
	<header>
		<div class="left"></div>
		<div class="title">Meine Bestellung</div>
		<div class="right"></div>
	</header>

    <div id="cart-shop" class="cart-shop">
		
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
			<a href="mine.jsp">
				<li>
					<i class="iconfont icon-account"></i>
					<span>Meine Bestellung</span>
				</li>
			</a>
		</ul>
	</footer>
	<script src="js/lib/zepto.min.js"></script>
    <script src="js/orderList.js"></script>
</body>
</html>