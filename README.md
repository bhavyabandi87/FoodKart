# 🍔 FoodKart – Food Delivery Web Application

FoodKart is a food delivery web application developed using Java, JSP, Servlets, MySQL, HTML, and CSS. It allows users to explore restaurants, view menus, add food items to a cart, place orders, and manage their profiles.

## 🚀 Features

- **User Registration and Login** – Users can create an account and log in securely.
- **Restaurant Listing** – Browse available restaurants.
- **Menu Browsing** – View food items, descriptions, prices, and images.
- **Shopping Cart** – Add food items to the cart and manage quantities.
- **Checkout** – Place orders with the selected food items.
- **Order Confirmation** – View order confirmation after checkout.
- **My Orders** – View previous orders.
- **User Profile** – View and manage profile details.
- **Password Security** – Password hashing using jBCrypt.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java | Backend programming |
| JSP | Dynamic web pages |
| Servlets | Request handling and application logic |
| JDBC | Database connectivity |
| MySQL | Database management |
| HTML | Page structure |
| CSS | Styling and layout |
| Apache Tomcat | Web application server |
| Eclipse IDE | Development environment |
| jBCrypt | Password hashing |

## 📂 Project Structure

```text
FoodKart/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/tap/
│       │       ├── controller/
│       │       ├── dao/
│       │       ├── daoimpl/
│       │       ├── model/
│       │       └── util/
│       └── webapp/
│           ├── WEB-INF/
│           ├── css/
│           ├── index.html
│           ├── restaurant.jsp
│           ├── menu.jsp
│           ├── cart.jsp
│           ├── checkout.jsp
│           ├── login.jsp
│           ├── signup.jsp
│           ├── my-orders.jsp
│           └── my-profile.jsp
├── .classpath
├── .project
└── .gitignore
```

## ⚙️ How to Run the Project

### Prerequisites

- Java JDK
- Eclipse IDE with Web Tools support
- Apache Tomcat
- MySQL Server and MySQL Workbench

### Setup Instructions

1. Clone the repository:

   ```bash
   git clone https://github.com/bhavyabandi87/FoodKart.git
   ```

2. Import the project into Eclipse.

3. Create the `foodkart` database in MySQL and configure the database connection details in `DBConnection.java`.

4. Ensure the required MySQL tables and data are available in the database.

5. Configure Apache Tomcat in Eclipse.

6. Add the project to the Tomcat server and start the server.

7. Open the application in your browser using the local URL provided by Tomcat.

## 🔐 Security

FoodKart uses jBCrypt for password hashing. Database credentials should be configured locally and should not be committed to GitHub.

## 🎯 Project Objective

The objective of FoodKart is to develop a web-based food ordering application that demonstrates Java web development, database connectivity, session management, and order processing.

## 👩‍💻 Developer

**Bhavya Bandi**

GitHub: [bhavyabandi87](https://github.com/bhavyabandi87)

