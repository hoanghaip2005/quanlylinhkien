<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${product != null}">Chỉnh sửa sản phẩm</c:when><c:otherwise>Thêm sản phẩm mới</c:otherwise></c:choose> - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #343a40;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center text-white mb-4">
                        <h5>Admin Panel</h5>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users"></i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/admin/products">
                                <i class="fas fa-box"></i> Products
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/orders_new">
                                <i class="fas fa-shopping-cart"></i> Orders
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="fas fa-tags"></i> Categories
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/reports">
                                <i class="fas fa-chart-bar"></i> Reports
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/settings">
                                <i class="fas fa-cog"></i> Settings
                            </a>
                        </li>
                    </ul>
                    <hr class="text-white">
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <c:choose>
                            <c:when test="${product != null}">Chỉnh sửa sản phẩm</c:when>
                            <c:otherwise>Thêm sản phẩm mới</c:otherwise>
                        </c:choose>
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </div>

                <!-- Product Form -->
                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-body">
                                <form method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="${product != null ? 'update' : 'add'}">
                                    <c:if test="${product != null}">
                                        <input type="hidden" name="id" value="${product.id}">
                                    </c:if>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="name" class="form-label">Tên sản phẩm *</label>
                                                <input type="text" class="form-control" id="name" name="name" 
                                                       value="${product.name}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="brand" class="form-label">Thương hiệu *</label>
                                                <input type="text" class="form-control" id="brand" name="brand" 
                                                       value="${product.brand}" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="model" class="form-label">Model</label>
                                                <input type="text" class="form-control" id="model" name="model" 
                                                       value="${product.model}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="yearCompatible" class="form-label">Năm tương thích</label>
                                                <input type="text" class="form-control" id="yearCompatible" name="yearCompatible" 
                                                       value="${product.yearCompatible}" placeholder="VD: 2018-2024">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="categoryId" class="form-label">Danh mục *</label>
                                                <select class="form-select" id="categoryId" name="categoryId" required>
                                                    <option value="">Chọn danh mục</option>
                                                    <c:forEach var="category" items="${categories}">
                                                        <option value="${category.getId()}" 
                                                                ${product.getCategoryId() == category.getId() ? 'selected' : ''}>
                                                            ${category.categoryName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="price" class="form-label">Giá (₫) *</label>
                                                <input type="number" class="form-control" id="price" name="price" 
                                                       value="${product.price}" min="0" step="1000" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="stockQuantity" class="form-label">Số lượng tồn kho *</label>
                                                <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" 
                                                       value="${product.stockQuantity}" min="0" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="image" class="form-label">Hình ảnh ${product != null ? '(Chọn file mới để thay đổi)' : '*'}</label>
                                                <input type="file" class="form-control" id="image" name="image" 
                                                       accept="image/*" ${product == null ? 'required' : ''}>
                                                <c:if test="${product != null && not empty product.image}">
                                                    <small class="text-muted">Hình hiện tại: ${product.image}</small>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="description" class="form-label">Mô tả sản phẩm</label>
                                        <textarea class="form-control" id="description" name="description" 
                                                  rows="4" placeholder="Mô tả chi tiết về sản phẩm...">${product.description}</textarea>
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">
                                            <i class="fas fa-times"></i> Hủy
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> 
                                            <c:choose>
                                                <c:when test="${product != null}">Cập nhật</c:when>
                                                <c:otherwise>Thêm mới</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Preview Card -->
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h6>Preview Sản phẩm</h6>
                            </div>
                            <div class="card-body">
                                <c:if test="${product != null && not empty product.image}">
                                    <img src="${pageContext.request.contextPath}/images/products/${product.image}" 
                                         class="img-fluid mb-3" alt="${product.name}" style="max-height: 200px;">
                                </c:if>
                                <h6>${product.name}</h6>
                                <p class="text-muted">${product.brand} ${product.model}</p>
                                <h5 class="text-primary">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/>
                                </h5>
                                <p><small>Tồn kho: ${product.stockQuantity}</small></p>
                                <p class="small">${product.description}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Error/Success Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger mt-3">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success mt-3">
                        <i class="fas fa-check-circle"></i> ${success}
                    </div>
                </c:if>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
