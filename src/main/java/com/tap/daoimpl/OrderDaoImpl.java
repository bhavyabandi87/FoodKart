package com.tap.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderDao;
import com.tap.model.Order;
import com.tap.util.DBConnection;

public class OrderDaoImpl implements OrderDao {

	@Override
	public int addOrder(Order order) {

		String sql = "INSERT INTO orders "
				+ "(userId, restaurantId, orderDate, totalAmount, status, paymentMode, delivery_address) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {

			ps.setInt(1, order.getUserId());
			ps.setInt(2, order.getRestaurantId());
			ps.setTimestamp(3, order.getOrderDate());
			ps.setDouble(4, order.getTotalAmount());
			ps.setString(5, order.getStatus());
			ps.setString(6, order.getPaymentMode());
			ps.setString(7, order.getDeliveryAddress());

			int rows = ps.executeUpdate();

			if (rows > 0) {
				try (ResultSet rs = ps.getGeneratedKeys()) {
					if (rs.next()) {
						return rs.getInt(1);
					}
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;
	}

	@Override
	public Order getOrder(int orderId) {

		String sql = "SELECT * FROM orders WHERE orderId = ?";
		Order order = null;

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, orderId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				order = new Order();

				order.setOrderId(rs.getInt("orderId"));
				order.setUserId(rs.getInt("userId"));
				order.setRestaurantId(rs.getInt("restaurantId"));
				order.setOrderDate(rs.getTimestamp("orderDate"));
				order.setTotalAmount(rs.getDouble("totalAmount"));
				order.setStatus(rs.getString("status"));
				order.setPaymentMode(rs.getString("paymentMode"));
				order.setDeliveryAddress(rs.getString("delivery_address"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return order;
	}

	@Override
	public List<Order> getAllOrders() {

		String sql = "SELECT * FROM orders";
		List<Order> orders = new ArrayList<>();

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {

				Order order = new Order();

				order.setOrderId(rs.getInt("orderId"));
				order.setUserId(rs.getInt("userId"));
				order.setRestaurantId(rs.getInt("restaurantId"));
				order.setOrderDate(rs.getTimestamp("orderDate"));
				order.setTotalAmount(rs.getDouble("totalAmount"));
				order.setStatus(rs.getString("status"));
				order.setPaymentMode(rs.getString("paymentMode"));
				order.setDeliveryAddress(rs.getString("delivery_address"));

				orders.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orders;
	}

	@Override
	public List<Order> getOrdersByUserId(int userId) {

		String sql = "SELECT * FROM orders WHERE userId = ?";
		List<Order> orders = new ArrayList<>();

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Order order = new Order();

				order.setOrderId(rs.getInt("orderId"));
				order.setUserId(rs.getInt("userId"));
				order.setRestaurantId(rs.getInt("restaurantId"));
				order.setOrderDate(rs.getTimestamp("orderDate"));
				order.setTotalAmount(rs.getDouble("totalAmount"));
				order.setStatus(rs.getString("status"));
				order.setPaymentMode(rs.getString("paymentMode"));
				order.setDeliveryAddress(rs.getString("delivery_address"));

				orders.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orders;
	}

	@Override
	public List<Order> getOrdersByRestaurantId(int restaurantId) {

		String sql = "SELECT * FROM orders WHERE restaurantId = ?";
		List<Order> orders = new ArrayList<>();

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, restaurantId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Order order = new Order();

				order.setOrderId(rs.getInt("orderId"));
				order.setUserId(rs.getInt("userId"));
				order.setRestaurantId(rs.getInt("restaurantId"));
				order.setOrderDate(rs.getTimestamp("orderDate"));
				order.setTotalAmount(rs.getDouble("totalAmount"));
				order.setStatus(rs.getString("status"));
				order.setPaymentMode(rs.getString("paymentMode"));
				order.setDeliveryAddress(rs.getString("delivery_address"));

				orders.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orders;
	}

	@Override
	public void updateOrder(Order order) {

		String sql = "UPDATE orders SET userId = ?, restaurantId = ?, "
				+ "orderDate = ?, totalAmount = ?, status = ?, paymentMode = ?, "
				+ "delivery_address = ? WHERE orderId = ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, order.getUserId());
			ps.setInt(2, order.getRestaurantId());
			ps.setTimestamp(3, order.getOrderDate());
			ps.setDouble(4, order.getTotalAmount());
			ps.setString(5, order.getStatus());
			ps.setString(6, order.getPaymentMode());
			ps.setString(7, order.getDeliveryAddress());
			ps.setInt(8, order.getOrderId());

			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrder(int orderId) {

		String sql = "DELETE FROM orders WHERE orderId = ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, orderId);

			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}