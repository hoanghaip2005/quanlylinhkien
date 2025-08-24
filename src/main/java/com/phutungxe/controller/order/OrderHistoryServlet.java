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

public class OrderHistoryServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        System.out.println("OrderHistoryServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== OrderHistoryServlet doGet ===");
        System.out.println("URI: " + request.getRequestURI());

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
            System.out.println("Error in OrderHistoryServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy lịch sử đơn hàng");
        }
    }
}
