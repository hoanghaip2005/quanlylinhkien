package com.phutungxe.service.impl;

import com.phutungxe.dao.impl.ProductDAO;
import com.phutungxe.model.entity.Product;
import com.phutungxe.service.ProductService;
import java.util.List;

public class ProductServiceImpl implements ProductService {
    private ProductDAO productDAO;
    
    public ProductServiceImpl() {
        this.productDAO = new ProductDAO();
    }
    
    @Override
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }
    
    @Override
    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }
    
    @Override
    public List<Product> getProductsByCategory(int categoryId) {
        return productDAO.getProductsByCategory(categoryId);
    }
    
    @Override
    public List<Product> searchProducts(String keyword) {
        return productDAO.searchProducts(keyword);
    }
    
    @Override
    public boolean addProduct(Product product) {
        return productDAO.createProduct(product);
    }
    
    @Override
    public boolean updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }
    
    @Override
    public boolean deleteProduct(int id) {
        return productDAO.deleteProduct(id);
    }
}
