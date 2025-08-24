<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.phutungxe.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Sản Phẩm - PhụTùngXe Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-2 d-none d-md-block bg-dark sidebar" style="height: 100vh;">
                <div class="sidebar-sticky pt-3">
                    <h5 class="text-white text-center mb-4">
                        <i class="fas fa-cogs"></i> Admin Panel
                    </h5>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white-50 active" href="${pageContext.request.contextPath}/admin/products">
                                <i class="fas fa-box"></i> Sản Phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="fas fa-tags"></i> Danh Mục
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/admin/orders_new">
                                <i class="fas fa-shopping-cart"></i> Đơn Hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users"></i> Người Dùng
                            </a>
                        </li>
                    </ul>
                    <hr class="bg-light">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/auth/logout">
                                <i class="fas fa-sign-out-alt"></i> Đăng Xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-10 ms-sm-auto px-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2"><i class="fas fa-edit"></i> Sửa Sản Phẩm</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay Lại
                        </a>
                    </div>
                </div>

                <!-- Edit Product Form -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Thông Tin Sản Phẩm</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <c:if test="${not empty success}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        ${success}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/admin/products" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="${product.id}">

                                    <div class="mb-3">
                                        <label for="name" class="form-label">Tên Sản Phẩm <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="description" class="form-label">Mô Tả</label>
                                        <textarea class="form-control" id="description" name="description" rows="4">${product.description}</textarea>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="price" class="form-label">Giá <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <input type="number" class="form-control" id="price" name="price" 
                                                           value="${product.price}" step="0.01" min="0" required>
                                                    <span class="input-group-text">VNĐ</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="quantity" class="form-label">Số Lượng <span class="text-danger">*</span></label>
                                                <input type="number" class="form-control" id="quantity" name="quantity" 
                                                       value="${product.quantity}" min="0" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="categoryId" class="form-label">Danh Mục <span class="text-danger">*</span></label>
                                        <select class="form-select" id="categoryId" name="categoryId" required>
                                            <option value="">Chọn danh mục...</option>
                                            <option value="1" ${product.categoryId == 1 ? 'selected' : ''}>Lốp xe</option>
                                            <option value="2" ${product.categoryId == 2 ? 'selected' : ''}>Phanh</option>
                                            <option value="3" ${product.categoryId == 3 ? 'selected' : ''}>Nhớt</option>
                                            <option value="4" ${product.categoryId == 4 ? 'selected' : ''}>Lọc gió</option>
                                            <option value="5" ${product.categoryId == 5 ? 'selected' : ''}>Bóng đèn</option>
                                            <option value="6" ${product.categoryId == 6 ? 'selected' : ''}>Ắc quy</option>
                                            <option value="12" ${product.categoryId == 12 ? 'selected' : ''}>Phuột</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="image" class="form-label">Hình Ảnh</label>
                                        <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                        <div class="form-text">Để trống nếu không muốn thay đổi hình ảnh.</div>
                                        <c:if test="${not empty product.imageUrl}">
                                            <div class="mt-2">
                                                <small class="text-muted">Hình ảnh hiện tại:</small><br>
                                                <img src="${pageContext.request.contextPath}/${product.imageUrl}" 
                                                     alt="${product.name}" class="img-thumbnail" style="max-width: 200px;">
                                            </div>
                                        </c:if>
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/admin/products" 
                                           class="btn btn-secondary me-md-2">Hủy</a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Cập Nhật Sản Phẩm
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="card-title mb-0">Thông Tin Thêm</h6>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <small class="text-muted">ID Sản Phẩm:</small><br>
                                    <strong>${product.id}</strong>
                                </div>
                                <div class="mb-3">
                                    <small class="text-muted">Ngày Tạo:</small><br>
                                    <strong>${product.createdAt}</strong>
                                </div>
                                <div class="mb-3">
                                    <small class="text-muted">Cập Nhật Lần Cuối:</small><br>
                                    <strong>${product.updatedAt}</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
