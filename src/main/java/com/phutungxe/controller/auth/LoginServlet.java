package com.phutungxe.controller.auth;

import com.phutungxe.dao.impl.UserDAO;
import com.phutungxe.model.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                if ("ADMIN".equals(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
                return;
            }
        }

        request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String errorMessage = null;

        if (username == null || username.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập tên đăng nhập";
        } else if (password == null || password.trim().isEmpty()) {
            errorMessage = "Vui lòng nhập mật khẩu";
        } else {
            User user = userDAO.authenticate(username.trim(), password);

            if (user != null) {
                if ("ACTIVE".equals(user.getStatus())) {
                    // Login successful
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setMaxInactiveInterval(30 * 60); // 30 minutes

                    // Redirect based on role
                    if ("ADMIN".equals(user.getRole())) {
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    } else {
                        String redirectUrl = (String) session.getAttribute("redirectUrl");
                        if (redirectUrl != null) {
                            session.removeAttribute("redirectUrl");
                            response.sendRedirect(redirectUrl);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/index.jsp");
                        }
                    }
                    return;
                } else {
                    errorMessage = "Tài khoản đã bị khóa";
                }
            } else {
                errorMessage = "Tên đăng nhập hoặc mật khẩu không đúng";
            }
        }

        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("username", username);
        request.getRequestDispatcher("/pages/auth/login.jsp").forward(request, response);
    }
}
