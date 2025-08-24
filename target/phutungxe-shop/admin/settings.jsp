<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cài đặt hệ thống - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Include admin header -->
    <jsp:include page="includes/admin-header.jsp"/>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Include sidebar -->
            <jsp:include page="includes/admin-sidebar.jsp"/>
            
            <!-- Main content -->
            <div class="col-md-10 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-cogs"></i> Cài đặt hệ thống
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <button class="btn btn-outline-primary" onclick="clearCache()">
                            <i class="fas fa-sync"></i> Xóa Cache
                        </button>
                    </div>
                </div>
                
                <!-- Success Messages -->
                <c:if test="${param.success eq 'cacheCleared'}">
                    <div class="alert alert-success alert-dismissible fade show">
                        Cache đã được xóa thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- System Statistics -->
                <div class="row mb-4">
                    <div class="col-lg-3 col-md-6 mb-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title">Người dùng</h6>
                                        <h3 class="mb-0">${stats.totalUsers}</h3>
                                        <small>Admin: ${stats.adminCount} | User: ${stats.userCount}</small>
                                    </div>
                                    <div class="text-end">
                                        <i class="fas fa-users fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-3 col-md-6 mb-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title">Sản phẩm</h6>
                                        <h3 class="mb-0">${stats.totalProducts}</h3>
                                        <small>Đang bán: ${stats.activeProducts}</small>
                                    </div>
                                    <div class="text-end">
                                        <i class="fas fa-boxes fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-3 col-md-6 mb-3">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title">Đơn hàng</h6>
                                        <h3 class="mb-0">${stats.totalOrders}</h3>
                                        <small>Tổng đơn hàng</small>
                                    </div>
                                    <div class="text-end">
                                        <i class="fas fa-shopping-cart fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-3 col-md-6 mb-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-title">Danh mục</h6>
                                        <h3 class="mb-0">${stats.totalCategories}</h3>
                                        <small>Danh mục sản phẩm</small>
                                    </div>
                                    <div class="text-end">
                                        <i class="fas fa-tags fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Settings Sections -->
                <div class="row">
                    <!-- Profile Settings -->
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-user-cog"></i> Thông tin cá nhân
                                </h5>
                            </div>
                            <div class="card-body">
                                <p class="card-text">Quản lý thông tin tài khoản admin và đổi mật khẩu.</p>
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/settings?action=profile" 
                                       class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Cập nhật thông tin
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- System Settings -->
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-server"></i> Cài đặt hệ thống
                                </h5>
                            </div>
                            <div class="card-body">
                                <p class="card-text">Xem thông tin hệ thống và cài đặt ứng dụng.</p>
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/settings?action=system" 
                                       class="btn btn-info">
                                        <i class="fas fa-cogs"></i> Xem cài đặt
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Backup Settings -->
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-download"></i> Sao lưu dữ liệu
                                </h5>
                            </div>
                            <div class="card-body">
                                <p class="card-text">Sao lưu và khôi phục dữ liệu hệ thống.</p>
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/settings?action=backup" 
                                       class="btn btn-warning">
                                        <i class="fas fa-download"></i> Quản lý sao lưu
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Quick Actions -->
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-bolt"></i> Thao tác nhanh
                                </h5>
                            </div>
                            <div class="card-body">
                                <p class="card-text">Các thao tác quản trị nhanh cho hệ thống.</p>
                                <div class="d-grid gap-2">
                                    <button class="btn btn-outline-primary" onclick="clearCache()">
                                        <i class="fas fa-sync"></i> Xóa Cache
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" 
                                       class="btn btn-outline-success">
                                        <i class="fas fa-chart-bar"></i> Xem Dashboard
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/users" 
                                       class="btn btn-outline-info">
                                        <i class="fas fa-users"></i> Quản lý Users
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- System Information Summary -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-info-circle"></i> Thông tin hệ thống
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <strong>Phiên bản:</strong><br>
                                        Phụ Tùng Xe Máy v1.0
                                    </div>
                                    <div class="col-md-3">
                                        <strong>Database:</strong><br>
                                        MySQL 8.0+
                                    </div>
                                    <div class="col-md-3">
                                        <strong>Server:</strong><br>
                                        Apache Tomcat 9.x
                                    </div>
                                    <div class="col-md-3">
                                        <strong>Last Update:</strong><br>
                                        <fmt:formatDate value="${pageContext.session.creationTime}" pattern="dd/MM/yyyy HH:mm" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function clearCache() {
            if (confirm('Bạn có chắc chắn muốn xóa cache hệ thống?\\nViệc này có thể làm chậm trang web trong thời gian ngắn.')) {
                // Tạo form POST để clear cache
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/settings';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'clearCache';
                
                form.appendChild(actionInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
