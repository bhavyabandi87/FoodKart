<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List, com.tap.model.Menu,com.tap.model.Cart, com.tap.model.CartItem" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>FoodKart - Menu</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f7f7f7;
    color: #222;
}

/* Header */

.header {
    background: white;
    height: 72px;
    padding: 0 7%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
}

.logo {
    font-size: 30px;
    font-weight: bold;
    color: #e23744;
}

.nav a {
    text-decoration: none;
    color: #333;
    font-size: 15px;
    margin-left: 25px;
}

/* Page */

.container {
    width: 86%;
    max-width: 1250px;
    margin: 35px auto;
}

.page-title {
    margin-bottom: 25px;
}

.page-title h1 {
    font-size: 30px;
    margin-bottom: 8px;
}

.page-title p {
    color: #777;
}

/* Menu Grid */

.menu-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 25px;
}

/* Menu Card */

.menu-card {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

.menu-image {
    width: 100%;
    height: 190px;
    object-fit: cover;
}

.menu-details {
    padding: 18px;
}

.menu-name {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 8px;
}

.menu-description {
    color: #777;
    font-size: 14px;
    margin-bottom: 12px;
}

.menu-price {
    font-size: 17px;
    font-weight: bold;
    margin-bottom: 10px;
}

.available {
    color: #267e3e;
    font-size: 13px;
    font-weight: bold;
    margin-bottom: 12px;
}

.unavailable {
    color: #d62828;
    font-size: 13px;
    font-weight: bold;
}

/* Add to Cart */

.add-cart {
    display: block;
    width: 100%;
    padding: 10px;
    background: #e23744;
    color: white;
    text-align: center;
    text-decoration: none;
    border: none;
    border-radius: 7px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
}

.add-cart:hover {
    background: #c92d39;
}

.quantity-controls {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
    margin-top: 10px;
}

.quantity-btn {
    width: 35px;
    height: 35px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #e23744;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-size: 20px;
    font-weight: bold;
}

.quantity-btn:hover {
    background: #c92d39;
}

.quantity {
    min-width: 20px;
    text-align: center;
    font-weight: bold;
    font-size: 17px;
}
/* Footer */

.footer {
    background: #222;
    color: white;
    text-align: center;
    padding: 25px;
    margin-top: 40px;
}

.footer p {
    color: #bbb;
    font-size: 13px;
}

/* Tablet */

@media (max-width: 950px) {

    .menu-grid {
        grid-template-columns: repeat(2, 1fr);
    }

}

/* Mobile */

@media (max-width: 600px) {

    .container {
        width: 92%;
    }

    .menu-grid {
        grid-template-columns: 1fr;
    }

}

</style>

</head>

<body>

<!-- Header -->

<%@ include file="navbar.jsp" %>


<!-- Menu -->

<div class="container">

    <div class="page-title">

        <h1>Menu</h1>

        <p>
            Choose your favourite food
        </p>

    </div>

<%
    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null) {
        cart = new Cart();
    }
%>
    <div class="menu-grid">

<%

    List<Menu> menuList =
        (List<Menu>) request.getAttribute("allMenu");

    for (Menu menu : menuList) {

%>

        <!-- Menu Card -->

        <div class="menu-card">

            <img
            src="<%= menu.getImagePath() %>"
            alt="<%= menu.getImagePath() %>"
            class="menu-image">
            
                        <div class="menu-details">

                <div class="menu-name">
                    <%= menu.getItemName() %>
                </div>

                <div class="menu-description">
                    <%= menu.getDescription() %>
                </div>

                <div class="menu-price">
                    ₹<%= menu.getPrice() %>
                </div>

<%

                if (menu.isAvailable()) {

%>

                    <div class="available">
                        Available
                    </div>

                    <%
    int quantity = 0;

    for (CartItem item : cart.getItems()) {
        if (item.getMenu().getMenuId() == menu.getMenuId()) {
            quantity = item.getQuantity();
            break;
        }
    }

    if (quantity == 0) {
%>

    <a href="cart?menuId=<%= menu.getMenuId() %>"
       class="add-cart">
        Add to Cart
    </a>

<%
    } else {
%>

    <div class="quantity-controls">

    <a href="cart?action=decrease&menuId=<%= menu.getMenuId() %>&source=menu&restaurantId=<%= menu.getRestaurantId() %>"
       class="quantity-btn">−</a>

    <span class="quantity"><%= quantity %></span>

    <a href="cart?action=increase&menuId=<%= menu.getMenuId() %>&source=menu&restaurantId=<%= menu.getRestaurantId() %>"
       class="quantity-btn">+</a>

</div>

<%
    }
%>

<%

                } else {

%>

                    <div class="unavailable">
                        Currently unavailable
                    </div>

<%

                }

%>

            </div>

        </div>

<%

    }

%>

    </div>

</div>


<!-- Footer -->

<div class="footer">

    <p>
        © 2026 FoodKart. All rights reserved.
    </p>

</div>

</body>

</html>