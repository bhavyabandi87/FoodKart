package com.tap.model;

import java.util.ArrayList;
import java.util.List;

public class Cart {

    private List<CartItem> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public List<CartItem> getItems() {
        return items;
    }

    // Add item
    public void addItem(CartItem cartItem) {

        for (CartItem item : items) {

            if (item.getMenu().getMenuId() == cartItem.getMenu().getMenuId()) {

                item.setQuantity(item.getQuantity() + cartItem.getQuantity());
                return;
            }
        }

        items.add(cartItem);
    }

    // Remove item completely
    public void removeItem(int menuId) {

        for (int i = 0; i < items.size(); i++) {

            if (items.get(i).getMenu().getMenuId() == menuId) {
                items.remove(i);
                return;
            }
        }
    }

    // Increase quantity
    public void increaseQuantity(int menuId) {

        for (CartItem item : items) {

            if (item.getMenu().getMenuId() == menuId) {
                item.setQuantity(item.getQuantity() + 1);
                return;
            }
        }
    }

    // Decrease quantity
    public void decreaseQuantity(int menuId) {

        for (int i = 0; i < items.size(); i++) {

            CartItem item = items.get(i);

            if (item.getMenu().getMenuId() == menuId) {

                if (item.getQuantity() > 1) {
                    item.setQuantity(item.getQuantity() - 1);
                } else {
                    items.remove(i);
                }

                return;
            }
        }
    }

    // Calculate total cart price
    public double getTotalPrice() {

        double total = 0;

        for (CartItem item : items) {
            total += item.getTotalPrice();
        }

        return total;
    }

    @Override
    public String toString() {
        return "Cart [items=" + items
                + ", totalPrice=" + getTotalPrice() + "]";
    }
}