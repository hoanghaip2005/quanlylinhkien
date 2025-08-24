package com.phutungxe.controller.admin;

import com.phutungxe.dao.impl.UserDAO;
import com.phutungxe.model.entity.User;
import com.phutungxe.utils.security.PasswordUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "simple":
                showSimpleEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            case "view":
                viewUser(request, response);
                break;
            default:
                listUsers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        switch (action) {
            case "add":
                addUser(request, response);
                break;
            case "update":
                updateUser(request, response);
                break;
            case "updateSimple":
                updateUserSimple(request, response);
                break;
            case "delete":
                deleteUserPost(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/users");
                break;
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        List<User> users;
        if (search != null && !search.trim().isEmpty()) {
            users = userDAO.searchUsers(search.trim());
        } else {
            users = userDAO.getAllUsers();
        }

        // Filter by role if specified
        if (role != null && !role.isEmpty()) {
            users.removeIf(user -> !role.equals(user.getRole()));
        }

        // Filter by status if specified
        if (status != null && !status.isEmpty()) {
            users.removeIf(user -> !status.equals(user.getStatus()));
        }

        request.setAttribute("users", users);
        request.setAttribute("search", search);
        request.setAttribute("selectedRole", role);
        request.setAttribute("selectedStatus", status);

        request.getRequestDispatcher("/admin/user-management.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("id");
        if (userIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            User user = userDAO.getUserById(userId);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            request.setAttribute("user", user);
            request.setAttribute("isEdit", true);
            request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("id");
        if (userIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            User user = userDAO.getUserById(userId);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/user-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String role = request.getParameter("role");
            String status = request.getParameter("status");

            String errorMessage = validateUserInput(username, email, password, fullName, role);

            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                showAddForm(request, response);
                return;
            }

            // Check if username or email already exists
            if (userDAO.getUserByUsername(username) != null) {
                request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại");
                showAddForm(request, response);
                return;
            }

            if (userDAO.getUserByEmail(email) != null) {
                request.setAttribute("errorMessage", "Email đã tồn tại");
                showAddForm(request, response);
                return;
            }

            User user = new User(username, email, password, fullName, phone, address, role);
            user.setStatus(status != null ? status : "ACTIVE");

            boolean success = userDAO.createUser(user);

            if (success) {
                request.setAttribute("successMessage", "Thêm người dùng thành công");
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm người dùng");
                showAddForm(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ");
            showAddForm(request, response);
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String role = request.getParameter("role");
            String status = request.getParameter("status");

            String errorMessage = validateUserInput(username, email, null, fullName, role);

            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("id", userId);
                showEditForm(request, response);
                return;
            }

            User existingUser = userDAO.getUserById(userId);
            if (existingUser == null) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            // Check if username or email is taken by another user
            User userByUsername = userDAO.getUserByUsername(username);
            if (userByUsername != null && userByUsername.getId() != userId) {
                request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại");
                request.setAttribute("id", userId);
                showEditForm(request, response);
                return;
            }

            User userByEmail = userDAO.getUserByEmail(email);
            if (userByEmail != null && userByEmail.getId() != userId) {
                request.setAttribute("errorMessage", "Email đã tồn tại");
                request.setAttribute("id", userId);
                showEditForm(request, response);
                return;
            }

            User user = new User(username, email, existingUser.getPassword(), fullName, phone, address, role);
            user.setId(userId);
            user.setStatus(status != null ? status : "ACTIVE");

            // Update password if provided
            if (password != null && !password.trim().isEmpty()) {
                user.setPassword(password);
            }

            boolean success = userDAO.updateUser(user);

            if (success) {
                request.setAttribute("successMessage", "Cập nhật người dùng thành công");
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật người dùng");
                request.setAttribute("id", userId);
                showEditForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("id");
        if (userIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);

            // Prevent deleting yourself
            User currentUser = (User) request.getSession().getAttribute("user");
            if (currentUser != null && currentUser.getId() == userId) {
                request.setAttribute("errorMessage", "Không thể xóa tài khoản của chính mình");
                response.sendRedirect(request.getContextPath() + "/admin/users?error=cannot_delete_self");
                return;
            }

            boolean success = userDAO.deleteUser(userId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/users?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=delete_failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
    //xoa tk tu he thong ngan chan qtv tu xoa tk cua minh
    private void deleteUserPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("id");
        if (userIdStr == null) {
            request.getSession().setAttribute("error", "Không tìm thấy ID người dùng");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);

            // Prevent deleting yourself
            User currentUser = (User) request.getSession().getAttribute("user");
            if (currentUser != null && currentUser.getId() == userId) {
                request.getSession().setAttribute("error", "Không thể xóa tài khoản của chính mình!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            boolean success = userDAO.deleteUser(userId);

            if (success) {
                request.getSession().setAttribute("success", "Xóa người dùng thành công!");
            } else {
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi xóa người dùng");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID người dùng không hợp lệ");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi hệ thống khi xóa người dùng");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private void showSimpleEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("id");
        if (userIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            User user = userDAO.getUserById(userId);

            if (user == null) {
                request.getSession().setAttribute("error", "Không tìm thấy người dùng");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/edit-user-simple.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private void updateUserSimple(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("id");
        if (userIdStr == null) {
            request.getSession().setAttribute("error", "Không tìm thấy ID người dùng");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);

            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");
            String status = request.getParameter("status");

            // Validation
            String errorMessage = validateUserInput(username, email, null, fullName, role);
            if (errorMessage != null) {
                request.getSession().setAttribute("error", errorMessage);
                response.sendRedirect(request.getContextPath() + "/admin/users?action=simple&id=" + userId);
                return;
            }

            User user = new User();
            user.setId(userId);
            user.setUsername(username);
            user.setEmail(email);
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setRole(role);
            user.setStatus(status);

            boolean success = userDAO.updateUser(user);

            if (success) {
                request.getSession().setAttribute("success", "Cập nhật người dùng thành công!");
            } else {
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi cập nhật người dùng");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID người dùng không hợp lệ");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi hệ thống khi cập nhật người dùng");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private String validateUserInput(String username, String email, String password, String fullName, String role) {
        if (username == null || username.trim().isEmpty()) {
            return "Tên đăng nhập không được để trống";
        }

        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống";
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            return "Email không hợp lệ";
        }

        if (password != null && !password.trim().isEmpty() && password.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
        }

        if (fullName == null || fullName.trim().isEmpty()) {
            return "Họ tên không được để trống";
        }

        if (role == null || role.trim().isEmpty()) {
            return "Vai trò không được để trống";
        }

        if (!"USER".equals(role) && !"ADMIN".equals(role)) {
            return "Vai trò không hợp lệ";
        }

        return null;
    }
}
