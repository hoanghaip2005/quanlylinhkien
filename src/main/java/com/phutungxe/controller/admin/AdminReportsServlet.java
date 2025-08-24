package com.phutungxe.controller.admin;

import com.phutungxe.dao.impl.UserDAO;
import com.phutungxe.dao.impl.ProductDAO;
import com.phutungxe.dao.impl.OrderDAO;
import com.phutungxe.dao.impl.CategoryDAO;
import com.phutungxe.model.entity.User;
import com.phutungxe.model.entity.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.HashMap;


public class AdminReportsServlet extends HttpServlet {

    private UserDAO userDAO;
    private ProductDAO productDAO;
    private OrderDAO orderDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null)
            action = "dashboard";

        switch (action) {
            case "dashboard":
                showReportsDashboard(request, response);
                break;
            case "sales":
                showSalesReport(request, response);
                break;
            case "products":
                showProductsReport(request, response);
                break;
            case "users":
                showUsersReport(request, response);
                break;
            default:
                showReportsDashboard(request, response);
                break;
        }
    }

    private void showReportsDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thống kê tổng quan
        Map<String, Object> stats = generateReportsStats();
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }

    private void showSalesReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Order> orders = orderDAO.getAllOrders();
        Map<String, Object> salesStats = generateSalesStats(orders);

        request.setAttribute("orders", orders);
        request.setAttribute("salesStats", salesStats);

        request.getRequestDispatcher("/admin/reports-sales.jsp").forward(request, response);
    }

    private void showProductsReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, Object> productStats = generateProductStats();

        request.setAttribute("productStats", productStats);

        request.getRequestDispatcher("/admin/reports-products.jsp").forward(request, response);
    }

    private void showUsersReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = userDAO.getAllUsers();
        Map<String, Object> userStats = generateUserStats(users);

        request.setAttribute("users", users);
        request.setAttribute("userStats", userStats);

        request.getRequestDispatcher("/admin/reports-users.jsp").forward(request, response);
    }

    private Map<String, Object> generateReportsStats() {
        Map<String, Object> stats = new HashMap<>();

        try {
            // Thống kê cơ bản
            List<User> users = userDAO.getAllUsers();
            List<Order> orders = orderDAO.getAllOrders();

            stats.put("totalUsers", users.size());
            stats.put("totalOrders", orders.size());
            stats.put("totalProducts", productDAO.getAllProducts().size());
            stats.put("totalCategories", categoryDAO.getAllCategories().size());

            // Thống kê doanh thu
            BigDecimal totalRevenue = BigDecimal.ZERO;
            int completedOrders = 0;

            for (Order order : orders) {
                if ("DELIVERED".equals(order.getStatus())) {
                    totalRevenue = totalRevenue.add(order.getTotalAmount());
                    completedOrders++;
                }
            }

            stats.put("totalRevenue", totalRevenue);
            stats.put("completedOrders", completedOrders);
            stats.put("pendingOrders", orders.size() - completedOrders);

            // Thống kê users theo role
            int adminCount = 0, userCount = 0;
            for (User u : users) {
                if ("ADMIN".equals(u.getRole()))
                    adminCount++;
                else
                    userCount++;
            }
            stats.put("adminCount", adminCount);
            stats.put("userCount", userCount);

        } catch (Exception e) {
            e.printStackTrace();
            stats.put("error", "Unable to load statistics");
        }

        return stats;
    }

    private Map<String, Object> generateSalesStats(List<Order> orders) {
        Map<String, Object> stats = new HashMap<>();

        BigDecimal totalRevenue = BigDecimal.ZERO;
        BigDecimal monthlyRevenue = BigDecimal.ZERO;
        int totalOrders = orders.size();
        int completedOrders = 0;
        int pendingOrders = 0;

        for (Order order : orders) {
            if ("DELIVERED".equals(order.getStatus())) {
                totalRevenue = totalRevenue.add(order.getTotalAmount());
                completedOrders++;
            } else if ("PENDING".equals(order.getStatus()) || "CONFIRMED".equals(order.getStatus())) {
                pendingOrders++;
            }
        }

        stats.put("totalRevenue", totalRevenue);
        stats.put("monthlyRevenue", monthlyRevenue);
        stats.put("totalOrders", totalOrders);
        stats.put("completedOrders", completedOrders);
        stats.put("pendingOrders", pendingOrders);

        return stats;
    }

    private Map<String, Object> generateProductStats() {
        Map<String, Object> stats = new HashMap<>();

        try {
            int totalProducts = productDAO.getAllProducts().size();
            int activeProducts = 0;
            int lowStockProducts = 0;

            // This would need actual product data to calculate properly
            stats.put("totalProducts", totalProducts);
            stats.put("activeProducts", activeProducts);
            stats.put("lowStockProducts", lowStockProducts);

        } catch (Exception e) {
            e.printStackTrace();
            stats.put("error", "Unable to load product statistics");
        }

        return stats;
    }

    private Map<String, Object> generateUserStats(List<User> users) {
        Map<String, Object> stats = new HashMap<>();

        int totalUsers = users.size();
        int activeUsers = 0;
        int adminUsers = 0;
        int regularUsers = 0;

        for (User user : users) {
            if ("ACTIVE".equals(user.getStatus())) {
                activeUsers++;
            }
            if ("ADMIN".equals(user.getRole())) {
                adminUsers++;
            } else {
                regularUsers++;
            }
        }

        stats.put("totalUsers", totalUsers);
        stats.put("activeUsers", activeUsers);
        stats.put("adminUsers", adminUsers);
        stats.put("regularUsers", regularUsers);

        return stats;
    }
}
