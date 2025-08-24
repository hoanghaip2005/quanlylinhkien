package com.phutungxe.controller.product;

import com.phutungxe.dao.impl.ProductDAO;
import com.phutungxe.model.entity.Product;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


public class ApiProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ApiProductServlet: doGet called");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            // Lấy danh sách sản phẩm nổi bật (8 sản phẩm đầu tiên)
            List<Product> featuredProducts = productDAO.getFeaturedProducts(8);

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            jsonResponse.add("products", gson.toJsonTree(featuredProducts));

            out.print(gson.toJson(jsonResponse));
            System.out.println("ApiProductServlet: Returned " + featuredProducts.size() + " featured products");

        } catch (Exception e) {
            System.err.println("ApiProductServlet error: " + e.getMessage());
            e.printStackTrace();

            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("error", "Không thể tải sản phẩm nổi bật");

            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(gson.toJson(errorResponse));
        } finally {
            out.flush();
        }
    }
}
