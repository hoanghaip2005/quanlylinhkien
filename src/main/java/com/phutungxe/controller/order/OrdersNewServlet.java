package com.phutungxe.controller.order;

import com.phutungxe.dao.impl.OrderDAO;
import com.phutungxe.model.entity.Order;
import com.phutungxe.model.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class OrdersNewServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        System.out.println("OrdersNewServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== OrdersNewServlet doGet ===");
        
        // Check admin authentication
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || (!"ADMIN".equals(user.getRole()) && !"admin".equals(user.getRole()))) {
            System.out.println("User not admin, redirecting to login. User: " + user + ", Role: " + (user != null ? user.getRole() : "null"));
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        System.out.println("Action: " + action);

        try {
            // Default: list all orders
            listOrders(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in OrdersNewServlet doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/admin/orders_new.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== OrdersNewServlet doPost ===");
        
        // Check admin authentication :kiem tra danh tinh 
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || (!"ADMIN".equals(user.getRole()) && !"admin".equals(user.getRole()))) {
            System.out.println("User not admin, redirecting to login. User: " + user + ", Role: " + (user != null ? user.getRole() : "null"));
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        System.out.println("Action: " + action);

        try {
            if ("updateStatus".equals(action)) {
                updateOrderStatus(request, response);
                return;
            }
            
            // Default: redirect to list
            response.sendRedirect(request.getContextPath() + "/admin/orders_new");
            
        } catch (Exception e) {
            System.out.println("Error in OrdersNewServlet doPost: " + e.getMessage());
            e.printStackTrace();
            HttpSession sessionError = request.getSession();
            sessionError.setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/orders_new");
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== listOrders ===");
        
        try {
            List<Order> orders = orderDAO.getAllOrders();
            System.out.println("Found " + orders.size() + " orders");
            
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/admin/orders_new.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error listing orders: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== updateOrderStatus ===");
        
        try {
            String orderIdStr = request.getParameter("orderId");
            String newStatus = request.getParameter("status");
            
            System.out.println("Updating order " + orderIdStr + " to status: " + newStatus);
            
            if (orderIdStr != null && newStatus != null) {
                int orderId = Integer.parseInt(orderIdStr);
                boolean success = orderDAO.updateOrderStatus(orderId, newStatus);
                
                HttpSession session1 = request.getSession();
                if (success) {
                    System.out.println("Order status updated successfully");
                    session1.setAttribute("message", "Cập nhật trạng thái đơn hàng thành công!");
                } else {
                    System.out.println("Failed to update order status");
                    session1.setAttribute("error", "Không thể cập nhật trạng thái đơn hàng!");
                }
            } else {
                HttpSession session2 = request.getSession();
                session2.setAttribute("error", "Thiếu thông tin đơn hàng hoặc trạng thái!");
            }
            
        } catch (Exception e) {
            System.out.println("Error updating order status: " + e.getMessage());
            e.printStackTrace();
            HttpSession session3 = request.getSession();
            session3.setAttribute("error", "Lỗi khi cập nhật: " + e.getMessage());
        }
        
        // Always redirect back to order list
        response.sendRedirect(request.getContextPath() + "/admin/orders_new");
    }
}
