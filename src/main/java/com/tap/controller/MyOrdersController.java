
package com.tap.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.tap.dao.OrderDao;
import com.tap.daoimpl.OrderDaoImpl;
import com.tap.model.Order;
import com.tap.model.User;

@WebServlet("/my-orders")
public class MyOrdersController extends HttpServlet {

    private OrderDao orderDao;

    @Override
    public void init() {
        orderDao = new OrderDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User loggedInUser =
                (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        List<Order> orders =
                orderDao.getOrdersByUserId(loggedInUser.getUserId());

        req.setAttribute("orders", orders);

        req.getRequestDispatcher("my-orders.jsp")
           .forward(req, resp);
    }
}
