package com.phutungxe.controller.order;

import com.phutungxe.dao.impl.CartDAO;
import com.phutungxe.dao.impl.ProductDAO;
import com.phutungxe.dao.impl.OrderDAO;
import com.phutungxe.model.entity.CartItem;
import com.phutungxe.model.entity.Product;
import com.phutungxe.model.entity.User;
import com.phutungxe.model.entity.Order;
import com.phutungxe.model.entity.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;


public class CheckoutServlet extends HttpServlet {
    private CartDAO cartDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();
        System.out.println("CheckoutServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== CheckoutServlet doGet ===");
        System.out.println("URI: " + request.getRequestURI());
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            System.out.println("User not logged in, redirect to login");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Check if direct product purchase
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        
        List<CartItem> checkoutItems = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;
        
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
                    
                    checkoutItems.add(item);
                    total = product.getPrice().multiply(new BigDecimal(quantity));
                    
                    System.out.println("Direct checkout item: " + product.getName() + " x" + quantity);
                }
            } catch (Exception e) {
                System.err.println("Error in direct checkout: " + e.getMessage());
                session.setAttribute("errorMessage", "Sản phẩm không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }
        } else {
            // Checkout from cart
            System.out.println("Cart checkout for user: " + user.getUsername());
            checkoutItems = cartDAO.getCartItems(user.getId());
            
            for (CartItem item : checkoutItems) {
                BigDecimal itemTotal = item.getProductPrice().multiply(new BigDecimal(item.getQuantity()));
                total = total.add(itemTotal);
            }
            
            System.out.println("Cart checkout: " + checkoutItems.size() + " items, total: " + total);
        }
        
        if (checkoutItems.isEmpty()) {
            session.setAttribute("errorMessage", "Giỏ hàng trống");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        request.setAttribute("cartItems", checkoutItems);
        request.setAttribute("totalAmount", total);
        request.setAttribute("isDirectCheckout", productIdStr != null);
        
        System.out.println("Forward to checkout.jsp");
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== CheckoutServlet doPost ===");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Process order
        String shippingAddress = request.getParameter("address");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("paymentMethod");
        String notes = request.getParameter("notes");
        
        System.out.println("Processing order:");
        System.out.println("Address: " + shippingAddress);
        System.out.println("Phone: " + phone);
        System.out.println("Payment: " + paymentMethod);
        
        if (shippingAddress == null || shippingAddress.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }
        
        try {
            // Check if direct checkout or cart checkout
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            
            if (productIdStr != null && quantityStr != null) {
                // Direct product checkout
                int productId = Integer.parseInt(productIdStr);
                int quantity = Integer.parseInt(quantityStr);
                
                Product product = productDAO.getProductById(productId);
                BigDecimal totalAmount = product.getPrice().multiply(new BigDecimal(quantity));
                
                // Create order
                Order order = new Order();
                order.setUserId(user.getId());
                order.setTotalAmount(totalAmount);
                order.setShippingAddress(shippingAddress);
                order.setPhone(phone);
                order.setPaymentMethod(paymentMethod);
                order.setNotes(notes);
                
                // Create order items
                List<OrderItem> orderItems = new ArrayList<>();
                OrderItem item = new OrderItem();
                item.setProductId(productId);
                item.setQuantity(quantity);
                item.setPrice(product.getPrice());
                orderItems.add(item);
                
                boolean success = orderDAO.createOrder(order, orderItems);
                
                System.out.println("Direct order created: " + success);
                
            } else {
                // Cart checkout
                List<CartItem> cartItems = cartDAO.getCartItems(user.getId());
                
                if (cartItems.isEmpty()) {
                    session.setAttribute("errorMessage", "Giỏ hàng trống");
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }
                
                BigDecimal totalAmount = BigDecimal.ZERO;
                for (CartItem item : cartItems) {
                    BigDecimal itemTotal = item.getProductPrice().multiply(new BigDecimal(item.getQuantity()));
                    totalAmount = totalAmount.add(itemTotal);
                }
                
                // Create order
                Order order = new Order();
                order.setUserId(user.getId());
                order.setTotalAmount(totalAmount);
                order.setShippingAddress(shippingAddress);
                order.setPhone(phone);
                order.setPaymentMethod(paymentMethod);
                order.setNotes(notes);
                
                // Create order items
                List<OrderItem> orderItems = new ArrayList<>();
                for (CartItem cartItem : cartItems) {
                    OrderItem item = new OrderItem();
                    item.setProductId(cartItem.getProductId());
                    item.setQuantity(cartItem.getQuantity());
                    item.setPrice(cartItem.getProductPrice());
                    orderItems.add(item);
                }
                
                boolean success = orderDAO.createOrder(order, orderItems);
                
                if (success) {
                    // Clear cart
                    cartDAO.clearCart(user.getId());
                }
                
                System.out.println("Cart order created: " + success);
            }
            
            session.setAttribute("successMessage", "Đặt hàng thành công!");
            response.sendRedirect(request.getContextPath() + "/order?action=history");
            
        } catch (Exception e) {
            System.err.println("Error creating order: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Lỗi khi đặt hàng: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }
}
