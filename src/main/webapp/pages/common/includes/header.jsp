<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-motorcycle me-2"></i>Phụ Tùng Xe Máy
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Trang Chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products">Sản Phẩm</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" 
                       data-bs-toggle="dropdown">
                        Danh Mục
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products?action=category&categoryId=1">Lốp xe</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products?action=category&categoryId=2">Phanh</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products?action=category&categoryId=3">Nhớt</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products?action=category&categoryId=4">Lọc gió</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products?action=category&categoryId=5">Bóng đèn</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/products?action=category&categoryId=6">Ắc quy</a></li>
                    </ul>
                </li>
            </ul>
            
            <!-- Search Form -->
            <form class="d-flex me-3" action="${pageContext.request.contextPath}/products" method="get">
                <input type="hidden" name="action" value="search">
                <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm kiếm sản phẩm..." 
                       value="${param.keyword}" style="width: 250px;">
                <button class="btn btn-outline-light" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </form>
            
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <!-- Cart -->
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="${pageContext.request.contextPath}/cart">
                                <i class="fas fa-shopping-cart"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" 
                                      id="cart-count">${cartItems.size()}</span>
                            </a>
                        </li>
                        
                        <!-- User Menu -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user me-1"></i>${sessionScope.user.fullName}
                            </a>
                            <ul class="dropdown-menu">
                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                                        <i class="fas fa-tachometer-alt me-2"></i>Quản Trị
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                    <i class="fas fa-user-edit me-2"></i>Thông Tin Cá Nhân
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/order?action=history">
                                    <i class="fas fa-history me-2"></i>Lịch Sử Đơn Hàng
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Đăng Xuất
                                </a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt me-1"></i>Đăng Nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                <i class="fas fa-user-plus me-1"></i>Đăng Ký
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<script>
    // Update cart count when page loads
    document.addEventListener('DOMContentLoaded', function() {
        updateCartCount();
    });
    
    function updateCartCount() {
        <c:if test="${sessionScope.user != null}">
        fetch('${pageContext.request.contextPath}/cart?action=count')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('cart-count').textContent = data.data.cartCount;
                }
            })
            .catch(error => console.error('Error:', error));
        </c:if>
    }
</script>
