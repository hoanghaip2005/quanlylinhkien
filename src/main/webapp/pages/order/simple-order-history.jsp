<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng - Phụ Tùng Xe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background-color: #f8f9fa; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .header-banner {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .order-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
            transition: transform 0.2s ease;
        }
        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .order-header {
            background: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            border-radius: 12px 12px 0 0;
            padding: 1rem 1.5rem;
        }
        .order-body {
            padding: 1.5rem;
        }
        .order-status {
            padding: 6px 12px;
            border-radius: 20px;
            color: white;
            font-size: 0.85rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .status-pending { background: linear-gradient(135deg, #ffc107, #ffb300); }
        .status-processing { background: linear-gradient(135deg, #17a2b8, #138496); }
        .status-completed { background: linear-gradient(135deg, #28a745, #1e7e34); }
        .status-cancelled { background: linear-gradient(135deg, #dc3545, #c82333); }
        .price-tag {
            font-size: 1.25rem;
            font-weight: bold;
            color: #28a745;
        }
        .no-orders {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .breadcrumb-nav {
            background: white;
            padding: 1rem 0;
            border-radius: 8px;
            margin-bottom: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .info-badge {
            background: #e3f2fd;
            color: #1976d2;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="header-banner">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="mb-2">
                        <i class="fas fa-history me-3"></i>
                        Lịch sử đơn hàng
                    </h1>
                    <p class="mb-0 opacity-75">
                        <i class="fas fa-user me-2"></i>
                        Chào mừng ${user.username} | 
                        <i class="fas fa-envelope me-2"></i>
                        ${user.email}
                    </p>
                </div>
                <div class="col-md-4 text-md-end">
                    <div class="info-badge">
                        <i class="fas fa-id-badge me-2"></i>
                        User ID: ${user.id}
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb-nav">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                            <i class="fas fa-home me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <i class="fas fa-history me-1"></i>Lịch sử đơn hàng
                    </li>
                </ol>
            </nav>
        </div>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="no-orders">
                    <i class="fas fa-shopping-basket fa-4x text-muted mb-4"></i>
                    <h3 class="text-muted mb-3">Bạn chưa có đơn hàng nào</h3>
                    <p class="text-muted mb-4">Hãy mua sắm ngay để có đơn hàng đầu tiên!</p>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg">
                        <i class="fas fa-shopping-cart me-2"></i>Mua sắm ngay
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Summary -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="alert alert-info border-0 shadow-sm">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Tổng cộng: ${orders.size()} đơn hàng</strong>
                        </div>
                    </div>
                </div>

                <!-- Orders List -->
                <div class="row">
                    <c:forEach var="order" items="${orders}">
                        <div class="col-12">
                            <div class="order-card">
                                <div class="order-header">
                                    <div class="row align-items-center">
                                        <div class="col-md-6">
                                            <h5 class="mb-1">
                                                <i class="fas fa-receipt me-2"></i>
                                                Đơn hàng #${order.id}
                                            </h5>
                                            <small class="text-muted">
                                                <i class="fas fa-calendar-alt me-1"></i>
                                                <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy 'lúc' HH:mm"/>
                                            </small>
                                        </div>
                                        <div class="col-md-6 text-md-end">
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">
                                                    <span class="order-status status-pending">
                                                        <i class="fas fa-clock me-1"></i>Chờ xử lý
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 'processing'}">
                                                    <span class="order-status status-processing">
                                                        <i class="fas fa-cogs me-1"></i>Đang xử lý
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 'completed'}">
                                                    <span class="order-status status-completed">
                                                        <i class="fas fa-check-circle me-1"></i>Hoàn thành
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 'cancelled'}">
                                                    <span class="order-status status-cancelled">
                                                        <i class="fas fa-times-circle me-1"></i>Hủy
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="order-status status-pending">
                                                        <i class="fas fa-question-circle me-1"></i>${order.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="order-body">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="row mb-3">
                                                <div class="col-sm-6">
                                                    <div class="d-flex align-items-center mb-2">
                                                        <i class="fas fa-map-marker-alt text-primary me-2"></i>
                                                        <div>
                                                            <small class="text-muted d-block">Địa chỉ giao hàng</small>
                                                            <span>${order.shippingAddress}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="d-flex align-items-center mb-2">
                                                        <i class="fas fa-phone text-success me-2"></i>
                                                        <div>
                                                            <small class="text-muted d-block">Số điện thoại</small>
                                                            <span>${order.phone}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-credit-card text-info me-2"></i>
                                                        <div>
                                                            <small class="text-muted d-block">Thanh toán</small>
                                                            <span class="text-capitalize">${order.paymentMethod}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <c:if test="${not empty order.notes}">
                                                        <div class="d-flex align-items-center">
                                                            <i class="fas fa-sticky-note text-warning me-2"></i>
                                                            <div>
                                                                <small class="text-muted d-block">Ghi chú</small>
                                                                <span>${order.notes}</span>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-4 text-md-end">
                                            <div class="border-start ps-3">
                                                <small class="text-muted d-block">Tổng tiền</small>
                                                <div class="price-tag">
                                                    <fmt:formatNumber value="${order.totalAmount}" type="number" maxFractionDigits="0"/>đ
                                                </div>
                                                <button class="btn btn-outline-primary btn-sm mt-2">
                                                    <i class="fas fa-eye me-1"></i>Xem chi tiết
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Footer Info -->
        <div class="text-center mt-5 py-4 border-top">
            <div class="row">
                <div class="col-md-6">
                    <small class="text-muted">
                        <i class="fas fa-code me-1"></i>
                        Context Path: ${pageContext.request.contextPath}
                    </small>
                </div>
                <div class="col-md-6">
                    <small class="text-muted">
                        <i class="fas fa-clock me-1"></i>
                        Cập nhật: <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm:ss"/>
                    </small>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
