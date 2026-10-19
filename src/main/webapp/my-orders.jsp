
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tap.model.Order, com.tap.model.User" %>

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders - FoodKart</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f6f8;
    color: #292929;
}
.container {
    max-width: 850px;
    margin: 35px auto;
    padding: 20px;
}
h1 {
    color: #292929;
}
.order-card {
    background: white;
    border-radius: 12px;
    padding: 22px;
    margin-bottom: 18px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.07);
}
.order-header, .detail-row {
    display: flex;
    justify-content: space-between;
    gap: 15px;
    flex-wrap: wrap;
}
.order-header {
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}
.order-id {
    color: #e65100;
    font-size: 19px;
    font-weight: bold;
}
.detail-row {
    padding-top: 13px;
}
.label {
    color: #777;
}
.status {
    color: #218838;
    font-weight: bold;
}
.empty {
    background: white;
    border-radius: 12px;
    padding: 35px 20px;
    text-align: center;
}
.button {
    display: inline-block;
    background: #e65100;
    color: white;
    padding: 12px 20px;
    border-radius: 7px;
    text-decoration: none;
    margin-top: 15px;
}
@media (max-width: 600px) {
    .container { margin: 15px auto; padding: 12px; }
    .order-card { padding: 16px; }
}
</style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container">
    <h1>My Orders</h1>
    <p>View your previous orders and their details.</p>

    <% if (orders == null || orders.isEmpty()) { %>

        <div class="empty">
            <h2>No orders yet</h2>
            <p>Your placed orders will appear here.</p>
            <a class="button" href="restaurant">Explore Restaurants</a>
        </div>

    <% } else {
        for (Order order : orders) { %>

        <div class="order-card">
            <div class="order-header">
                <span class="order-id">Order #<%= order.getOrderId() %></span>
                <span class="status"><%= order.getStatus() %></span>
            </div>

            <div class="detail-row">
                <span class="label">Order Date</span>
                <span><%= order.getOrderDate() %></span>
            </div>

            <div class="detail-row">
                <span class="label">Total Amount</span>
                <strong>&#8377;<%= String.format("%.2f", order.getTotalAmount()) %></strong>
            </div>

            <div class="detail-row">
                <span class="label">Payment Method</span>
                <span>
                    <%= "COD".equals(order.getPaymentMode())
                        ? "Cash on Delivery" : "Online Payment (Demo)" %>
                </span>
            </div>

            <div class="detail-row">
                <span class="label">Delivery Address</span>
                <span><%= order.getDeliveryAddress() == null
                    ? "Not available" : order.getDeliveryAddress() %></span>
            </div>
        </div>

    <%  }
       } %>

    <a class="button" href="restaurant">Order More Food</a>
</div>

</body>
</html>
