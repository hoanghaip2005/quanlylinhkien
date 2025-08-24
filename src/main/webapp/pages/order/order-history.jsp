<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đơn hàng - Phụ Tùng Xe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Include header -->
    <jsp:include page="../common/includes/header.jsp" />
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h2><i class="fas fa-history"></i> Lịch sử đơn hàng</h2>
                
                <!-- Success message -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>
                
                <!-- Error message -->
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>
                
                <c:choose>
                    <c:when test="${empty orders}">
                        <div class="text-center py-5">
                            <i class="fas fa-shopping-basket fa-3x text-muted mb-3"></i>
                            <h4 class="text-muted">Bạn chưa có đơn hàng nào</h4>
                            <p class="text-muted">Hãy mua sắm ngay để có đơn hàng đầu tiên!</p>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                <i class="fas fa-shopping-cart"></i> Mua sắm ngay
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Mã đơn hàng</th>
                                        <th>Ngày đặt</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order">
                                        <tr>
                                            <td>#${order.id}</td>
                                            <td>
                                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${order.totalAmount}" type="currency" 
                                                    currencySymbol="₫" groupingUsed="true"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'pending'}">
                                                        <span class="badge bg-warning">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'confirmed'}">
                                                        <span class="badge bg-info">Đã xác nhận</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'shipping'}">
                                                        <span class="badge bg-primary">Đang giao</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'delivered'}">
                                                        <span class="badge bg-success">Đã giao</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'cancelled'}">
                                                        <span class="badge bg-danger">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/order?action=detail&id=${order.id}" 
                                                   class="btn btn-sm btn-outline-primary">
                                                    <i class="fas fa-eye"></i> Xem chi tiết
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Include footer -->
    <jsp:include page="../common/includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
