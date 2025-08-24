<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Phụ Tùng Xe Máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Include header -->
    <jsp:include page="../common/includes/header.jsp"/>
    
    <div class="container my-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                <li class="breadcrumb-item active">${pageTitle}</li>
            </ol>
        </nav>
        
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 mb-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-filter me-2"></i>Bộ lọc</h5>
                    </div>
                    <div class="card-body">
                        <!-- Search -->
                        <form action="${pageContext.request.contextPath}/products" method="get" class="mb-4">
                            <input type="hidden" name="action" value="search">
                            <div class="input-group">
                                <input type="text" class="form-control" name="keyword" 
                                       placeholder="Tìm kiếm..." value="${keyword}">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                        
                        <!-- Categories -->
                        <h6>Danh mục</h6>
                        <div class="list-group list-group-flush">
                            <a href="${pageContext.request.contextPath}/products" 
                               class="list-group-item list-group-item-action ${empty selectedCategory ? 'active' : ''}">
                                Tất cả sản phẩm
                            </a>
                            <c:forEach var="category" items="${categories}">
                                <a href="${pageContext.request.contextPath}/products?action=category&categoryId=${category.id}" 
                                   class="list-group-item list-group-item-action ${selectedCategory.id == category.id ? 'active' : ''}">
                                    ${category.name}
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-lg-9">
                <!-- Page Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>${pageTitle}</h2>
                    <div class="text-muted">
                        Tìm thấy ${products.size()} sản phẩm
                    </div>
                </div>
                
                <!-- Products Grid -->
                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="row">
                            <c:forEach var="product" items="${products}">
                                <div class="col-lg-4 col-md-6 mb-4">
                                    <div class="card product-card h-100">
                                        <img src="${pageContext.request.contextPath}/resources/images/${product.image}" 
                                             class="card-img-top" alt="${product.name}"
                                             onerror="this.src='${pageContext.request.contextPath}/resources/images/default-product.jpg'">
                                        <div class="card-body d-flex flex-column">
                                            <h6 class="card-title">${product.name}</h6>
                                            <p class="card-text text-muted small">${product.brand} - ${product.categoryName}</p>
                                            <p class="card-text">${product.description}</p>
                                            
                                            <div class="mt-auto">
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <span class="h5 text-primary mb-0">
                                                        <fmt:formatNumber value="${product.price}" pattern="#,###" />₫
                                                    </span>
                                                    <small class="text-muted">Còn ${product.stockQuantity}</small>
                                                </div>
                                                
                                                <div class="btn-group w-100">
                                                    <a href="${pageContext.request.contextPath}/products?action=detail&id=${product.id}" 
                                                       class="btn btn-outline-primary btn-sm">
                                                        <i class="fas fa-eye"></i> Xem
                                                    </a>
                                                    <c:if test="${product.stockQuantity > 0}">
                                                        <form method="post" action="${pageContext.request.contextPath}/cart" style="display: inline;">
                                                            <input type="hidden" name="action" value="add">
                                                            <input type="hidden" name="productId" value="${product.id}">
                                                            <input type="hidden" name="quantity" value="1">
                                                            <button type="submit" class="btn btn-primary btn-sm">
                                                                <i class="fas fa-cart-plus"></i> Thêm
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                    <c:if test="${product.stockQuantity == 0}">
                                                        <button class="btn btn-secondary btn-sm" disabled>
                                                            Hết hàng
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination would go here -->
                        
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-search fa-4x text-muted mb-3"></i>
                            <h4>Không tìm thấy sản phẩm</h4>
                            <p class="text-muted">Thử tìm kiếm với từ khóa khác hoặc xem tất cả sản phẩm</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                                Xem tất cả sản phẩm
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <!-- Include footer -->
    <jsp:include page="../common/includes/footer.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Set global variables for JavaScript
        window.contextPath = '${pageContext.request.contextPath}';
        window.userLoggedIn = '${sessionScope.user != null}' === 'true';
    </script>
    
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</body>
</html>
