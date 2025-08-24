<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công - Phụ tùng xe máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-motorcycle"></i> Phụ tùng xe máy
            </a>
            <div class="navbar-nav ms-auto">
                <c:if test="${not empty sessionScope.user}">
                    <span class="navbar-text me-3">Xin chào, ${sessionScope.user.fullName}</span>
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="text-success mb-4">
                            <i class="fas fa-check-circle" style="font-size: 4rem;"></i>
                        </div>
                        
                        <h2 class="text-success mb-4">Đặt hàng thành công!</h2>
                        
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success">
                                ${successMessage}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty order}">
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <strong>Mã đơn hàng:</strong> #${order.id}
                                </div>
                                <div class="col-md-6">
                                    <strong>Tổng tiền:</strong> 
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" 
                                                      currencySymbol="₫" groupingUsed="true"/>
                                </div>
                            </div>
                            
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <strong>Phương thức thanh toán:</strong> ${order.paymentMethod}
                                </div>
                                <div class="col-md-6">
                                    <strong>Ngày đặt:</strong> 
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <strong>Địa chỉ giao hàng:</strong><br>
                                <div class="text-muted">${order.shippingAddress}</div>
                            </div>
                        </c:if>
                        
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i>
                            Chúng tôi sẽ liên hệ với bạn để xác nhận đơn hàng trong thời gian sớm nhất.
                        </div>
                        
                        <div class="d-grid gap-2 d-md-block">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                <i class="fas fa-home"></i> Về trang chủ
                            </a>
                            <a href="${pageContext.request.contextPath}/order?action=history" class="btn btn-outline-primary">
                                <i class="fas fa-history"></i> Xem đơn hàng
                            </a>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">
                                <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
