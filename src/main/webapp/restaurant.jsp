<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List, com.tap.model.Restaurant" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>FoodKart - Restaurants</title>
<link rel="stylesheet" href="css/restaurant.css">



</head>

<body>

<!-- Header -->

<%@ include file="navbar.jsp" %>


<!-- Hero section -->

<div class="hero">

    <h1>
        Discover <span>great food</span> near you
    </h1>

    <p>
        Explore restaurants, discover delicious cuisines and order your favourite food.
    </p>

</div>


<!-- Restaurant section -->

<div class="container">

    <div class="section-header">

        <h2>Restaurants</h2>

        <p>
            Explore the best restaurants on FoodKart
        </p>

    </div>


    <div class="restaurant-grid">

<%

    List<Restaurant> restaurants =
        (List<Restaurant>) request.getAttribute("restaurants");

    for (Restaurant restaurant : restaurants) {

%>

        <!-- Restaurant Card -->

        <div class="restaurant-card">

            <div class="image-container">

                <img
                    src="<%= restaurant.getImagePath() %>"
                    alt="<%= restaurant.getName() %>"
                    class="restaurant-image">

                <!-- Rating -->

                <div class="rating">
                    ★ <%= restaurant.getRating() %>
                </div>


                <!-- Status -->

                <div class="status">

                <%
                    if (restaurant.isActive()) {
                %>

                    <span class="open">Open</span>

                <%
                    } else {
                %>

                    <span class="closed">Closed</span>

                <%
                    }
                %>

                </div>

            </div>


            <!-- Restaurant Details -->

            <div class="restaurant-details">

                <div class="restaurant-name">
                    <%= restaurant.getName() %>
                </div>

                <div class="cuisine">
                    <%= restaurant.getCuisineType() %>
                </div>

                <div class="info">
                    📍 <%= restaurant.getAddress() %>
                </div>

                <div class="info delivery">
                    🕒 <%= restaurant.getDeliveryTime() %> mins
                </div>

                <a href="menu?restaurantId=<%= restaurant.getRestaurantId() %>" class="view-menu">
                     View Menu
                 </a>

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