<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Admin</title>
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
                    <h1 class="h2">Quản lý sản phẩm</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Thêm sản phẩm
                        </a>
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${sessionScope.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>
                
                <!-- Search and Filter -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <form action="${pageContext.request.contextPath}/admin/products" method="get" class="d-flex">
                            <input class="form-control me-2" type="search" name="search" 
                                   placeholder="Tìm kiếm sản phẩm..." value="${param.search}">
                            <button class="btn btn-outline-secondary" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" onchange="filterByCategory(this.value)">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" ${param.categoryId == category.id ? 'selected' : ''}>
                                    ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" onchange="filterByStock(this.value)">
                            <option value="">Tình trạng kho</option>
                            <option value="in-stock" ${param.stock == 'in-stock' ? 'selected' : ''}>Còn hàng</option>
                            <option value="out-of-stock" ${param.stock == 'out-of-stock' ? 'selected' : ''}>Hết hàng</option>
                            <option value="low-stock" ${param.stock == 'low-stock' ? 'selected' : ''}>Sắp hết hàng</option>
                        </select>
                    </div>
                </div>
                
                <!-- Products Table -->
                <div class="card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty products}">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Hình ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Danh mục</th>
                                                <th>Thương hiệu</th>
                                                <th>Giá</th>
                                                <th>Tồn kho</th>
                                                <th>Trạng thái</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${products}">
                                                <tr>
                                                    <td>${product.id}</td>
                                                    <td>
                                                        <img src="${pageContext.request.contextPath}/images/${product.image}" 
                                                             class="img-thumbnail" style="width: 50px; height: 50px; object-fit: cover;"
                                                             alt="${product.name}"
                                                             onerror="this.src='${pageContext.request.contextPath}/images/default-product.jpg'">
                                                    </td>
                                                    <td>
                                                        <strong>${product.name}</strong>
                                                        <br>
                                                        <small class="text-muted">${product.description}</small>
                                                    </td>
                                                    <td>${product.categoryName}</td>
                                                    <td>${product.brand}</td>
                                                    <td>
                                                        <strong class="text-primary">
                                                            <fmt:formatNumber value="${product.price}" pattern="#,###" />₫
                                                        </strong>
                                                    </td>
                                                    <td>
                                                        <span class="badge ${product.stockQuantity > 10 ? 'bg-success' : 
                                                                            product.stockQuantity > 0 ? 'bg-warning' : 'bg-danger'}">
                                                            ${product.stockQuantity}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${product.stockQuantity > 0}">
                                                                <span class="badge bg-success">Có sẵn</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">Hết hàng</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="${pageContext.request.contextPath}/admin/products?action=simple&id=${product.id}" 
                                                               class="btn btn-sm btn-outline-primary"
                                                               title="Sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <form style="display: inline;" method="post" action="${pageContext.request.contextPath}/admin/products" 
                                                                  onsubmit="return confirm('XÓA VĨNH VIỄN sản phẩm \'${fn:escapeXml(product.name)}\'? Hành động này KHÔNG THỂ hoàn tác!')">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="${product.id}">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Xóa vĩnh viễn">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </form>
                                                            <a href="${pageContext.request.contextPath}/products?action=detail&id=${product.id}" 
                                                               class="btn btn-sm btn-outline-info" 
                                                               title="Xem chi tiết" target="_blank">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Pagination would go here -->
                                
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                                    <h5>Không tìm thấy sản phẩm</h5>
                                    <p class="text-muted">Thử thay đổi bộ lọc hoặc thêm sản phẩm mới</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filter functions
        function filterByCategory(categoryId) {
            const url = new URL(window.location.href);
            if (categoryId) {
                url.searchParams.set('categoryId', categoryId);
            } else {
                url.searchParams.delete('categoryId');
            }
            window.location.href = url.toString();
        }
        
        function filterByStock(stock) {
            const url = new URL(window.location.href);
            if (stock) {
                url.searchParams.set('stock', stock);
            } else {
                url.searchParams.delete('stock');
            }
            window.location.href = url.toString();
        }
    </script>

</body>
</html>
