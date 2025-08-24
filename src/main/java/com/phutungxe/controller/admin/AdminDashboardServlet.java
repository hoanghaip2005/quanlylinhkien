package com.phutungxe.controller.admin;

import com.phutungxe.dao.impl.CategoryDAO;
import com.phutungxe.dao.impl.OrderDAO;
import com.phutungxe.dao.impl.ProductDAO;
import com.phutungxe.dao.impl.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {
    private UserDAO userDAO;
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get statistics for dashboard
        int totalUsers = userDAO.getAllUsers().size();
        int totalProducts = productDAO.getAllProductsForAdmin().size();
        int totalCategories = categoryDAO.getAllCategories().size();
        int totalOrders = orderDAO.getTotalOrderCount();
        double totalRevenue = orderDAO.getTotalRevenue();

        // Get recent orders
        var recentOrders = orderDAO.getAllOrders();
        if (recentOrders.size() > 10) {
            recentOrders = recentOrders.subList(0, 10);
        }

        // Get latest products
        var latestProducts = productDAO.getLatestProducts(10);

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("recentOrders", recentOrders);
        request.setAttribute("latestProducts", latestProducts);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
