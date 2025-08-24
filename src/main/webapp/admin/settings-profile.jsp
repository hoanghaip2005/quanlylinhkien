<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - Admin</title>
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
                    <h1 class="h2">
                        <i class="fas fa-user-cog"></i> Thông tin cá nhân
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/settings" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </div>
                
                <!-- Success Messages -->
                <c:if test="${param.success eq 'updated'}">
                    <div class="alert alert-success alert-dismissible fade show">
                        Cập nhật thông tin thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.success eq 'passwordchanged'}">
                    <div class="alert alert-success alert-dismissible fade show">
                        Đổi mật khẩu thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Error Messages -->
                <c:if test="${param.error eq 'wrongpassword'}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        Mật khẩu hiện tại không đúng!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error eq 'mismatch'}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        Mật khẩu xác nhận không khớp!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <div class="row">
                    <!-- Profile Information -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Cập nhật thông tin</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/settings" method="post">
                                    <input type="hidden" name="action" value="updateProfile">
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="username" class="form-label">Tên đăng nhập</label>
                                                <input type="text" class="form-control" id="username" 
                                                       value="${user.username}" readonly>
                                                <small class="text-muted">Không thể thay đổi tên đăng nhập</small>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="role" class="form-label">Vai trò</label>
                                                <input type="text" class="form-control" id="role" 
                                                       value="${user.role}" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="fullName" class="form-label">Họ tên *</label>
                                                <input type="text" class="form-control" id="fullName" name="fullName" 
                                                       value="${user.fullName}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="email" class="form-label">Email *</label>
                                                <input type="email" class="form-control" id="email" name="email" 
                                                       value="${user.email}" required>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="phone" class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" id="phone" name="phone" 
                                                       value="${user.phone}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="address" class="form-label">Địa chỉ</label>
                                                <input type="text" class="form-control" id="address" name="address" 
                                                       value="${user.address}">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Cập nhật thông tin
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <!-- Change Password -->
                        <div class="card mt-4">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Đổi mật khẩu</h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/settings" method="post">
                                    <input type="hidden" name="action" value="changePassword">
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label for="currentPassword" class="form-label">Mật khẩu hiện tại *</label>
                                                <input type="password" class="form-control" id="currentPassword" 
                                                       name="currentPassword" required>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="newPassword" class="form-label">Mật khẩu mới *</label>
                                                <input type="password" class="form-control" id="newPassword" 
                                                       name="newPassword" required minlength="6">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu *</label>
                                                <input type="password" class="form-control" id="confirmPassword" 
                                                       name="confirmPassword" required minlength="6">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-key"></i> Đổi mật khẩu
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Profile Summary -->
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Thông tin tài khoản</h5>
                            </div>
                            <div class="card-body">
                                <div class="text-center mb-3">
                                    <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center" 
                                         style="width: 80px; height: 80px; font-size: 2rem;">
                                        <i class="fas fa-user-shield"></i>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>ID:</strong> ${user.id}
                                </div>
                                <div class="mb-3">
                                    <strong>Tên đăng nhập:</strong><br>
                                    ${user.username}
                                </div>
                                <div class="mb-3">
                                    <strong>Vai trò:</strong><br>
                                    <span class="badge bg-danger fs-6">${user.role}</span>
                                </div>
                                <div class="mb-3">
                                    <strong>Trạng thái:</strong><br>
                                    <span class="badge bg-success fs-6">
                                        ${user.status == 'ACTIVE' ? 'Hoạt động' : 'Ngưng hoạt động'}
                                    </span>
                                </div>
                                <div class="mb-3">
                                    <strong>Ngày tạo:</strong><br>
                                    <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy" />
                                </div>
                                <div class="mb-3">
                                    <strong>Cập nhật lần cuối:</strong><br>
                                    <fmt:formatDate value="${user.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="card mt-3">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Bảo mật</h5>
                            </div>
                            <div class="card-body">
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle"></i>
                                    <strong>Lưu ý:</strong> 
                                    Hãy sử dụng mật khẩu mạnh và thay đổi thường xuyên để bảo mật tài khoản.
                                </div>
                                <div class="d-grid">
                                    <button class="btn btn-outline-warning btn-sm" 
                                            onclick="document.getElementById('currentPassword').focus()">
                                        <i class="fas fa-key"></i> Đổi mật khẩu ngay
                                    </button>
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
        // Validate password confirmation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = this.value;
            
            if (newPassword !== confirmPassword) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
</body>
</html>
