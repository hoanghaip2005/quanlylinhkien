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

public class SimpleOrderServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();//tao doi tuong tuong tac csdl
        System.out.println("SimpleOrderServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {//lay va hien thi ds don hang
        
        System.out.println("=== SimpleOrderServlet doGet ===");
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");//lay dt user da luu trong ss.dt xdinh nd dang dn
        
        System.out.println("User: " + user);
        if (user != null) {
            System.out.println("User role: " + user.getRole());
        }
        
        // Very simple check - just need to be logged in
        if (user == null) {
            System.out.println("User not logged in, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<Order> orders = orderDAO.getAllOrders();
            System.out.println("Found " + orders.size() + " orders");
            
            // Debug: print first order details
            if (!orders.isEmpty()) {
                Order firstOrder = orders.get(0);
                System.out.println("First order ID: " + firstOrder.getId());
                System.out.println("First order userName: " + firstOrder.getUserName());
                System.out.println("First order phone: " + firstOrder.getPhone());
                System.out.println("First order totalAmount: " + firstOrder.getTotalAmount());
            }
            
            request.setAttribute("orders", orders);//luu ds don hang vao dt request voi ten thuoc tinh order
            request.setAttribute("currentUser", user);
            request.getRequestDispatcher("/admin/simple-orders.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in SimpleOrderServlet: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {//xu ly yeu cau, gui du lieu tu form
        
        System.out.println("=== SimpleOrderServlet doPost ===");
        
        // Check if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");//lay tham so action tu form
        System.out.println("Action: " + action);

        if ("updateStatus".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));//lay id
                String status = request.getParameter("status");//lay trang thai
                
                System.out.println("Updating order " + orderId + " to status: " + status);
                
                boolean success = orderDAO.updateOrderStatus(orderId, status);
                
                if (success) {
                    System.out.println("Order status updated successfully");
                } else {
                    System.out.println("Failed to update order status");
                }
                
            } catch (Exception e) {
                System.out.println("Error updating order status: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        // Redirect back to list
        response.sendRedirect(request.getContextPath() + "/admin/simple-orders");
    }
}
