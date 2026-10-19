
package com.tap.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.tap.dao.OrderDao;
import com.tap.dao.OrderItemDao;
import com.tap.daoimpl.OrderDaoImpl;
import com.tap.daoimpl.OrderItemDaoImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

	private OrderDao orderDao;
	private OrderItemDao orderItemDao;

	@Override
	public void init() {
		orderDao = new OrderDaoImpl();
		orderItemDao = new OrderItemDaoImpl();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		
		if (loggedInUser == null) {
			resp.sendRedirect("login.jsp");
			return;
		}
		req.setAttribute("deliveryAddress", loggedInUser.getAddress());
		Cart cart = (Cart) session.getAttribute("cart");

		if (cart == null || cart.getItems().isEmpty()) {
			resp.sendRedirect("cart");
			return;
		}

		req.getRequestDispatcher("checkout.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		User loggedInUser = (User) session.getAttribute("loggedInUser");

		if (loggedInUser == null) {
			resp.sendRedirect("login.jsp");
			return;
		}
		Cart cart = (Cart) session.getAttribute("cart");

		if (cart == null || cart.getItems().isEmpty()) {
			resp.sendRedirect("cart");
			return;
		}

		String address = req.getParameter("address");
		String paymentMode = req.getParameter("paymentMode");

		if (address == null || address.trim().isEmpty() || paymentMode == null
				|| (!paymentMode.equals("COD") && !paymentMode.equals("ONLINE"))) {

			req.setAttribute("error", "Enter your delivery address and select a payment method.");
			req.getRequestDispatcher("checkout.jsp").forward(req, resp);
			return;
		}

		List<CartItem> items = cart.getItems();

		int restaurantId = items.get(0).getMenu().getRestaurantId();

		// Ensure all cart items belong to the same restaurant.
		for (CartItem item : items) {
			if (item.getMenu().getRestaurantId() != restaurantId) {
				req.setAttribute("error", "Please order from one restaurant at a time.");
				req.getRequestDispatcher("checkout.jsp").forward(req, resp);
				return;
			}
		}

		Order order = new Order();
		order.setUserId(loggedInUser.getUserId());
		order.setRestaurantId(restaurantId);
		order.setOrderDate(new Timestamp(System.currentTimeMillis()));
		order.setTotalAmount(cart.getTotalPrice());
		order.setStatus("PLACED");
		order.setPaymentMode(paymentMode);
		order.setDeliveryAddress(address.trim());

		int orderId = orderDao.addOrder(order);

		if (orderId == -1) {
			req.setAttribute("error", "Unable to place your order. Please try again.");
			req.getRequestDispatcher("checkout.jsp").forward(req, resp);
			return;
		}

		for (CartItem item : items) {
			Menu menu = item.getMenu();

			OrderItem orderItem = new OrderItem();
			orderItem.setOrderId(orderId);
			orderItem.setMenuId(menu.getMenuId());
			orderItem.setQuantity(item.getQuantity());
			orderItem.setTotalAmount(item.getTotalPrice());

			orderItemDao.addOrderItem(orderItem);
		}

		session.setAttribute("deliveryAddress", address.trim());
		session.setAttribute("lastOrderId", orderId);
		session.setAttribute("lastOrderTotal", cart.getTotalPrice());
		session.setAttribute("lastPaymentMode", paymentMode);

		session.removeAttribute("cart");

		resp.sendRedirect("order-confirmation.jsp");
	}
}
