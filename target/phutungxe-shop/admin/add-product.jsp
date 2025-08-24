<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.phutungxe.model.User" %>
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
    <title>Thêm Sản Phẩm - PhụTùngXe Admin</title>
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
                    <h1 class="h2"><i class="fas fa-plus-circle"></i> Thêm Sản Phẩm Mới</h1>
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

                <!-- Add Form -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Thông Tin Sản Phẩm Mới</h5>
                            </div>
                            <div class="card-body">
                                <form id="addForm" action="${pageContext.request.contextPath}/admin/products" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="add">
                                    
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Tên Sản Phẩm <span class="text-danger">*</span></label>
                                        <input type="text" id="name" name="name" class="form-control" 
                                               placeholder="Nhập tên sản phẩm..." required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="description" class="form-label">Mô Tả</label>
                                        <textarea id="description" name="description" class="form-control" rows="4"
                                                  placeholder="Nhập mô tả sản phẩm..."></textarea>
                                    </div>

                                    <!-- Upload Image Section -->
                                    <div class="mb-3">
                                        <label for="productImage" class="form-label">Ảnh Sản Phẩm</label>
                                        <input type="file" id="productImage" name="productImage" class="form-control" 
                                               accept="image/*" onchange="previewImage(this)">
                                        <div class="form-text">Chọn file ảnh (JPG, PNG, GIF). Tối đa 5MB.</div>
                                        <!-- Image Preview -->
                                        <div id="imagePreview" class="mt-2" style="display: none;">
                                            <img id="previewImg" src="" alt="Preview" class="img-thumbnail" style="max-width: 200px; max-height: 200px;">
                                            <div class="mt-1">
                                                <small class="text-muted" id="fileName"></small>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="price" class="form-label">Giá <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <input type="number" id="price" name="price" class="form-control" 
                                                           placeholder="0" step="1000" min="0" required>
                                                    <span class="input-group-text">VNĐ</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="stockQuantity" class="form-label">Số Lượng <span class="text-danger">*</span></label>
                                                <input type="number" id="stockQuantity" name="stockQuantity" class="form-control" 
                                                       placeholder="0" min="0" value="1" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="categoryId" class="form-label">Danh Mục <span class="text-danger">*</span></label>
                                        <select id="categoryId" name="categoryId" class="form-select" required>
                                            <option value="">Chọn danh mục...</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.id}">${category.name}</option>
                                            </c:forEach>               
                                            <!--<option value="1">Động cơ</option>
                                            <option value="2">Thắng</option>
                                            <option value="3">Lốp xe</option>
                                            <option value="4">Đèn</option>
                                            <option value="5">Phụ kiện</option>-->
                                        </select>
                                    </div>

                                    <!-- Optional fields -->    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="brand" class="form-label">Thương Hiệu</label>
                                                <input type="text" id="brand" name="brand" class="form-control" 
                                                       placeholder="Honda, Yamaha, Suzuki...">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="model" class="form-label">Model</label>
                                                <input type="text" id="model" name="model" class="form-control" 
                                                       placeholder="Wave, Exciter, Winner...">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="yearCompatible" class="form-label">Năm Tương Thích</label>
                                        <input type="text" id="yearCompatible" name="yearCompatible" class="form-control" 
                                               placeholder="2020-2025, Tất cả...">
                                    </div>

                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <a href="${pageContext.request.contextPath}/admin/products" 
                                           class="btn btn-secondary me-md-2">
                                            <i class="fas fa-times"></i> Hủy
                                        </a>
                                        <button type="submit" class="btn btn-success" id="submitBtn">
                                            <i class="fas fa-plus"></i> Thêm Sản Phẩm
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="card-title mb-0"><i class="fas fa-lightbulb"></i> Gợi Ý</h6>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <small class="text-muted">Tên sản phẩm:</small><br>
                                    <small>Nên đặt tên rõ ràng, cụ thể. Ví dụ: "Phanh đĩa trước Honda Wave 110"</small>
                                </div>
                                <div class="mb-3">
                                    <small class="text-muted">Giá cả:</small><br>
                                    <small>Nên đặt giá theo bội số của 1000. Ví dụ: 150,000₫</small>
                                </div>
                                <div class="mb-3">
                                    <small class="text-muted">Mô tả:</small><br>
                                    <small>Ghi chi tiết về sản phẩm, cách sử dụng, độ bền...</small>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Fill -->
                        <div class="card mt-3">
                            <div class="card-header">
                                <h6 class="card-title mb-0"><i class="fas fa-magic"></i> Điền Nhanh</h6>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <button type="button" class="btn btn-outline-primary btn-sm" 
                                            onclick="quickFill('phanh')">
                                        <i class="fas fa-car"></i> Phụ tùng phanh
                                    </button>
                                    <button type="button" class="btn btn-outline-primary btn-sm" 
                                            onclick="quickFill('den')">
                                        <i class="fas fa-lightbulb"></i> Đèn xe
                                    </button>
                                    <button type="button" class="btn btn-outline-primary btn-sm" 
                                            onclick="quickFill('lop')">
                                        <i class="fas fa-circle"></i> Lốp xe
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
        // Quick fill functions
        function quickFill(type) {
            if (type === 'phanh') {
                document.getElementById('name').value = 'Phanh đĩa trước Honda Wave';
                document.getElementById('description').value = 'Phanh đĩa chất lượng cao, độ bền tốt';
                document.getElementById('price').value = '250000';
                document.getElementById('categoryId').value = '2';
                document.getElementById('brand').value = 'Honda';
            } else if (type === 'den') {
                document.getElementById('name').value = 'Đèn pha LED';
                document.getElementById('description').value = 'Đèn LED tiết kiệm điện, ánh sáng trắng';
                document.getElementById('price').value = '180000';
                document.getElementById('categoryId').value = '4';
                document.getElementById('brand').value = 'Universal';
            } else if (type === 'lop') {
                document.getElementById('name').value = 'Lốp Michelin City Pro';
                document.getElementById('description').value = 'Lốp chống trượt, độ bám tốt';
                document.getElementById('price').value = '450000';
                document.getElementById('categoryId').value = '3';
                document.getElementById('brand').value = 'Michelin';
            }
        }

        // Form validation
        document.getElementById('addForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            const name = document.getElementById('name').value.trim();
            const price = parseFloat(document.getElementById('price').value);
            const stock = parseInt(document.getElementById('stockQuantity').value);
            const category = document.getElementById('categoryId').value;

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

            // Show loading state
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang thêm...';
            submitBtn.disabled = true;
        });

        // Image preview function
        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            const previewImg = document.getElementById('previewImg');
            const fileName = document.getElementById('fileName');

            if (input.files && input.files[0]) {
                const file = input.files[0];
                
                // Check file size (5MB = 5 * 1024 * 1024 bytes)
                if (file.size > 5 * 1024 * 1024) {
                    alert('File ảnh quá lớn! Vui lòng chọn file nhỏ hơn 5MB.');
                    input.value = '';
                    preview.style.display = 'none';
                    return;
                }

                // Check file type
                if (!file.type.startsWith('image/')) {
                    alert('Vui lòng chọn file ảnh hợp lệ!');
                    input.value = '';
                    preview.style.display = 'none';
                    return;
                }

                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    fileName.textContent = file.name + ' (' + (file.size / 1024 / 1024).toFixed(2) + ' MB)';
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                preview.style.display = 'none';
            }
        }
    </script>
</body>
</html>
