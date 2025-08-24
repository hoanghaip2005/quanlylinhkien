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
            //case "add":
                //showAddForm(request, response);
                //break;
            //case "edit":
                //showEditForm(request, response);
                //break;
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

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryIdStr = request.getParameter("id");
        if (categoryIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            Category category = categoryDAO.getCategoryById(categoryId);

            if (category == null) {
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                return;
            }

            request.setAttribute("category", category);
            request.setAttribute("isEdit", true);
            request.getRequestDispatcher("/admin/category-form.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        String imageName = null;
        Part filePart = request.getPart("categoryImage"); // lay anh tu form
        
        if (filePart != null && filePart.getSize() > 0) {//ktr co upload dc ko
            String fileName = filePart.getSubmittedFileName();
            if (fileName != null && !fileName.isEmpty()) {
                // Validate file type
                String contentType = filePart.getContentType();
                if (!isValidImageType(contentType)) {
                    request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF)");
                    showAddForm(request, response);
                    return;
                }
                
                // Create unique filename
                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                imageName = UUID.randomUUID().toString() + fileExtension;//tao 1ten file tranh trung lap
                
                // Save file to images directory
                String uploadPath = getServletContext().getRealPath("/images/");//luu file vao thu muc
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
                    showAddForm(request, response);
                    return;
                }
            }
        }

        String errorMessage = validateCategoryInput(name);//ktra tinh hop le dl

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            showAddForm(request, response);
            return;
        }

        Category category = new Category(name, description, imageName);

        boolean success = categoryDAO.createCategory(category);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/categories?success=added");
        } else {
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm danh mục");
            showAddForm(request, response);
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int categoryId = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            //lay thong tin danh muc hien tai
            Category existingCategory = categoryDAO.getCategoryById(categoryId);
            if (existingCategory == null) {
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                return;
            }

            String imageName = existingCategory.getImage();
            
            Part filePart = request.getPart("categoryImage");//lay file anh moi
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                if (fileName != null && !fileName.isEmpty()) {
                    String contentType = filePart.getContentType();
                    if (!isValidImageType(contentType)) {
                        request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF)");
                        listCategories(request, response);
                        return;
                    }
                    
                    String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                    imageName = UUID.randomUUID().toString() + fileExtension;
                    
                    String uploadPath = getServletContext().getRealPath("/images/");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    String filePath = uploadPath + File.separator + imageName;
                    try {
                        Files.copy(filePart.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                    } catch (IOException e) {
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "Có lỗi xảy ra khi upload ảnh");
                        listCategories(request, response);
                        return;
                    }
                }
            }
            
            String errorMessage = validateCategoryInput(name);
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                listCategories(request, response);
                return;
            }

            Category category = new Category(name, description, imageName);
            category.setId(categoryId);

            boolean success = categoryDAO.updateCategory(category);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?success=updated");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật danh mục");
                listCategories(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
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
}
