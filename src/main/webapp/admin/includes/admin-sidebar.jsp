<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="col-md-3 col-lg-2 d-md-block admin-sidebar collapse">
    <div class="position-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i>Dashboard
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.active == 'products' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/products">
                    <i class="fas fa-box"></i>Sản phẩm
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.active == 'categories' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/categories">
                    <i class="fas fa-tags"></i>Danh mục
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.active == 'orders' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/simple-orders">
                    <i class="fas fa-shopping-cart"></i>Đơn hàng
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.active == 'users' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i>Người dùng
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.active == 'reports' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/reports">
                    <i class="fas fa-chart-bar"></i>Báo cáo
                </a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link ${param.active == 'settings' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/settings">
                    <i class="fas fa-cog"></i>Cài đặt
                </a>
            </li>
        </ul>
        
        <hr class="my-3">
        
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Thống kê nhanh</span>
        </h6>
        
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <div class="nav-link text-muted">
                    <small>
                        <i class="fas fa-clock me-2"></i>
                        Cập nhật: <span id="last-update"></span>
                    </small>
                </div>
            </li>
        </ul>
    </div>
</nav>

<script>
    // Update last update time
    document.addEventListener('DOMContentLoaded', function() {
        const now = new Date();
        document.getElementById('last-update').textContent = 
            now.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' });
    });
</script>
