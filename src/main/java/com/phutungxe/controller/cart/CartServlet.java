package com.phutungxe.controller.cart;

import com.phutungxe.dao.impl.CartDAO;
import com.phutungxe.model.entity.CartItem;
import com.phutungxe.model.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

public class CartServlet extends HttpServlet {
    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        System.out.println("CartServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== CartServlet doGet ===");
        System.out.println("URI: " + request.getRequestURI());

        // Chỉ xem giỏ hàng thôi
        viewCart(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== CartServlet doPost ===");

        String action = request.getParameter("action");
        System.out.println("Action: " + action);

        if ("add".equals(action)) {
            addToCart(request, response);
        } else if ("update".equals(action)) {
            updateCart(request, response);
        } else if ("remove".equals(action)) {
            removeFromCart(request, response);
        } else {
            System.out.println("Unknown action, viewing cart");
            viewCart(request, response);
        }
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== viewCart ===");

        HttpSession session = request.getSession();//lay sesion hien tai 
        User user = (User) session.getAttribute("user");//lay dt user trong session

        if (user == null) {
            System.out.println("No user in session, redirect to login");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        System.out.println("User: " + user.getUsername() + " (ID: " + user.getId() + ")");

        List<CartItem> cartItems = cartDAO.getCartItems(user.getId());
        System.out.println("Found " + cartItems.size() + " cart items");

        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            BigDecimal itemTotal = item.getProductPrice().multiply(new BigDecimal(item.getQuantity()));
            total = total.add(itemTotal);
        }

        System.out.println("Total: " + total);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", total);

        System.out.println("Forward to cart.jsp");
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== addToCart ===");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("errorMessage", "Vui lòng đăng nhập");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        System.out.println("ProductId: " + productIdStr);
        System.out.println("Quantity: " + quantityStr);

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            System.out.println("Adding product " + productId + " quantity " + quantity + " for user " + user.getId());

            boolean success = cartDAO.addToCart(user.getId(), productId, quantity);
            System.out.println("Add to cart result: " + success);

            if (success) {
                session.setAttribute("successMessage", "Đã thêm vào giỏ hàng!");//tb loi vao session
            } else {
                session.setAttribute("errorMessage", "Không thể thêm vào giỏ hàng!");
            }

        } catch (Exception e) {
            System.err.println("Error adding to cart: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }

        // Redirect về cart để xem
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== updateCart ===");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        System.out.println("Update ProductId: " + productIdStr + " Quantity: " + quantityStr);

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            boolean success = cartDAO.updateCartItemQuantity(user.getId(), productId, quantity, false);
            System.out.println("Update result: " + success);

            if (success) {
                session.setAttribute("successMessage", "Đã cập nhật giỏ hàng!");
            } else {
                session.setAttribute("errorMessage", "Không thể cập nhật!");
            }

        } catch (Exception e) {
            System.err.println("Error updating cart: " + e.getMessage());
            session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== removeFromCart ===");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String productIdStr = request.getParameter("productId");
        System.out.println("Remove ProductId: " + productIdStr);

        try {
            int productId = Integer.parseInt(productIdStr);

            boolean success = cartDAO.removeFromCart(user.getId(), productId);
            System.out.println("Remove result: " + success);

            if (success) {
                session.setAttribute("successMessage", "Đã xóa khỏi giỏ hàng!");
            } else {
                session.setAttribute("errorMessage", "Không thể xóa!");
            }

        } catch (Exception e) {
            System.err.println("Error removing from cart: " + e.getMessage());
            session.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
