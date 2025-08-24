package com.phutungxe.controller.admin;

import com.phutungxe.dao.impl.CategoryDAO;
import com.phutungxe.dao.impl.ProductDAO;
import com.phutungxe.model.entity.Category;
import com.phutungxe.model.entity.Product;
import com.phutungxe.model.entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class AdminProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin authentication
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (!"ADMIN".equals(user.getRole()) && !"admin".equals(user.getRole()))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

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
            case "get":
                getProductAsJson(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "search":
                searchProducts(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("DEBUG: doPost called");

        // Check admin authentication
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (!"ADMIN".equals(user.getRole()) && !"admin".equals(user.getRole()))) {
            System.out.println("DEBUG: Authentication failed, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        System.out.println("DEBUG: Action parameter: " + action);

        if (action == null) {
            System.out.println("DEBUG: No action parameter, redirecting to products");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        System.out.println("DEBUG: Switch statement started");
        System.out.println("DEBUG: Action value: '" + action + "'");
        System.out.println("DEBUG: Action length: " + (action != null ? action.length() : "NULL"));
        System.out.println("DEBUG: Action equals 'updateSimple': " + "updateSimple".equals(action));
        
        switch (action) {
            case "add":
                System.out.println("DEBUG: Calling addProduct");
                addProduct(request, response);
                break;
            case "update":
                System.out.println("DEBUG: Calling updateProduct");
                updateProduct(request, response);
                break;
            case "updateSimple":
                System.out.println("DEBUG: Calling updateProductSimple - Action: " + action);
                System.out.println("DEBUG: About to call updateProductSimple method");
                updateProductSimple(request, response);
                System.out.println("DEBUG: updateProductSimple method call completed");
                break;
            case "delete":
                System.out.println("DEBUG: Calling deleteProduct");
                deleteProduct(request, response);
                break;
            default:
                System.out.println("DEBUG: Unknown action: '" + action + "', redirecting to products");
                System.out.println("DEBUG: Action hash code: " + (action != null ? action.hashCode() : "NULL"));
                System.out.println("DEBUG: 'updateSimple' hash code: " + "updateSimple".hashCode());
                response.sendRedirect(request.getContextPath() + "/admin/products");
                break;
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = productDAO.getAllProductsForAdmin();
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/product-management.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("DEBUG: showAddForm called");
        try {
            List<Category> categories = categoryDAO.getAllCategories();
            System.out.println("DEBUG: Categories loaded: " + (categories != null ? categories.size() : "NULL"));
            if (categories == null) {
                categories = new ArrayList<>();
                System.out.println("DEBUG: Categories was null, created empty list");
            }
            request.setAttribute("categories", categories);
            System.out.println("DEBUG: Forwarding to product-form.jsp");
            request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("ERROR: Exception in showAddForm: " + e.getMessage());
            e.printStackTrace();
            // Fallback: set empty categories list and continue
            request.setAttribute("categories", new ArrayList<>());
            request.setAttribute("error", "Không thể load danh mục: " + e.getMessage());
            try {
                request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
            } catch (Exception forwardException) {
                System.out.println("ERROR: Forward failed: " + forwardException.getMessage());
                response.sendRedirect(request.getContextPath() + "/admin/products");
            }
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdStr = request.getParameter("id");
        if (productIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            System.out.println("DEBUG: Tìm sản phẩm với ID: " + productId);

            Product product = productDAO.getProductById(productId);
            System.out.println("DEBUG: Kết quả tìm sản phẩm: " + (product != null ? product.getName() : "NULL"));

            if (product == null) {
                System.out.println("ERROR: Không tìm thấy sản phẩm với ID: " + productId);
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }

            List<Category> categories = categoryDAO.getAllCategories();
            System.out.println("DEBUG: Số categories: " + categories.size());

            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/edit-product.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("ERROR: ID không hợp lệ: " + productIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            System.out.println("ERROR: Exception trong showEditForm: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }

    private void showSimpleEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productIdStr = request.getParameter("id");
        if (productIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            System.out.println("DEBUG: Simple Edit - Tìm sản phẩm với ID: " + productId);

            Product product = productDAO.getProductById(productId);
            System.out.println("DEBUG: Simple Edit - Kết quả: " + (product != null ? product.getName() : "NULL"));

            if (product == null) {
                System.out.println("ERROR: Simple Edit - Không tìm thấy sản phẩm với ID: " + productId);
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }

            request.setAttribute("product", product);
            request.getRequestDispatcher("/admin/edit-simple.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("ERROR: Simple Edit - ID không hợp lệ: " + productIdStr);
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            System.out.println("ERROR: Simple Edit - Exception: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }
    //lay du lieu tra ve duoi dang json
    private void getProductAsJson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ THÊM AUTHENTICATION CHECK
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || (!"ADMIN".equals(user.getRole()) && !"admin".equals(user.getRole()))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Unauthorized - Please login as admin\"}");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String productIdStr = request.getParameter("id");
        if (productIdStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Không tìm thấy ID sản phẩm\"}");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            Product product = productDAO.getProductById(productId);

            if (product == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Không tìm thấy sản phẩm\"}");
                return;
            }

            // Convert product to JSON manually (simple approach)
            String json = String.format(
                    "{\"id\":%d,\"name\":\"%s\",\"description\":\"%s\",\"price\":%.2f," +
                            "\"stockQuantity\":%d,\"categoryId\":%d,\"brand\":\"%s\"," +
                            "\"model\":\"%s\",\"yearCompatible\":\"%s\",\"image\":\"%s\"}",
                    product.getId(),
                    escapeJson(product.getName()),
                    escapeJson(product.getDescription()),
                    product.getPrice(),
                    product.getStockQuantity(),
                    product.getCategoryId(),
                    escapeJson(product.getBrand()),
                    escapeJson(product.getModel()),
                    escapeJson(product.getYearCompatible()),
                    escapeJson(product.getImage()));

            response.getWriter().write(json);

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"ID sản phẩm không hợp lệ\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Lỗi server\"}");
        }
    }

    private String escapeJson(String str) {
        if (str == null)
            return "";
        return str.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }//chuyen chuoi thanh chuoi json bang cach ma hoa cac ky tu dac biet

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("DEBUG: addProduct method called");

        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stockQuantity");
            String categoryIdStr = request.getParameter("categoryId");
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            String yearCompatible = request.getParameter("yearCompatible");

            System.out.println("DEBUG: Add Product Parameters:");
            System.out.println("  - Name: " + name);
            System.out.println("  - Price: " + priceStr);
            System.out.println("  - Stock: " + stockStr);
            System.out.println("  - Category: " + categoryIdStr);

            // Handle image upload
            String imageName = "default-product.jpg"; // Default image
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Create unique filename
                    String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                    imageName = UUID.randomUUID().toString() + fileExtension;

                    // Save file to images directory
                    String uploadPath = getServletContext().getRealPath("/resources/images/");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    String filePath = uploadPath + File.separator + imageName;
                    Files.copy(filePart.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);

                    System.out.println("DEBUG: Image uploaded: " + imageName);
                }
            }

            // Simple validation
            if (name == null || name.trim().isEmpty()) {
                System.out.println("ERROR: Name is empty");
                request.setAttribute("error", "Vui lòng nhập tên sản phẩm");
                showAddForm(request, response);
                return;
            }

            if (priceStr == null || priceStr.trim().isEmpty()) {
                System.out.println("ERROR: Price is empty");
                request.setAttribute("error", "Vui lòng nhập giá sản phẩm");
                showAddForm(request, response);
                return;
            }

            if (stockStr == null || stockStr.trim().isEmpty()) {
                System.out.println("ERROR: Stock is empty");
                request.setAttribute("error", "Vui lòng nhập số lượng");
                showAddForm(request, response);
                return;
            }

            if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                System.out.println("ERROR: Category is empty");
                request.setAttribute("error", "Vui lòng chọn danh mục");
                showAddForm(request, response);
                return;
            }

            BigDecimal price = new BigDecimal(priceStr);
            int stockQuantity = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            System.out.println("DEBUG: Parsed values:");
            System.out.println("  - Price: " + price);
            System.out.println("  - Stock: " + stockQuantity);
            System.out.println("  - Category: " + categoryId);
            System.out.println("  - Image: " + imageName);

            Product product = new Product(name, description != null ? description : "",
                    price, stockQuantity, categoryId,
                    imageName, brand, model, yearCompatible);

            System.out.println("DEBUG: Calling productDAO.createProduct()");
            boolean success = productDAO.createProduct(product);
            System.out.println("DEBUG: Create result: " + success);

            if (success) {
                System.out.println("SUCCESS: Product added successfully");
                HttpSession session = request.getSession();
                session.setAttribute("success", "Thêm sản phẩm thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
            } else {
                System.out.println("ERROR: Failed to add product to database");
                request.setAttribute("error", "Lỗi khi thêm sản phẩm vào database");
                showAddForm(request, response);
            }

        } catch (NumberFormatException e) {
            System.out.println("ERROR: NumberFormatException: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu số không hợp lệ");
            showAddForm(request, response);
        } catch (Exception e) {
            System.out.println("ERROR: Exception in addProduct: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showAddForm(request, response);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("DEBUG: updateProduct method called");

        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stockQuantity");
            String categoryIdStr = request.getParameter("categoryId");
            String image = request.getParameter("image");
            String brand = request.getParameter("brand");
            String model = request.getParameter("model");
            String yearCompatible = request.getParameter("yearCompatible");
            String status = "ACTIVE"; // Default status

            System.out.println("DEBUG: Product ID: " + productId);
            System.out.println("DEBUG: Name: " + name);
            System.out.println("DEBUG: Price: " + priceStr);
            System.out.println("DEBUG: Stock: " + stockStr);
            System.out.println("DEBUG: Category: " + categoryIdStr);

            String errorMessage = validateProductInput(name, description, priceStr, stockStr, categoryIdStr);

            if (errorMessage != null) {
                System.out.println("ERROR: Validation failed: " + errorMessage);
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("id", productId);
                showEditForm(request, response);
                return;
            }

            BigDecimal price = new BigDecimal(priceStr);
            int stockQuantity = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            Product product = new Product(name, description, price, stockQuantity, categoryId,
                    image, brand, model, yearCompatible);
            product.setId(productId);
            product.setStatus(status);

            System.out.println("DEBUG: Calling productDAO.updateProduct()");
            boolean success = productDAO.updateProduct(product);
            System.out.println("DEBUG: Update result: " + success);

            if (success) {
                System.out.println("DEBUG: Update successful, redirecting");
                HttpSession session = request.getSession();
                session.setAttribute("success", "Cập nhật sản phẩm thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
            } else {
                System.out.println("ERROR: Update failed");
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật sản phẩm");
                request.setAttribute("id", productId);
                showEditForm(request, response);
            }

        } catch (NumberFormatException e) {
            System.out.println("ERROR: NumberFormatException: " + e.getMessage());
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ");
            showEditForm(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("DEBUG: deleteProduct method called");

        String productIdStr = request.getParameter("id");
        if (productIdStr == null) {
            System.out.println("ERROR: No product ID provided");
            HttpSession session = request.getSession();
            session.setAttribute("error", "Không tìm thấy ID sản phẩm");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            System.out.println("DEBUG: Deleting product with ID: " + productId);

            boolean success = productDAO.deleteProduct(productId);
            System.out.println("DEBUG: Delete result: " + success);

            HttpSession session = request.getSession();
            if (success) {
                System.out.println("SUCCESS: Product deleted successfully");
                session.setAttribute("success", "Xóa sản phẩm thành công!");
            } else {
                System.out.println("ERROR: Failed to delete product");
                session.setAttribute("error", "Có lỗi xảy ra khi xóa sản phẩm");
            }

        } catch (NumberFormatException e) {
            System.out.println("ERROR: Invalid product ID: " + productIdStr);
            HttpSession session = request.getSession();
            session.setAttribute("error", "ID sản phẩm không hợp lệ");
        } catch (Exception e) {
            System.out.println("ERROR: Exception in deleteProduct: " + e.getMessage());
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Lỗi hệ thống khi xóa sản phẩm");
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    private void updateProductSimple(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== DEBUG: updateProductSimple method called ===");
        System.out.println("DEBUG: Method exists and is being called!");
        System.out.println("DEBUG: Request content type: " + request.getContentType());
        System.out.println("DEBUG: Request method: " + request.getMethod());
        System.out.println("DEBUG: Method execution started successfully");

        try {
            // Get all parameters
            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stockQuantity");
            String categoryIdStr = request.getParameter("categoryId");

                    System.out.println("DEBUG: All Parameters received:");
        System.out.println("  - ID: " + idStr);
        System.out.println("  - Name: " + name);
        System.out.println("  - Description: " + description);
        System.out.println("  - Price: " + priceStr);
        System.out.println("  - Stock: " + stockStr);
        System.out.println("  - CategoryId: " + categoryIdStr);
        
        // Debug: Check if any parameters are null or empty
        System.out.println("DEBUG: Parameter validation:");
        System.out.println("  - ID null/empty: " + (idStr == null || idStr.trim().isEmpty()));
        System.out.println("  - Name null/empty: " + (name == null || name.trim().isEmpty()));
        System.out.println("  - Price null/empty: " + (priceStr == null || priceStr.trim().isEmpty()));
        System.out.println("  - Stock null/empty: " + (stockStr == null || stockStr.trim().isEmpty()));
        System.out.println("  - Category null/empty: " + (categoryIdStr == null || categoryIdStr.trim().isEmpty()));

            // Basic validation
            if (idStr == null || name == null || priceStr == null || stockStr == null || categoryIdStr == null) {
                System.out.println("ERROR: Missing required parameters");
                request.setAttribute("error", "Thiếu thông tin bắt buộc");
                showSimpleEditForm(request, response);
                return;
            }

            // Parse values
            int productId = Integer.parseInt(idStr);
            BigDecimal price = new BigDecimal(priceStr);
            int stockQuantity = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            System.out.println("DEBUG: Parsed values:");
            System.out.println("  - Product ID: " + productId);
            System.out.println("  - Price: " + price);
            System.out.println("  - Stock: " + stockQuantity);
            System.out.println("  - Category: " + categoryId);

            // Get current product first to preserve other fields
            Product existingProduct = productDAO.getProductById(productId);
            if (existingProduct == null) {
                System.out.println("ERROR: Product not found with ID: " + productId);
                request.setAttribute("error", "Không tìm thấy sản phẩm");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }

            System.out.println("DEBUG: Existing product found: " + existingProduct.getName());

            // Handle image upload (optional for update)
            String imageName = existingProduct.getImage(); // Keep existing image by default
            System.out.println("DEBUG: Current image: " + imageName);
            
            Part filePart = request.getPart("image");
            System.out.println("DEBUG: File part received: " + (filePart != null));
            if (filePart != null) {
                System.out.println("DEBUG: File size: " + filePart.getSize());
                System.out.println("DEBUG: File content type: " + filePart.getContentType());
            }
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                System.out.println("DEBUG: Extracted filename: " + fileName);
                
                if (fileName != null && !fileName.isEmpty()) {
                    // Create unique filename
                    String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                    imageName = UUID.randomUUID().toString() + fileExtension;

                    // Save file to images directory
                    String uploadPath = getServletContext().getRealPath("/resources/images/");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    String filePath = uploadPath + File.separator + imageName;
                    Files.copy(filePart.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);

                    System.out.println("DEBUG: Image updated: " + imageName);
                }
            } else {
                System.out.println("DEBUG: No new image uploaded, keeping existing: " + imageName);
            }

            // Update only the fields we care about
            System.out.println("DEBUG: Updating product fields:");
            System.out.println("  - Old name: " + existingProduct.getName() + " -> New name: " + name);
            System.out.println("  - Old description: " + existingProduct.getDescription() + " -> New description: " + description);
            System.out.println("  - Old price: " + existingProduct.getPrice() + " -> New price: " + price);
            System.out.println("  - Old stock: " + existingProduct.getStockQuantity() + " -> New stock: " + stockQuantity);
            System.out.println("  - Old category: " + existingProduct.getCategoryId() + " -> New category: " + categoryId);
            System.out.println("  - Old image: " + existingProduct.getImage() + " -> New image: " + imageName);
            
            existingProduct.setName(name);
            existingProduct.setDescription(description != null ? description : "");
            existingProduct.setPrice(price);
            existingProduct.setStockQuantity(stockQuantity);
            existingProduct.setCategoryId(categoryId);
            existingProduct.setImage(imageName);

                    System.out.println("DEBUG: About to call productDAO.updateProduct()");
        System.out.println("DEBUG: Product to update:");
        System.out.println("  - ID: " + existingProduct.getId());
        System.out.println("  - Name: " + existingProduct.getName());
        System.out.println("  - Description: " + existingProduct.getDescription());
        System.out.println("  - Price: " + existingProduct.getPrice());
        System.out.println("  - Stock: " + existingProduct.getStockQuantity());
        System.out.println("  - Category: " + existingProduct.getCategoryId());
        System.out.println("  - Image: " + existingProduct.getImage());
        
        boolean success = productDAO.updateProduct(existingProduct);
        System.out.println("DEBUG: Update result: " + success);

            if (success) {
                System.out.println("SUCCESS: Product updated successfully");
                HttpSession session = request.getSession();
                session.setAttribute("success", "Cập nhật sản phẩm thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
            } else {
                System.out.println("ERROR: Failed to update product in database");
                request.setAttribute("error", "Lỗi cập nhật database");
                showSimpleEditForm(request, response);
            }

        } catch (NumberFormatException e) {
            System.out.println("ERROR: NumberFormatException: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu số không hợp lệ");
            showSimpleEditForm(request, response);
        } catch (Exception e) {
            System.out.println("ERROR: Exception in updateProductSimple: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            showSimpleEditForm(request, response);
        }

        System.out.println("=== DEBUG: updateProductSimple method ended ===");
    }

    private String validateProductInput(String name, String description, String priceStr,
            String stockStr, String categoryIdStr) {

        if (name == null || name.trim().isEmpty()) {
            return "Vui lòng nhập tên sản phẩm";
        }

        if (description == null || description.trim().isEmpty()) {
            return "Vui lòng nhập mô tả sản phẩm";
        }

        if (priceStr == null || priceStr.trim().isEmpty()) {
            return "Vui lòng nhập giá sản phẩm";
        }

        try {
            BigDecimal price = new BigDecimal(priceStr);
            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                return "Giá sản phẩm phải lớn hơn 0";
            }
        } catch (NumberFormatException e) {
            return "Giá sản phẩm không hợp lệ";
        }

        if (stockStr == null || stockStr.trim().isEmpty()) {
            return "Vui lòng nhập số lượng";
        }

        try {
            int stock = Integer.parseInt(stockStr);
            if (stock < 0) {
                return "Số lượng không được âm";
            }
        } catch (NumberFormatException e) {
            return "Số lượng không hợp lệ";
        }

        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            return "Vui lòng chọn danh mục";
        }

        try {
            Integer.parseInt(categoryIdStr);
        } catch (NumberFormatException e) {
            return "Danh mục không hợp lệ";
        }

        return null;
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        List<Product> products;

        if (keyword != null && !keyword.trim().isEmpty()) {
            products = productDAO.searchProducts(keyword.trim());
        } else {
            products = productDAO.getAllProducts();
        }

        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("/admin/product-management.jsp").forward(request, response);
    }
    
    /**
     * Helper method to get filename from Part in a Servlet 3.0 compatible way
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
