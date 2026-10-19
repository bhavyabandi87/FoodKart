
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.User" %>

<%
    User user = (User) request.getAttribute("user");

    if (user == null) {
        response.sendRedirect("profile");
        return;
    }

    boolean updated = "true".equals(request.getParameter("updated"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile - FoodKart</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f6f8;
    color: #292929;
}
.container {
    max-width: 650px;
    margin: 35px auto;
    padding: 25px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.08);
}
h1 {
    margin-top: 0;
}
.subtitle {
    color: #777;
    margin-bottom: 25px;
}
.form-group {
    margin-bottom: 18px;
}
label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
}
input, textarea {
    width: 100%;
    box-sizing: border-box;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 7px;
    font-size: 15px;
}
textarea {
    resize: vertical;
}
button, .back-link {
    display: inline-block;
    padding: 12px 20px;
    border: none;
    border-radius: 7px;
    text-decoration: none;
    font-size: 15px;
    cursor: pointer;
}
button {
    background: #e65100;
    color: white;
}
.back-link {
    background: #eee;
    color: #292929;
    margin-left: 8px;
}
.success {
    padding: 12px;
    background: #e8f5e9;
    color: #218838;
    border-radius: 7px;
    margin-bottom: 20px;
}
</style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container">
    <h1>My Profile</h1>
    <p class="subtitle">View and update your FoodKart account details.</p>

    <% if (updated) { %>
        <div class="success">Your profile has been updated successfully.</div>
    <% } %>

    <form action="profile" method="post">

        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username"
                value="<%= user.getUsername() == null ? "" : user.getUsername() %>"
                required>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email"
                value="<%= user.getEmail() == null ? "" : user.getEmail() %>"
                required>
        </div>

        <div class="form-group">
            <label for="phone">Phone</label>
            <input type="tel" id="phone" name="phone"
                value="<%= user.getPhone() == null ? "" : user.getPhone() %>">
        </div>

        <div class="form-group">
            <label for="address">Delivery Address</label>
            <textarea id="address" name="address" rows="4"><%= user.getAddress() == null ? "" : user.getAddress() %></textarea>
        </div>

        <button type="submit">Save Changes</button>
        <a href="restaurant" class="back-link">Back to Restaurants</a>

    </form>
</div>

</body>
</html>
