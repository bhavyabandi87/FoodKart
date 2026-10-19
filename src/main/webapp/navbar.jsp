<%@ page import="com.tap.model.User" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<style>
.navbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 15px 5%;
    background-color: white;
    box-shadow: 0 2px 8px #ddd;
    font-family: Arial, sans-serif;
}

.navbar a {
    text-decoration: none;
    color: #333;
    margin-left: 22px;
    font-weight: bold;
}

.navbar .logo {
    color: #e65100;
    font-size: 25px;
    margin-left: 0;
}

.navbar .actions {
    display: flex;
    align-items: center;
}

.navbar .login-link {
    color: #e65100;
}

.navbar .cart-link {
    color: #e65100;
}

.profile-menu {
    position: relative;
    display: inline-block;
    margin-left: 22px;
}

.profile-button {
    background: none;
    border: none;
    color: #333;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
}

.profile-dropdown {
    display: none;
    position: absolute;
    right: 0;
    top: 100%;
    background: white;
    min-width: 150px;
    box-shadow: 0 2px 8px #ccc;
    border-radius: 6px;
    z-index: 1000;
}

.profile-dropdown a {
    display: block;
    margin: 0;
    padding: 12px;
}

.profile-dropdown a:hover {
    background-color: #f5f5f5;
}

.profile-menu:hover .profile-dropdown,
.profile-menu:focus-within .profile-dropdown {
    display: block;
}

@media (max-width: 600px) {
    .navbar {
        padding: 12px;
        flex-wrap: wrap;
        gap: 12px;
    }

    .navbar a {
        margin-left: 10px;
    }

    .navbar .actions {
        flex-wrap: wrap;
        gap: 8px;
    }
}
</style>

<nav class="navbar">
    <a class="logo" href="restaurant">FoodKart</a>

    <div class="actions">
        <a href="restaurant">Restaurants</a>
        <a class="cart-link" href="cart">Cart</a>

        <%
            User loggedInUser =
                (User) session.getAttribute("loggedInUser");
        %>

        <% if (loggedInUser == null) { %>

            <a class="login-link" href="login.jsp">Login</a>

        <% } else { %>

            <div class="profile-menu">
        <button class="profile-button" type="button">
    &#128100; <%= loggedInUser.getUsername() %>
</button>
               <div class="profile-dropdown">
    <a href="profile">My Profile</a>
    <a href="my-orders">My Orders</a>
    <a href="logout">Logout</a>
</div>
            </div>

        <% } %>
    </div>
</nav>