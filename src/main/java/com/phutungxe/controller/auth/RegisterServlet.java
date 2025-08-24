package com.phutungxe.controller.auth;

import com.phutungxe.dao.impl.UserDAO;
import com.phutungxe.model.entity.User;
import com.phutungxe.utils.common.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)//xu ly yeu cau , thong tin form dang ky
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        String errorMessage = validateInput(username, email, password, confirmPassword, fullName, phone);

        if (errorMessage == null) {
            // Check if username already exists
            if (userDAO.isUsernameExists(username.trim())) {
                errorMessage = "Tên đăng nhập đã tồn tại";
            } else if (userDAO.isEmailExists(email.trim())) {
                errorMessage = "Email đã được sử dụng";
            } else {
                // Create new user
                User user = new User(username.trim(), email.trim(), password, fullName.trim(),
                        phone.trim(), address.trim(), "USER");

                if (userDAO.createUser(user)) {
                    request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                    return;
                } else {
                    errorMessage = "Có lỗi xảy ra trong quá trình đăng ký";
                }
            }
        }

        // Set error message and form data
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("fullName", fullName);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);

        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    private String validateInput(String username, String email, String password,
            String confirmPassword, String fullName, String phone) {

        if (StringUtils.isEmpty(username)) {
            return "Vui lòng nhập tên đăng nhập";
        }

        if (username.length() < 3 || username.length() > 50) {
            return "Tên đăng nhập phải từ 3-50 ký tự";
        }

        if (!StringUtils.isValidEmail(email)) {
            return "Email không hợp lệ";
        }

        if (StringUtils.isEmpty(password)) {
            return "Vui lòng nhập mật khẩu";
        }

        if (password.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
        }

        if (!password.equals(confirmPassword)) {
            return "Mật khẩu xác nhận không khớp";
        }

        if (StringUtils.isEmpty(fullName)) {
            return "Vui lòng nhập họ tên";
        }

        if (StringUtils.isNotEmpty(phone) && !StringUtils.isValidPhone(phone)) {
            return "Số điện thoại không hợp lệ";
        }

        return null;
    }
}
