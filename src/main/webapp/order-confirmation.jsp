
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User" %>

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer orderId = (Integer) session.getAttribute("lastOrderId");
    Double orderTotal = (Double) session.getAttribute("lastOrderTotal");
    String paymentMode = (String) session.getAttribute("lastPaymentMode");

    if (orderId == null || orderTotal == null || paymentMode == null) {
        response.sendRedirect("restaurant.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Confirmed - FoodKart</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f6f8;
    color: #292929;
}

.confirmation-container {
    max-width: 520px;
    margin: 50px auto;
    padding: 20px;
}

.confirmation-card {
    background: white;
    border-radius: 16px;
    padding: 32px 24px;
    text-align: center;
    box-shadow: 0 4px 18px rgba(0, 0, 0, 0.08);
}

.success-icon {
    width: 76px;
    height: 76px;
    line-height: 76px;
    margin: 0 auto 20px;
    border-radius: 50%;
    background: #e5f7eb;
    color: #218838;
    font-size: 42px;
    font-weight: bold;
}

h1 {
    font-size: 28px;
    margin-bottom: 12px;
}

.subtitle {
    color: #666;
    line-height: 1.6;
}

.order-summary {
    margin: 28px 0;
    padding: 20px;
    background: #f8f8f8;
    border-radius: 10px;
    text-align: left;
}

.order-number {
    color: #e65100;
    font-size: 22px;
    font-weight: bold;
    margin: 8px 0 20px;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    gap: 12px;
    padding: 12px 0;
    border-top: 1px solid #e5e5e5;
}

.label {
    color: #666;
}

.status {
    color: #218838;
    font-weight: bold;
}

.action-button {
    display: block;
    box-sizing: border-box;
    width: 100%;
    padding: 14px;
    margin-top: 12px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
}

.primary-button {
    background: #e65100;
    color: white;
}

.secondary-button {
    border: 1px solid #e65100;
    color: #e65100;
}

@media (max-width: 600px) {
    .confirmation-container {
        margin: 20px auto;
        padding: 12px;
    }

    .confirmation-card {
        padding: 26px 18px;
    }

    h1 {
        font-size: 24px;
    }
}
</style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="confirmation-container">
    <div class="confirmation-card">

        <div class="success-icon">&#10003;</div>

        <h1>Order Placed Successfully!</h1>

        <p class="subtitle">
            Thank you, <%= loggedInUser.getUsername() %>!
            Your order has been placed successfully.
        </p>

        <div class="order-summary">

            <div class="label">ORDER NUMBER</div>
            <div class="order-number">#<%= orderId %></div>

            <div class="summary-row">
                <span class="label">Total Amount</span>
                <strong>&#8377;<%= String.format("%.2f", orderTotal) %></strong>
            </div>

            <div class="summary-row">
                <span class="label">Payment Method</span>
                <strong>
                    <%= "COD".equals(paymentMode)
                        ? "Cash on Delivery" : "Online Payment" %>
                </strong>
            </div>

            <div class="summary-row">
                <span class="label">Order Status</span>
                <span class="status">Placed</span>
            </div>

        </div>

        <% if ("COD".equals(paymentMode)) { %>
            <p class="subtitle">
                Please pay when your order is delivered.
            </p>
        <% } else { %>
            <p class="subtitle">
                Online payment is currently in demo mode.
            </p>
        <% } %>

        <a href="my-orders" class="action-button primary-button">
            View My Orders
        </a>

       <a href="restaurant" class="action-button secondary-button">Order More Food</a>

    </div>
</div>

</body>
</html>
