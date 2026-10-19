<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodKart - Login</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.login-container {
    background-color: white;
    padding: 30px;
    width: 320px;
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
    margin: 10px 0;
    box-sizing: border-box;
}

button {
    width: 100%;
    padding: 10px;
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

<div class="login-container">
    <h2>FoodKart Login</h2>
     <% if (request.getAttribute("errorMessage") != null) { %>
    <p style="color: red;">
        <%= request.getAttribute("errorMessage") %>
    </p>
<% } %>
    <form action="login" method="post">
        <input type="email" name="email" placeholder="Enter your email" required>

        <input type="password" name="password" placeholder="Enter your password" required>

        <button type="submit">Login</button>
    </form>

    <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
</div>

</body>
</html>