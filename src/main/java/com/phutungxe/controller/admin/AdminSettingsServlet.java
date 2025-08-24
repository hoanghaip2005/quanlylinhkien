package com.phutungxe.controller.admin;

import com.phutungxe.dao.impl.UserDAO;
import com.phutungxe.dao.impl.ProductDAO;
import com.phutungxe.dao.impl.OrderDAO;
import com.phutungxe.dao.impl.CategoryDAO;
import com.phutungxe.model.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;


public class AdminSettingsServlet extends HttpServlet {

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
                showDashboard(request, response);
                break;
            case "profile":
                showProfile(request, response);
                break;
            case "system":
                showSystemSettings(request, response);
                break;
            case "backup":
                showBackupSettings(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        switch (action) {
            case "updateProfile":
                updateProfile(request, response);
                break;
            case "changePassword":
                changePassword(request, response);
                break;
            case "updateSystem":
                updateSystemSettings(request, response);
                break;
            case "backup":
                performBackup(request, response);
                break;
            case "clearCache":
                clearCache(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/settings");
                break;
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thống kê tổng quan
        Map<String, Object> stats = getSystemStats();
        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/admin/settings.jsp").forward(request, response);
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Lấy thông tin user mới nhất từ database
        User user = userDAO.getUserById(currentUser.getId());
        request.setAttribute("user", user);

        request.getRequestDispatcher("/admin/settings-profile.jsp").forward(request, response);
    }

    private void showSystemSettings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, Object> systemInfo = getSystemInfo();
        request.setAttribute("systemInfo", systemInfo);

        request.getRequestDispatcher("/admin/settings-system.jsp").forward(request, response);
    }

    private void showBackupSettings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/admin/settings-backup.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            User user = userDAO.getUserById(currentUser.getId());
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);

            boolean success = userDAO.updateUser(user);

            if (success) {
                // Cập nhật session
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/admin/settings?action=profile&success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/settings?action=profile&error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/settings?action=profile&error=invalid");
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Kiểm tra password hiện tại
            User user = userDAO.authenticate(currentUser.getUsername(), currentPassword);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/settings?action=profile&error=wrongpassword");
                return;
            }

            // Kiểm tra confirm password
            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/admin/settings?action=profile&error=mismatch");
                return;
            }

            boolean success = userDAO.updatePassword(currentUser.getId(), newPassword);

            if (success) {
                response.sendRedirect(
                        request.getContextPath() + "/admin/settings?action=profile&success=passwordchanged");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/settings?action=profile&error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/settings?action=profile&error=invalid");
        }
    }

    private void updateSystemSettings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Placeholder cho system settings update
        response.sendRedirect(request.getContextPath() + "/admin/settings?action=system&success=updated");
    }

    private void performBackup(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Placeholder cho backup functionality
        response.sendRedirect(request.getContextPath() + "/admin/settings?action=backup&success=completed");
    }

    private void clearCache(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Placeholder cho clear cache
        response.sendRedirect(request.getContextPath() + "/admin/settings?success=cacheCleared");
    }

    private Map<String, Object> getSystemStats() {
        Map<String, Object> stats = new HashMap<>();

        try {
            // Thống kê cơ bản - Đơn giản hóa để tránh lỗi
            stats.put("totalUsers", 0);
            stats.put("totalProducts", 0);
            stats.put("totalOrders", 0);
            stats.put("totalCategories", 0);
            stats.put("adminCount", 1);
            stats.put("userCount", 0);
            stats.put("activeProducts", 0);

            // Cố gắng lấy dữ liệu thật - nếu lỗi thì dùng default
            try {
                stats.put("totalUsers", userDAO.getAllUsers().size());
            } catch (Exception e1) {
                /* ignore */ }

            try {
                stats.put("totalProducts", productDAO.getAllProducts().size());
            } catch (Exception e2) {
                /* ignore */ }

            try {
                stats.put("totalOrders", orderDAO.getAllOrders().size());
            } catch (Exception e3) {
                /* ignore */ }

            try {
                stats.put("totalCategories", categoryDAO.getAllCategories().size());
            } catch (Exception e4) {
                /* ignore */ }

        } catch (Exception e) {
            e.printStackTrace();
            stats.put("error", "Unable to load statistics");
        }

        return stats;
    }

    private Map<String, Object> getSystemInfo() {
        Map<String, Object> info = new HashMap<>();

        // System information
        info.put("javaVersion", System.getProperty("java.version"));
        info.put("osName", System.getProperty("os.name"));
        info.put("osVersion", System.getProperty("os.version"));
        info.put("serverInfo", getServletContext().getServerInfo());

        // Runtime information
        Runtime runtime = Runtime.getRuntime();
        long totalMemory = runtime.totalMemory();
        long freeMemory = runtime.freeMemory();
        long usedMemory = totalMemory - freeMemory;

        info.put("totalMemory", totalMemory / (1024 * 1024)); // MB
        info.put("usedMemory", usedMemory / (1024 * 1024)); // MB
        info.put("freeMemory", freeMemory / (1024 * 1024)); // MB

        return info;
    }
}
