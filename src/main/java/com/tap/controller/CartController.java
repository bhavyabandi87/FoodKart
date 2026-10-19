package com.tap.controller;

import java.io.IOException;

import com.tap.dao.MenuDao;
import com.tap.daoimpl.MenuDaoImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private MenuDao menuDao;

    @Override
    public void init() throws ServletException {
        menuDao = new MenuDaoImpl();
    }


@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

    String action = req.getParameter("action");
    String menuIdParameter = req.getParameter("menuId");
    String source = req.getParameter("source");
    String restaurantId = req.getParameter("restaurantId");

    HttpSession session = req.getSession();

    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null) {
        cart = new Cart();
    }

    if (menuIdParameter != null && action == null) {

        int menuId = Integer.parseInt(menuIdParameter);
        Menu menu = menuDao.getMenu(menuId);

        if (menu != null) {
            cart.addItem(new CartItem(menu, 1));
            restaurantId = String.valueOf(menu.getRestaurantId());
        }

        session.setAttribute("cart", cart);

        resp.sendRedirect("menu?restaurantId=" + restaurantId);
        return;
    }

    if ("remove".equals(action)) {
        int menuId = Integer.parseInt(menuIdParameter);
        cart.removeItem(menuId);

    } else if ("increase".equals(action)) {
        int menuId = Integer.parseInt(menuIdParameter);
        cart.increaseQuantity(menuId);

    } else if ("decrease".equals(action)) {
        int menuId = Integer.parseInt(menuIdParameter);
        cart.decreaseQuantity(menuId);
    }

    session.setAttribute("cart", cart);

    if ("menu".equals(source) && restaurantId != null) {
        resp.sendRedirect("menu?restaurantId=" + restaurantId);
    } else {
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }
}

}