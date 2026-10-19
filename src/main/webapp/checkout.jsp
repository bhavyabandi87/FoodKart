
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="java.util.List" %>

<%
    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("cart");
        return;
    }

    List<CartItem> items = cart.getItems();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodKart - Checkout</title>

<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: #f5f5f5;
        color: #333;
    }

    .header {
        background: #fc8019;
        color: white;
        padding: 18px 8%;
        font-size: 25px;
        font-weight: bold;
    }

    .container {
        max-width: 900px;
        margin: 35px auto;
        padding: 0 15px;
    }

    .section {
        background: white;
        padding: 25px;
        margin-bottom: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    }

    h1 {
        margin-bottom: 25px;
    }

    h2 {
        margin-top: 0;
        font-size: 21px;
    }

    .item {
        display: flex;
        justify-content: space-between;
        gap: 15px;
        padding: 15px 0;
        border-bottom: 1px solid #eee;
    }

    .item-name {
        flex: 1;
    }

    .muted {
        color: #777;
        font-size: 14px;
        margin-top: 6px;
    }

    textarea {
        box-sizing: border-box;
        width: 100%;
        min-height: 100px;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font: inherit;
        resize: vertical;
    }

    .payment-option {
        display: block;
        padding: 15px;
        margin: 12px 0;
        border: 1px solid #ddd;
        border-radius: 7px;
        cursor: pointer;
    }

    .payment-option:hover {
        border-color: #fc8019;
    }

    .payment-option input {
        margin-right: 10px;
    }

    .total {
        display: flex;
        justify-content: space-between;
        gap: 15px;
        font-size: 20px;
        font-weight: bold;
        margin-top: 22px;
    }

    .error {
        background: #ffe8e8;
        color: #a40000;
        padding: 12px;
        border-radius: 6px;
        margin-bottom: 18px;
    }

    .place-order {
        width: 100%;
        border: none;
        background: #fc8019;
        color: white;
        padding: 15px;
        border-radius: 7px;
        font-size: 17px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 15px;
    }

    .place-order:hover {
        background: #e66c0a;
    }

    .back {
        display: inline-block;
        color: #fc8019;
        text-decoration: none;
        margin-bottom: 20px;
    }

    @media (max-width: 600px) {
        .section {
            padding: 18px;
        }

        .total {
            font-size: 18px;
        }
    }
</style>
</head>

<body>

<div class="header">FoodKart</div>

<div class="container">

    <a href="cart" class="back">&larr; Back to Cart</a>

    <h1>Checkout</h1>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="checkout" method="post">

        <div class="section">
            <h2>1. Delivery Address</h2>

            <textarea name="address" rows="4" required><%= request.getAttribute("deliveryAddress") != null
    ? request.getAttribute("deliveryAddress") : "" %></textarea>
        </div>

        <div class="section">
            <h2>2. Order Summary</h2>

            <% for (CartItem item : items) { %>
                <div class="item">
                    <div class="item-name">
                        <strong><%= item.getMenu().getItemName() %></strong>

                        <div class="muted">
                            &#8377;<%= String.format("%.2f",
                                item.getMenu().getPrice()) %>
                            &times; <%= item.getQuantity() %>
                        </div>
                    </div>

                    <strong>
                        &#8377;<%= String.format("%.2f",
                            item.getTotalPrice()) %>
                    </strong>
                </div>
            <% } %>

            <div class="total">
                <span>Total Amount</span>
                <span>
                    &#8377;<%= String.format("%.2f",
                        cart.getTotalPrice()) %>
                </span>
            </div>
        </div>

        <div class="section">
            <h2>3. Payment Method</h2>

            <label class="payment-option">
                <input type="radio" name="paymentMode"
                    value="COD" required>
                Cash on Delivery
            </label>

            <label class="payment-option">
                <input type="radio" name="paymentMode"
                    value="ONLINE" required>
                Online Payment
            </label>

            <button type="submit" class="place-order">
                Place Order
            </button>
        </div>

    </form>
</div>

</body>
</html>
