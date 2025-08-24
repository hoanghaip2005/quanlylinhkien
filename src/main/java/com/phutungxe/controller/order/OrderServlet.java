package com.phutungxe.controller.order;

import com.phutungxe.dao.impl.CartDAO;
import com.phutungxe.dao.impl.OrderDAO;
import com.phutungxe.dao.impl.ProductDAO;
import com.phutungxe.model.entity.CartItem;
import com.phutungxe.model.entity.Order;
import com.phutungxe.model.entity.OrderItem;
import com.phutungxe.model.entity.Product;
import com.phutungxe.model.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private CartDAO cartDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        cartDAO = new CartDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== OrderServlet doGet ===");
        System.out.println("URI: " + request.getRequestURI());

        String action = request.getParameter("action");
        System.out.println("Action: " + action);
        if (action == null) {
            action = "checkout";
        }

        switch (action) {
            case "checkout":
                showCheckout(request, response);
                break;
            case "history":
                showOrderHistory(request, response);
                break;
            case "detail":
                showOrderDetail(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cart");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "place";
        }

        switch (action) {
            case "place":
                placeOrder(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cart");
                break;
        }
    }

    private void showCheckout(HttpServletRequest request, HttpServletResponse response)//hien thi trang thanh toan
            throws ServletException, IOException {

        System.out.println("=== showCheckout ===");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        System.out.println("User: " + (user != null ? user.getUsername() : "null"));

        if (user == null) {
            System.out.println("No user, redirect to login");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Check if direct product purchase
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        List<CartItem> cartItems = new ArrayList<>();
        BigDecimal totalAmount = BigDecimal.ZERO;

        if (productIdStr != null && quantityStr != null) {
            // Direct product purchase
            System.out.println("Direct checkout: product=" + productIdStr + " quantity=" + quantityStr);
            try {
                int productId = Integer.parseInt(productIdStr);
                int quantity = Integer.parseInt(quantityStr);

                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    // Create temporary cart item for checkout
                    CartItem item = new CartItem();
                    item.setProductId(productId);
                    item.setQuantity(quantity);
                    item.setProductName(product.getName());
                    item.setProductPrice(product.getPrice());
                    item.setProductImage(product.getImage());
                    item.setStockQuantity(product.getStockQuantity());

                    cartItems.add(item);
                    totalAmount = product.getPrice().multiply(new BigDecimal(quantity));

                    System.out.println("Direct checkout item: " + product.getName() + " x" + quantity);
                }
            } catch (Exception e) {
                System.err.println("Error in direct checkout: " + e.getMessage());
                session.setAttribute("errorMessage", "Sản phẩm không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }
        } else {
            // Regular cart checkout
            cartItems = cartDAO.getCartItems(user.getId());
            System.out.println("Cart items: " + cartItems.size());

            if (cartItems.isEmpty()) {
                System.out.println("Cart empty, redirect to cart");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            totalAmount = calculateTotal(cartItems);
        }

        System.out.println("Total amount: " + totalAmount);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("user", user);
        request.setAttribute("isDirectCheckout", productIdStr != null);

        System.out.println("Forward to checkout.jsp");
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    private void placeOrder(HttpServletRequest request, HttpServletResponse response)//thu hien quy trinh dat hang
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        String notes = request.getParameter("notes");

        String errorMessage = validateOrderInput(fullName, phone, address, paymentMethod);

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            showCheckout(request, response);
            return;
        }

        List<CartItem> cartItems = new ArrayList<>();

        // Check if this is direct product checkout
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        System.out.println("Direct checkout - productId: " + productIdStr + ", quantity: " + quantityStr);

        if (productIdStr != null && quantityStr != null) {
            // Direct product checkout
            try {
                int productId = Integer.parseInt(productIdStr);
                int quantity = Integer.parseInt(quantityStr);

                Product product = productDAO.getProductById(productId);
                if (product == null) {
                    request.setAttribute("errorMessage", "Sản phẩm không tồn tại");
                    showCheckout(request, response);
                    return;
                }

                if (product.getStockQuantity() < quantity) {
                    request.setAttribute("errorMessage",
                            "Sản phẩm " + product.getName() + " không đủ số lượng trong kho");
                    showCheckout(request, response);
                    return;
                }

                // Create cart item for direct checkout
                CartItem directItem = new CartItem();
                directItem.setProductId(productId);
                directItem.setProductName(product.getName());
                directItem.setProductPrice(product.getPrice());
                directItem.setQuantity(quantity);
                directItem.setStockQuantity(product.getStockQuantity());
                cartItems.add(directItem);

                System.out.println("Direct checkout item created: " + product.getName() + " x " + quantity);

            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Thông tin sản phẩm không hợp lệ");
                showCheckout(request, response);
                return;
            }
        } else {
            // Normal cart checkout
            cartItems = cartDAO.getCartItems(user.getId());

            if (cartItems.isEmpty()) {
                request.setAttribute("errorMessage", "Giỏ hàng trống");
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            // Validate stock availability
            for (CartItem item : cartItems) {
                if (item.getStockQuantity() < item.getQuantity()) {
                    request.setAttribute("errorMessage",
                            "Sản phẩm " + item.getProductName() + " không đủ số lượng trong kho");
                    showCheckout(request, response);
                    return;
                }
            }
        }

        BigDecimal totalAmount = calculateTotal(cartItems);
        String shippingAddress = fullName + "\n" + phone + "\n" + address;

        // Create order
        Order order = new Order(user.getId(), totalAmount, shippingAddress, phone, paymentMethod, notes);

        // Create order items
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cartItems) {
            OrderItem orderItem = new OrderItem(0, cartItem.getProductId(),
                    cartItem.getQuantity(), cartItem.getProductPrice());
            orderItems.add(orderItem);
        }

        // Save order
        boolean success = orderDAO.createOrder(order, orderItems);

        if (success) {
            // Update product stock
            for (CartItem cartItem : cartItems) {
                int newStock = cartItem.getStockQuantity() - cartItem.getQuantity();
                productDAO.updateStock(cartItem.getProductId(), newStock);
            }

            // Clear cart only if this is cart checkout (not direct checkout)
            if (productIdStr == null || quantityStr == null) {
                cartDAO.clearCart(user.getId());
                System.out.println("Cart cleared after cart checkout");
            } else {
                System.out.println("Direct checkout - cart not cleared");
            }

            request.setAttribute("order", order);
            request.setAttribute("successMessage", "Đặt hàng thành công!");
            response.sendRedirect(request.getContextPath() + "/order?action=history");
        } else {
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình đặt hàng");
            showCheckout(request, response);
        }
    }

    private void showOrderHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== showOrderHistory called ===");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        System.out.println("User from session: " + user);
        if (user != null) {
            System.out.println("User ID: " + user.getId());
            System.out.println("Username: " + user.getUsername());
        }

        if (user == null) {
            System.out.println("User is null, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            System.out.println("Getting orders for user ID: " + user.getId());
            List<Order> orders = orderDAO.getOrdersByUser(user.getId());
            System.out.println("Found " + orders.size() + " orders");

            request.setAttribute("orders", orders);
            request.setAttribute("user", user);

            System.out.println("Forwarding to /simple-order-history.jsp");
            request.getRequestDispatcher("/simple-order-history.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("Error in showOrderHistory: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy lịch sử đơn hàng");
        }
    }

    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String orderIdStr = request.getParameter("id");
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order?action=history");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            Order order = orderDAO.getOrderById(orderId);

            if (order == null || order.getUserId() != user.getId()) {
                response.sendRedirect(request.getContextPath() + "/order?action=history");
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("/order-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/order?action=history");
        }
    }
    //ktra xac minh tinh dung dan cua nhap dl
    private String validateOrderInput(String fullName, String phone, String address, String paymentMethod) {
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Vui lòng nhập họ tên";
        }

        if (phone == null || phone.trim().isEmpty()) {
            return "Vui lòng nhập số điện thoại";
        }

        if (address == null || address.trim().isEmpty()) {
            return "Vui lòng nhập địa chỉ giao hàng";
        }

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            return "Vui lòng chọn phương thức thanh toán";
        }

        return null;
    }

    private BigDecimal calculateTotal(List<CartItem> cartItems) {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            total = total.add(item.getTotalPrice());
        }
        return total;
    }
}
