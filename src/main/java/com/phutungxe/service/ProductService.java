package com.phutungxe.service;

import com.phutungxe.model.entity.Product;
import java.util.List;

public interface ProductService {
    List<Product> getAllProducts();
    Product getProductById(int id);
    List<Product> getProductsByCategory(int categoryId);
    List<Product> searchProducts(String keyword);
    boolean addProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteProduct(int id);
}
