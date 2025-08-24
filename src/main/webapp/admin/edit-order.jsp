<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa đơn hàng #${order.id} - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h4 class="mb-0">
                            <i class="fas fa-edit me-2"></i>
                            Sửa đơn hàng #${order.id}
                        </h4>
                    </div>
                    <div class="card-body">
                        <!-- Order Info -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h6>Thông tin khách hàng:</h6>
                                <p class="mb-1"><strong>${order.username}</strong></p>
                                <p class="mb-1 text-muted">${order.userEmail}</p>
                                <p class="mb-1">${order.phone}</p>
                                <p class="mb-0">${order.shippingAddress}</p>
                            </div>
                            <div class="col-md-6">
                                <h6>Thông tin đơn hàng:</h6>
                                <p class="mb-1">Ngày đặt: <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                                <p class="mb-1">Tổng tiền: <strong class="text-success">
                                    <fmt:formatNumber value="${order.totalAmount}" type="number" maxFractionDigits="0"/>đ
                                </strong></p>
                                <p class="mb-1">Thanh toán: <span class="badge bg-info">${order.paymentMethod}</span></p>
                                <p class="mb-0">Ghi chú: ${order.notes}</p>
                            </div>
                        </div>

                        <hr>

                        <!-- Edit Form -->
                        <form method="post" action="${pageContext.request.contextPath}/admin/orders_new">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="orderId" value="${order.id}">
                            
                            <div class="mb-3">
                                <label for="status" class="form-label">
                                    <i class="fas fa-flag me-1"></i>
                                    Trạng thái đơn hàng
                                </label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="processing" ${order.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                                    <option value="completed" ${order.status == 'completed' ? 'selected' : ''}>Hoàn thành</option>
                                    <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Hủy</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="notes" class="form-label">
                                    <i class="fas fa-sticky-note me-1"></i>
                                    Ghi chú (tùy chọn)
                                </label>
                                <textarea class="form-control" id="notes" name="notes" rows="3" 
                                          placeholder="Thêm ghi chú về đơn hàng...">${order.notes}</textarea>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/admin/orders_new" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-1"></i>
                                    Quay lại
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i>
                                    Cập nhật đơn hàng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
