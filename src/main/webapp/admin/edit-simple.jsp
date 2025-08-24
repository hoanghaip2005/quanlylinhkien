<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.phutungxe.model.entity.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || (!"admin".equals(user.getRole()) && !"ADMIN".equals(user.getRole()))) {
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
                            <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/admin/products">
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

                <!-- Messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Edit Form -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Thông Tin Sản Phẩm</h5>
                            </div>
                            <div class="card-body">
                                <form id="editForm" action="${pageContext.request.contextPath}/admin/products" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="updateSimple">
                                    <input type="hidden" name="id" value="${product.id}">
                                    
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Tên Sản Phẩm <span class="text-danger">*</span></label>
                                        <input type="text" id="name" name="name" class="form-control" value="${product.name}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="description" class="form-label">Mô Tả</label>
                                        <textarea id="description" name="description" class="form-control" rows="4">${product.description}</textarea>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="price" class="form-label">Giá <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <input type="number" id="price" name="price" class="form-control" 
                                                           value="${product.price}" step="1000" min="0" required>
                                                    <span class="input-group-text">VNĐ</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="stockQuantity" class="form-label">Số Lượng <span class="text-danger">*</span></label>
                                                <input type="number" id="stockQuantity" name="stockQuantity" class="form-control" 
                                                       value="${product.stockQuantity}" min="0" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="categoryId" class="form-label">Danh Mục <span class="text-danger">*</span></label>
                                        <select id="categoryId" name="categoryId" class="form-select" required>
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
                                        <label for="productImage" class="form-label">Ảnh Sản Phẩm</label>
                                        <input type="file" id="image" name="image" class="form-control" accept="image/*" onchange="previewImage(this)">
                                        <div class="form-text">Chọn ảnh để thay đổi, bỏ trống để giữ ảnh hiện tại.</div>
                                        <!-- Current image preview -->
                                        <div class="mt-2">
                                            <img id="currentImage" src="${pageContext.request.contextPath}/resources/images/${product.image}" 
                                                 alt="Ảnh hiện tại" style="max-width: 150px; max-height: 150px; object-fit: cover;" 
                                                                                                    onerror="this.src='${pageContext.request.contextPath}/resources/images/default-product.jpg'">
                                            <p class="small text-muted mt-1">Ảnh hiện tại</p>
                                        </div>
                                        <!-- New image preview -->
                                        <div id="imagePreview" class="mt-2" style="display: none;">
                                            <img id="preview" src="#" alt="Xem trước" style="max-width: 150px; max-height: 150px; object-fit: cover;">
                                            <p class="small text-muted mt-1">Ảnh mới</p>
                                        </div>
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/admin/products" 
                                           class="btn btn-secondary me-md-2">
                                            <i class="fas fa-times"></i> Hủy
                                        </a>
                                        <button type="submit" class="btn btn-primary" id="submitBtn">
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
                                <h6 class="card-title mb-0"><i class="fas fa-info-circle"></i> Thông Tin Sản Phẩm</h6>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <small class="text-muted">ID Sản Phẩm:</small><br>
                                    <strong>#${product.id}</strong>
                                </div>
                                <div class="mb-3">
                                    <small class="text-muted">Giá hiện tại:</small><br>
                                    <strong class="text-primary">
                                        <fmt:formatNumber value="${product.price}" pattern="#,###" />₫
                                    </strong>
                                </div>
                                <div class="mb-3">
                                    <small class="text-muted">Tồn kho:</small><br>
                                    <span class="badge ${product.stockQuantity > 10 ? 'bg-success' : 
                                                        product.stockQuantity > 0 ? 'bg-warning' : 'bg-danger'}">
                                        ${product.stockQuantity} sản phẩm
                                    </span>
                                </div>
                                <c:if test="${not empty product.createdAt}">
                                    <div class="mb-3">
                                        <small class="text-muted">Ngày tạo:</small><br>
                                        <strong>${product.createdAt}</strong>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="card mt-3">
                            <div class="card-header">
                                <h6 class="card-title mb-0"><i class="fas fa-bolt"></i> Thao Tác Nhanh</h6>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <button type="button" class="btn btn-outline-success btn-sm" onclick="setQuickStock(10)">
                                        <i class="fas fa-plus"></i> Đặt 10 sản phẩm
                                    </button>
                                    <button type="button" class="btn btn-outline-warning btn-sm" onclick="setQuickStock(0)">
                                        <i class="fas fa-minus"></i> Hết hàng
                                    </button>
                                    <button type="button" class="btn btn-outline-info btn-sm" onclick="formatPrice()">
                                        <i class="fas fa-calculator"></i> Làm tròn giá
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Quick actions
        function setQuickStock(value) {
            document.getElementById('stockQuantity').value = value;
        }

        function formatPrice() {
            const priceInput = document.getElementById('price');
            const price = parseFloat(priceInput.value);
            if (!isNaN(price)) {
                // Round to nearest thousand
                const rounded = Math.round(price / 1000) * 1000;
                priceInput.value = rounded;
            }
        }

        // Form validation and submission
        document.getElementById('editForm').addEventListener('submit', function(e) {
            console.log('Form submission started');
            
            const submitBtn = document.getElementById('submitBtn');
            const name = document.getElementById('name').value.trim();
            const price = parseFloat(document.getElementById('price').value);
            const stock = parseInt(document.getElementById('stockQuantity').value);
            const category = document.getElementById('categoryId').value;

            console.log('Form values:', { name, price, stock, category });

            // Basic validation
            if (!name) {
                alert('Vui lòng nhập tên sản phẩm');
                e.preventDefault();
                return;
            }

            if (isNaN(price) || price <= 0) {
                alert('Vui lòng nhập giá hợp lệ');
                e.preventDefault();
                return;
            }

            if (isNaN(stock) || stock < 0) {
                alert('Vui lòng nhập số lượng hợp lệ');
                e.preventDefault();
                return;
            }

            if (!category) {
                alert('Vui lòng chọn danh mục');
                e.preventDefault();
                return;
            }

            console.log('Validation passed, submitting form...');

            // Show loading state
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang cập nhật...';
            submitBtn.disabled = true;
        });

        // Auto-save functionality (optional)
        let autoSaveTimer;
        const formInputs = document.querySelectorAll('#editForm input, #editForm textarea, #editForm select');
        
        formInputs.forEach(input => {
            input.addEventListener('input', function() {
                clearTimeout(autoSaveTimer);
                autoSaveTimer = setTimeout(() => {
                    console.log('Auto-save triggered for field:', this.name);
                    // Could implement auto-save to localStorage here
                }, 2000);
            });
        });

        // Image preview function
        function previewImage(input) {
            const preview = document.getElementById('preview');
            const imagePreview = document.getElementById('imagePreview');
            const currentImage = document.getElementById('currentImage');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    imagePreview.style.display = 'block';
                    currentImage.style.opacity = '0.5';
                };
                
                reader.readAsDataURL(input.files[0]);
            } else {
                imagePreview.style.display = 'none';
                currentImage.style.opacity = '1';
            }
        }
    </script>
</body>
</html>
