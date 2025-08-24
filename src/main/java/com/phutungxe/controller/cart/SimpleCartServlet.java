package com.phutungxe.controller.cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class SimpleCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== SimpleCartServlet doGet ===");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Context Path: " + request.getContextPath());

        // Không cần authentication, chỉ forward tới cart.jsp
        System.out.println("Forwarding to /cart.jsp");
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}
