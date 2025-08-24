<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
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
                    <h1 class="h2">Quản lý danh mục</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                            <i class="fas fa-plus"></i> Thêm danh mục
                        </button>
                    </div>
                </div>
                
                <!-- Success Messages -->
                <c:if test="${param.success eq 'added'}">
                    <div class="alert alert-success alert-dismissible fade show">
                        Thêm danh mục thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.success eq 'updated'}">
                    <div class="alert alert-success alert-dismissible fade show">
                        Cập nhật danh mục thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.success eq 'deleted'}">
                    <div class="alert alert-success alert-dismissible fade show">
                        Xóa danh mục thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Categories Table -->
                <div class="card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty categories}">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Hình ảnh</th>
                                                <th>Tên danh mục</th>
                                                <th>Mô tả</th>
                                                <th>Ngày tạo</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="category" items="${categories}">
                                                <tr>
                                                    <td>${category.id}</td>
                                                    <td>
                                                        <img src="${pageContext.request.contextPath}/resources/images/${category.image}" 
                                                             class="img-thumbnail" style="width: 50px; height: 50px; object-fit: cover;"
                                                             alt="${category.name}"
                                                             onerror="this.src='${pageContext.request.contextPath}/resources/images/default-product.jpg'">
                                                    </td>
                                                    <td><strong>${category.name}</strong></td>
                                                    <td>${category.description}</td>
                                                    <td>
                                                        <fmt:formatDate value="${category.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <button class="btn btn-sm btn-outline-primary" 
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#editCategoryModal"
                                                                    data-id="${category.id}"
                                                                    data-name="${category.name}"
                                                                    data-description="${category.description}"
                                                                    data-image="${category.image}"
                                                                    title="Sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger" 
                                                                    onclick="deleteCategory(${category.id}, '${category.name}')"
                                                                    title="Xóa">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-tags fa-3x text-muted mb-3"></i>
                                    <h5>Chưa có danh mục nào</h5>
                                    <p class="text-muted">Thêm danh mục đầu tiên để bắt đầu</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add Category Modal -->
    <div class="modal fade" id="addCategoryModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm danh mục mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/categories" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">Tên danh mục *</label>
                            <input type="text" class="form-control" id="categoryName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="categoryDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="categoryDescription" name="description" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="categoryImage" class="form-label">Tên file hình ảnh</label>
                            <input type="file" class="form-control" id="categoryImage" name="categoryImage"
                                   accept="image/*" onchange="previewImage(this)">
                            <div class="form-text">Chọn file ảnh (JPG, PNG, GIF). Tối đa 5MB.</div>
                        </div>
                        <!-- preview image-->
                        <div id="imagePreview" class="mt-2" style="display: none;">
                            <img id="previewImg" src="" alt="Preview" class="img-thumbnail" style="max-width: 200px; max-height: 200px;">
                            <div class="mt-1">
                                <small class="text-muted" id="fileName"></small>
                            </div>
                        </div>                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Thêm danh mục</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Edit Category Modal -->
    <div class="modal fade" id="editCategoryModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Sửa danh mục</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/categories" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="editCategoryId">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editCategoryName" class="form-label">Tên danh mục *</label>
                            <input type="text" class="form-control" id="editCategoryName" name="name" value="${category.getName()}" required>
                        </div>
                        <div class="mb-3">
                            <label for="editCategoryDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="editCategoryDescription" name="description" rows="3">${category.getDescription()}</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="editCategoryImage" class="form-label">Hình ảnh</label>
                            <input type="file" class="form-control" id="editCategoryImage" name="categoryImage" accept="image/*">
                            <div class="form-text">Chọn file ảnh mới để thay thế ảnh cũ. Để trống nếu không muốn thay đổi.</div>
                            <div id="editImagePreview" class="mt-2">
                                <span class="d-block mb-1">Hình ảnh hiện tại:</span>
                                <img id="currentEditImage" src="" alt="Hình ảnh hiện tại" class="img-thumbnail" style="max-width: 150px; height: auto;">
                            </div>
                        </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        //function editCategory(id, name, description, image) {
            //document.getElementById('editCategoryId').value = id;
            //document.getElementById('editCategoryName').value = name;
            //document.getElementById('editCategoryDescription').value = description;
            //document.getElementById('editCategoryImage').value = image;
            
            //new bootstrap.Modal(document.getElementById('editCategoryModal')).show();
        //}
        
        function deleteCategory(categoryId, categoryName) {
            if (confirm('Bạn có chắc chắn muốn xóa danh mục "' + categoryName + '"?\nViệc này có thể ảnh hưởng đến các sản phẩm trong danh mục.')) {
                window.location.href = '${pageContext.request.contextPath}/admin/categories?action=delete&id=' + categoryId;
            }
        }

        // Lắng nghe sự kiện modal chỉnh sửa được hiển thị
        const editCategoryModal = document.getElementById('editCategoryModal');
        editCategoryModal.addEventListener('show.bs.modal', function (event) {
            // Lấy nút đã kích hoạt modal
            const button = event.relatedTarget;
            
            // Lấy dữ liệu từ các thuộc tính data-*
            const id = button.getAttribute('data-id');
            const name = button.getAttribute('data-name');
            const description = button.getAttribute('data-description');
            const image = button.getAttribute('data-image');

            // Cập nhật các trường input trong modal
            const modalIdInput = editCategoryModal.querySelector('#editCategoryId');
            const modalNameInput = editCategoryModal.querySelector('#editCategoryName');
            const modalDescriptionTextarea = editCategoryModal.querySelector('#editCategoryDescription');
            const modalCurrentImage = editCategoryModal.querySelector('#currentEditImage');

            modalIdInput.value = id;
            modalNameInput.value = name;
            modalDescriptionTextarea.value = description;
            
            // Cập nhật hình ảnh xem trước
            if (image) {
                                        modalCurrentImage.src = '${pageContext.request.contextPath}/resources/images/' + image;
                // Hiển thị phần xem trước nếu có ảnh
                modalCurrentImage.closest('div').style.display = 'block';
            } else {
                // Ẩn hoặc đặt ảnh placeholder nếu không có
                                        modalCurrentImage.src = '${pageContext.request.contextPath}/resources/images/default-category.jpg';
            }
        });
    </script>
</body>
</html>
