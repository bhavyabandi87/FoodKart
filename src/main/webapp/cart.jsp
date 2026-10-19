<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>

<!DOCTYPE html>
<html>

<head>

<title>Cart - FoodKart</title>

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: Arial, sans-serif;
	background: #f8f8f8;
	color: #333;
}

/* Header */
.header {
	background: #e23744;
	color: white;
	padding: 18px 60px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo {
	font-size: 28px;
	font-weight: bold;
}

.nav {
	display: flex;
	gap: 25px;
}

.nav a {
	color: white;
	text-decoration: none;
	font-size: 16px;
	font-weight: bold;
}

.nav a:hover {
	text-decoration: underline;
}

/* Main Container */
.container {
	max-width: 1100px;
	margin: 40px auto;
	padding: 0 20px;
}

.page-title {
	margin-bottom: 30px;
}

.page-title h1 {
	font-size: 32px;
	margin-bottom: 8px;
}

.page-title p {
	color: #777;
}

/* Empty Cart */
.empty-cart {
	background: white;
	padding: 60px 20px;
	text-align: center;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.empty-cart h2 {
	margin-bottom: 10px;
}

.empty-cart p {
	color: #777;
}

/* Cart Layout */
.cart-container {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 25px;
	align-items: start;
}

/* Cart Items */
.cart-items {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

.cart-item {
	background: white;
	padding: 18px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	gap: 18px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.cart-image {
	width: 100px;
	height: 100px;
	object-fit: cover;
	border-radius: 8px;
}

.item-details {
	flex: 1;
}

.item-name {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 8px;
}

.item-price {
	color: #666;
	font-size: 15px;
}

/* Quantity Controls */
.quantity-controls {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-top: 12px;
}

.quantity-btn {
	width: 30px;
	height: 30px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #e23744;
	color: white;
	text-decoration: none;
	border-radius: 5px;
	font-size: 18px;
	font-weight: bold;
}

.quantity-btn:hover {
	background: #c92f3a;
}

.quantity {
	font-weight: bold;
	min-width: 20px;
	text-align: center;
}

/* Item Actions */
.item-actions {
	text-align: right;
}

.item-total {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 8px;
}

.remove-btn {
	color: #e23744;
	text-decoration: none;
	font-size: 13px;
	font-weight: bold;
}

.remove-btn:hover {
	text-decoration: underline;
}

/* Cart Summary */
.cart-summary {
	background: white;
	padding: 25px;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.cart-summary h2 {
	margin-bottom: 20px;
	font-size: 22px;
}

.total-row {
	display: flex;
	justify-content: space-between;
	border-top: 1px solid #ddd;
	padding-top: 18px;
	margin-bottom: 20px;
	font-size: 20px;
	font-weight: bold;
}

.checkout-btn {
	display: block;
	text-align: center;
	background: #e23744;
	color: white;
	padding: 13px;
	border-radius: 6px;
	text-decoration: none;
	font-weight: bold;
}

.checkout-btn:hover {
	background: #c92f3a;
}

/* Footer */
.footer {
	margin-top: 60px;
	padding: 25px;
	background: #222;
	color: white;
	text-align: center;
}

/* Responsive */
@media ( max-width : 768px) {
	.header {
		padding: 18px 25px;
	}
	.cart-container {
		grid-template-columns: 1fr;
	}
	.cart-item {
		flex-wrap: wrap;
	}
	.item-actions {
		margin-left: auto;
	}
}
</style>

</head>

<body>

	<!-- Header -->

	<%@ include file="navbar.jsp"%>


	<!-- Cart -->

	<div class="container">

		<div class="page-title">

			<h1>Your Cart</h1>

			<p>Review your selected food items</p>

		</div>


		<%
		Cart cart = (Cart) session.getAttribute("cart");

		if (cart == null || cart.getItems().isEmpty()) {
		%>

		<!-- Empty Cart -->

		<div class="empty-cart">

			<h2>Your cart is empty</h2>

			<p>Add some delicious food to your cart.</p>

		</div>

		<%
		} else {
		%>


		<div class="cart-container">


			<!-- Cart Items -->

			<div class="cart-items">

				<%
				for (CartItem item : cart.getItems()) {
				%>


				<div class="cart-item">


					<img src="<%=item.getMenu().getImagePath()%>"
						alt="<%=item.getMenu().getItemName()%>" class="cart-image">


					<div class="item-details">

						<div class="item-name">

							<%=item.getMenu().getItemName()%>

						</div>


						<div class="item-price">

							₹<%=item.getMenu().getPrice()%>

						</div>


						<!-- Quantity -->

						<div class="quantity-controls">


							<a
								href="cart?action=decrease&menuId=<%=item.getMenu().getMenuId()%>"
								class="quantity-btn">−</a> <span class="quantity"> <%=item.getQuantity()%>

							</span> <a
								href="cart?action=increase&menuId=<%=item.getMenu().getMenuId()%>"
								class="quantity-btn">+</a>

						</div>


					</div>


					<!-- Total and Remove -->

					<div class="item-actions">


						<div class="item-total">

							₹<%=item.getTotalPrice()%>

						</div>


						<a
							href="cart?action=remove&menuId=<%=item.getMenu().getMenuId()%>"
							class="remove-btn"> Remove </a>


					</div>


				</div>


				<%
				}
				%>


			</div>


			<!-- Cart Summary -->

			<div class="cart-summary">

				<h2>Cart Summary</h2>


				<div class="total-row">

					<span>Total</span> <span> ₹<%=cart.getTotalPrice()%>
					</span>

				</div>


				<a href="checkout" class="checkout-btn"> Proceed to Checkout </a>

			</div>


		</div>


		<%
		}
		%>


	</div>


	<!-- Footer -->

	<div class="footer">

		<p>© 2026 FoodKart. All rights reserved.</p>

	</div>


</body>

</html>