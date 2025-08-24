<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Quản Trị Phụ Tùng Xe Máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .stats-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        a.text-decoration-none:hover .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
    </style>
</head>
<body>
    <!-- Include admin header -->
    <jsp:include page="includes/admin-header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="includes/admin-sidebar.jsp"/>
            
            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-download me-1"></i>Xuất báo cáo
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <a href="${pageContext.request.contextPath}/admin/users" class="text-decoration-none">
                            <div class="stats-card">
                                <i class="fas fa-users"></i>
                                <h3>${totalUsers}</h3>
                                <p>Người dùng</p>
                            </div>
                        </a>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <a href="${pageContext.request.contextPath}/admin/products" class="text-decoration-none">
                            <div class="stats-card">
                                <i class="fas fa-box"></i>
                                <h3>${totalProducts}</h3>
                                <p>Sản phẩm</p>
                            </div>
                        </a>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <a href="${pageContext.request.contextPath}/admin/simple-orders" class="text-decoration-none">
                            <div class="stats-card">
                                <i class="fas fa-shopping-cart"></i>
                                <h3>${totalOrders}</h3>
                                <p>Đơn hàng</p>
                            </div>
                        </a>
                    </div>
                    
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="stats-card">
                            <i class="fas fa-dollar-sign"></i>
                            <h3><fmt:formatNumber value="${totalRevenue}" pattern="#,###" />đ</h3>
                            <p>Doanh thu</p>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Orders -->
                <div class="row">
                    <div class="col-lg-8 mb-4">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Đơn hàng gần đây</h5>
                                <div>
                                    <a href="${pageContext.request.contextPath}/admin/simple-orders" class="btn btn-sm btn-primary">
                                        <i class="fas fa-cogs"></i> Quản lý đơn hàng
                                    </a>
                                </div>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty recentOrders}">
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Mã ĐH</th>
                                                        <th>Khách hàng</th>
                                                        <th>Tổng tiền</th>
                                                        <th>Trạng thái</th>
                                                        <th>Ngày đặt</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${recentOrders}">
                                                        <tr>
                                                            <td>#${order.id}</td>
                                                            <td>${order.userName}</td>
                                                            <td><fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />đ</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${order.status == 'PENDING'}">
                                                                        <span class="badge bg-warning">Chờ xác nhận</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'CONFIRMED'}">
                                                                        <span class="badge bg-info">Đã xác nhận</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'SHIPPING'}">
                                                                        <span class="badge bg-primary">Đang giao</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'DELIVERED'}">
                                                                        <span class="badge bg-success">Đã giao</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-danger">Đã hủy</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm" /></td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-4">
                                            <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">Chưa có đơn hàng nào</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Latest Products -->
                    <div class="col-lg-4 mb-4">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0"><i class="fas fa-box me-2"></i>Sản phẩm mới</h5>
                                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-sm btn-primary">
                                    Xem tất cả
                                </a>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty latestProducts}">
                                        <c:forEach var="product" items="${latestProducts}" end="4">
                                            <div class="d-flex align-items-center mb-3">
                                                <img src="${pageContext.request.contextPath}/images/${product.image}" 
                                                     alt="${product.name}" class="rounded me-3" 
                                                     style="width: 50px; height: 50px; object-fit: cover;">
                                                <div class="flex-grow-1">
                                                    <h6 class="mb-1">${product.name}</h6>
                                                    <small class="text-muted">${product.brand}</small>
                                                    <div class="text-primary">
                                                        <fmt:formatNumber value="${product.price}" pattern="#,###" />đ
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-4">
                                            <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">Chưa có sản phẩm nào</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-rocket me-2"></i>Thao tác nhanh</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/products?action=add" 
                                           class="btn btn-outline-primary w-100">
                                            <i class="fas fa-plus me-2"></i>Thêm sản phẩm
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/categories?action=add" 
                                           class="btn btn-outline-success w-100">
                                            <i class="fas fa-tags me-2"></i>Thêm danh mục
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/simple-orders" 
                                           class="btn btn-outline-info w-100">
                                            <i class="fas fa-list me-2"></i>Quản lý đơn hàng
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/admin/users" 
                                           class="btn btn-outline-warning w-100">
                                            <i class="fas fa-users me-2"></i>Quản lý người dùng
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    
    <script>
        // Add some dashboard interactivity
        document.addEventListener('DOMContentLoaded', function() {
            // Animate numbers on load
            animateNumbers();
            
            // Auto-refresh data every 30 seconds
            setInterval(function() {
                // You can add auto-refresh functionality here
            }, 30000);
        });
        
        function animateNumbers() {
            const counters = document.querySelectorAll('.stats-card h3');
            counters.forEach(counter => {
                const target = parseInt(counter.textContent.replace(/[^0-9]/g, ''));
                if (target > 0) {
                    let current = 0;
                    const increment = target / 100;
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= target) {
                            counter.textContent = target.toLocaleString();
                            clearInterval(timer);
                        } else {
                            counter.textContent = Math.floor(current).toLocaleString();
                        }
                    }, 20);
                }
            });
        }
    </script>
</body>
</html>
