package com.phutungxe.model.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private BigDecimal totalAmount;
    private String shippingAddress;
    private String phone;
    private String status; // PENDING, CONFIRMED, SHIPPING, DELIVERED, CANCELLED
    private String paymentMethod; // COD, BANK_TRANSFER
    private String paymentStatus; // PENDING, PAID, FAILED
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // For joining with user
    private String userName;
    private String userEmail;

    // Order items
    private List<OrderItem> orderItems;

    // Constructors
    public Order() {
    }

    public Order(int userId, BigDecimal totalAmount, String shippingAddress,
            String phone, String paymentMethod, String notes) {
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.phone = phone;
        this.paymentMethod = paymentMethod;
        this.notes = notes;
        this.status = "PENDING";
        this.paymentStatus = "PENDING";
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public String getFormattedTotalAmount() {
        return String.format("%,.0f VNĐ", totalAmount.doubleValue());
    }

    public String getStatusText() {
        switch (status) {
            case "PENDING":
                return "Chờ xác nhận";
            case "CONFIRMED":
                return "Đã xác nhận";
            case "SHIPPING":
                return "Đang giao hàng";
            case "DELIVERED":
                return "Đã giao hàng";
            case "CANCELLED":
                return "Đã hủy";
            default:
                return status;
        }
    }

    public String getPaymentMethodText() {
        switch (paymentMethod) {
            case "COD":
                return "Thanh toán khi nhận hàng";
            case "BANK_TRANSFER":
                return "Chuyển khoản ngân hàng";
            default:
                return paymentMethod;
        }
    }
}
