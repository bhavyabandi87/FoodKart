<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodKart - Sign Up</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
}

.signup-container {
    background-color: white;
    padding: 30px;
    width: 350px;
    border-radius: 10px;
    box-shadow: 0 0 10px #ccc;
}

h2 {
    text-align: center;
    color: #e65100;
}

input {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
    box-sizing: border-box;
}

button {
    width: 100%;
    padding: 10px;
    margin-top: 10px;
    background-color: #e65100;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

p {
    text-align: center;
}

a {
    color: #e65100;
    text-decoration: none;
}
</style>
</head>

<body>

<div class="signup-container">
    <h2>Create Account</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color: red;">
            <%= request.getAttribute("errorMessage") %>
        </p>
    <% } %>

    <form action="signup" method="post">

        <input type="text" name="username"
               placeholder="Enter your username" required>

        <input type="email" name="email"
               placeholder="Enter your email" required>

        <input type="password" name="password"
               placeholder="Enter your password" required>

        <input type="tel" name="phone"
               placeholder="Enter your phone number" required>

        <input type="text" name="address"
               placeholder="Enter your address" required>

        <button type="submit">Sign Up</button>
    </form>

    <p>Already have an account? <a href="login.jsp">Login</a></p>
</div>

</body>
</html>