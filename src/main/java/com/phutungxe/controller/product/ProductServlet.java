package com.phutungxe.controller.product;

import com.phutungxe.dao.impl.CategoryDAO;
import com.phutungxe.dao.impl.ProductDAO;
import com.phutungxe.dao.impl.CartDAO;
import com.phutungxe.model.entity.Category;
import com.phutungxe.model.entity.Product;
import com.phutungxe.model.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "detail":
                showProductDetail(request, response);
                break;
            case "search":
                searchProducts(request, response);
                break;
            case "category":
                showProductsByCategory(request, response);
                break;
            case "addToCart":
                addToCart(request, response);
                break;
            default:
                showAllProducts(request, response);
                break;
        }
    }

    private void showAllProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("pageTitle", "Tất cả sản phẩm");

        request.getRequestDispatcher("/pages/product/product-list.jsp").forward(request, response);
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdStr = request.getParameter("id");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            Product product = productDAO.getProductById(productId);

            if (product == null || !"ACTIVE".equals(product.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            // Get related products from same category
            List<Product> relatedProducts = productDAO.getProductsByCategory(product.getCategoryId());
            relatedProducts.removeIf(p -> p.getId() == productId); // Remove current product

            request.setAttribute("product", product);
            request.setAttribute("relatedProducts", relatedProducts);

            request.getRequestDispatcher("/pages/product/product-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        List<Product> products = productDAO.searchProducts(keyword.trim());
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("keyword", keyword);
        request.setAttribute("pageTitle", "Kết quả tìm kiếm: " + keyword);

        request.getRequestDispatcher("/pages/product/product-list.jsp").forward(request, response);
    }

    private void showProductsByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryIdStr = request.getParameter("categoryId");
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            Category category = categoryDAO.getCategoryById(categoryId);

            if (category == null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            List<Product> products = productDAO.getProductsByCategory(categoryId);
            List<Category> categories = categoryDAO.getAllCategories();

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("selectedCategory", category);
            request.setAttribute("pageTitle", "Danh mục: " + category.getName());

            request.getRequestDispatcher("/pages/product/product-list.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== ProductServlet addToCart ===");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        System.out.println("User from session: " + (user != null ? user.getUsername() : "null"));

        if (user == null) {
            System.out.println("User not logged in, redirecting to login");
            session.setAttribute("error", "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            System.out.println("productId param: " + productIdStr);
            System.out.println("quantity param: " + quantityStr);

            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            System.out.println("Parsed - productId: " + productId + ", quantity: " + quantity);

            if (quantity <= 0) {
                session.setAttribute("error", "Số lượng không hợp lệ");
                response.sendRedirect(request.getHeader("Referer"));
                return;
            }

            Product product = productDAO.getProductById(productId);
            if (product == null || !"ACTIVE".equals(product.getStatus())) {
                session.setAttribute("error", "Sản phẩm không tồn tại");
                response.sendRedirect(request.getHeader("Referer"));
                return;
            }

            if (product.getStockQuantity() < quantity) {
                session.setAttribute("error", "Số lượng trong kho không đủ");
                response.sendRedirect(request.getHeader("Referer"));
                return;
            }

            boolean success = cartDAO.addToCart(user.getId(), productId, quantity);

            if (success) {
                session.setAttribute("success", "Đã thêm sản phẩm vào giỏ hàng thành công!");
                System.out.println("Add to cart successful");
            } else {
                session.setAttribute("error", "Có lỗi xảy ra khi thêm vào giỏ hàng");
                System.out.println("Add to cart failed");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Dữ liệu không hợp lệ");
            System.out.println("NumberFormatException: " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            System.out.println("Exception: " + e.getMessage());
        }

        // Redirect back to previous page
        String referer = request.getHeader("Referer");
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
