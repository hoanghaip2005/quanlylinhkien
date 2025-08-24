package com.phutungxe.controller.admin;

import com.phutungxe.dao.impl.CategoryDAO;
import com.phutungxe.model.entity.Category;
import java.io.File;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import javax.servlet.annotation.MultipartConfig;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)        
        
public class AdminCategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";//mac dinh action la list
        }

        switch (action) {
            case "delete":
                deleteCategory(request, response);
                break;
            default:
                listCategories(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        switch (action) {
            case "add":
                addCategory(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                break;
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = categoryDAO.getAllCategories();//lay ds
        request.setAttribute("categories", categories);//luu ds vao req

        request.getRequestDispatcher("/admin/category-management.jsp").forward(request, response);
    }



    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        String imageName = null;
        Part filePart = request.getPart("categoryImage"); // lay anh tu form
        
        if (filePart != null && filePart.getSize() > 0) {//ktr co upload dc ko
            String fileName = getFileName(filePart);
            if (fileName != null && !fileName.isEmpty()) {
                // Validate file type
                String contentType = filePart.getContentType();
                if (!isValidImageType(contentType)) {
                    request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF)");
                    listCategories(request, response);
                    return;
                }
                
                // Create unique filename
                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                imageName = UUID.randomUUID().toString() + fileExtension;//tao 1ten file tranh trung lap
                
                // Save file to images directory
                String uploadPath = getServletContext().getRealPath("/resources/images/");//luu file vao thu muc
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                String filePath = uploadPath + File.separator + imageName;
                try {
                    Files.copy(filePart.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("DEBUG: Image uploaded: " + imageName);
                } catch (IOException e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Có lỗi xảy ra khi upload ảnh");
                    listCategories(request, response);
                    return;
                }
            }
        }

        String errorMessage = validateCategoryInput(name);//ktra tinh hop le dl

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            listCategories(request, response);
            return;
        }

        Category category = new Category(name, description, imageName);

        boolean success = categoryDAO.createCategory(category);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/categories?success=added");
        } else {
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm danh mục");
            listCategories(request, response);
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== DEBUG: updateCategory method called ===");
        System.out.println("DEBUG: Request content type: " + request.getContentType());
        System.out.println("DEBUG: Request method: " + request.getMethod());

        try {
            // Get all parameters
            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            
            System.out.println("DEBUG: All Parameters received:");
            System.out.println("  - ID: " + idStr);
            System.out.println("  - Name: " + name);
            System.out.println("  - Description: " + description);
            
            // Debug: Check if any parameters are null or empty
            System.out.println("DEBUG: Parameter validation:");
            System.out.println("  - ID null/empty: " + (idStr == null || idStr.trim().isEmpty()));
            System.out.println("  - Name null/empty: " + (name == null || name.trim().isEmpty()));
            
            // Basic validation
            if (idStr == null || name == null) {
                System.out.println("ERROR: Missing required parameters");
                request.setAttribute("errorMessage", "Thiếu thông tin bắt buộc");
                listCategories(request, response);
                return;
            }
            
            int categoryId = Integer.parseInt(idStr);
            System.out.println("DEBUG: Parsed category ID: " + categoryId);
            
            //lay thong tin danh muc hien tai
            Category existingCategory = categoryDAO.getCategoryById(categoryId);
            if (existingCategory == null) {
                System.out.println("ERROR: Category not found with ID: " + categoryId);
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                return;
            }
            
            System.out.println("DEBUG: Existing category found: " + existingCategory.getName());

            String imageName = existingCategory.getImage();
            System.out.println("DEBUG: Current image: " + imageName);
            
            Part filePart = request.getPart("categoryImage");//lay file anh moi
            System.out.println("DEBUG: File part received: " + (filePart != null));
            if (filePart != null) {
                System.out.println("DEBUG: File size: " + filePart.getSize());
                System.out.println("DEBUG: File content type: " + filePart.getContentType());
            }
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                System.out.println("DEBUG: Extracted filename: " + fileName);
                
                if (fileName != null && !fileName.isEmpty()) {
                    String contentType = filePart.getContentType();
                    System.out.println("DEBUG: File content type: " + contentType);
                    
                    if (!isValidImageType(contentType)) {
                        System.out.println("ERROR: Invalid image type: " + contentType);
                        request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF)");
                        listCategories(request, response);
                        return;
                    }
                    
                    String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                    imageName = UUID.randomUUID().toString() + fileExtension;
                    System.out.println("DEBUG: New image name: " + imageName);
                    
                    String uploadPath = getServletContext().getRealPath("/resources/images/");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                        System.out.println("DEBUG: Created upload directory: " + uploadPath);
                    }
                    
                    String filePath = uploadPath + File.separator + imageName;
                    try {
                        Files.copy(filePart.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                        System.out.println("DEBUG: Image uploaded successfully: " + filePath);
                    } catch (IOException e) {
                        System.out.println("ERROR: Failed to upload image: " + e.getMessage());
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "Có lỗi xảy ra khi upload ảnh");
                        listCategories(request, response);
                        return;
                    }
                }
            } else {
                System.out.println("DEBUG: No new image uploaded, keeping existing: " + imageName);
            }
            
            System.out.println("DEBUG: Validating category input...");
            String errorMessage = validateCategoryInput(name);
            if (errorMessage != null) {
                System.out.println("ERROR: Validation failed: " + errorMessage);
                request.setAttribute("errorMessage", errorMessage);
                listCategories(request, response);
                return;
            }
            System.out.println("DEBUG: Validation passed");

            System.out.println("DEBUG: Updating category fields:");
            System.out.println("  - Old name: " + existingCategory.getName() + " -> New name: " + name);
            System.out.println("  - Old description: " + existingCategory.getDescription() + " -> New description: " + description);
            System.out.println("  - Old image: " + existingCategory.getImage() + " -> New image: " + imageName);

            Category category = new Category(name, description, imageName);
            category.setId(categoryId);

            System.out.println("DEBUG: About to call categoryDAO.updateCategory()");
            System.out.println("DEBUG: Category to update:");
            System.out.println("  - ID: " + category.getId());
            System.out.println("  - Name: " + category.getName());
            System.out.println("  - Description: " + category.getDescription());
            System.out.println("  - Image: " + category.getImage());
            
            boolean success = categoryDAO.updateCategory(category);
            System.out.println("DEBUG: Update result: " + success);
            
            if (success) {
                System.out.println("SUCCESS: Category updated successfully");
                response.sendRedirect(request.getContextPath() + "/admin/categories?success=updated");
            } else {
                System.out.println("ERROR: Failed to update category in database");
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật danh mục");
                listCategories(request, response);
            }
        } catch (NumberFormatException e) {
            System.out.println("ERROR: NumberFormatException: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (Exception e) {
            System.out.println("ERROR: Exception in updateCategory: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            listCategories(request, response);
        }
        
        System.out.println("=== DEBUG: updateCategory method ended ===");
    }
    

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryIdStr = request.getParameter("id");
        if (categoryIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);

            boolean success = categoryDAO.deleteCategory(categoryId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/categories?error=delete_failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }

    private String validateCategoryInput(String name) {
        if (name == null || name.trim().isEmpty()) {
            return "Tên danh mục không được để trống";
        }

        if (name.length() > 100) {
            return "Tên danh mục không được vượt quá 100 ký tự";
        }

        return null;
    }

    private boolean isValidImageType(String contentType) {
        return contentType != null && (
            contentType.equals("image/jpeg") ||
            contentType.equals("image/jpg") ||
            contentType.equals("image/png") ||
            contentType.equals("image/gif") ||
            contentType.equals("image/webp")
        );
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
