<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - Phụ Tùng Xe Máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-sm mt-5 mb-5">
                    <div class="card-body p-4">
                        <div class="text-center mb-4">
                            <h3><i class="fas fa-motorcycle me-2 text-primary"></i>Phụ Tùng Xe Máy</h3>
                            <h5 class="card-title">Đăng Ký Tài Khoản</h5>
                        </div>
                        
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/register" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="username" class="form-label">Tên đăng nhập *</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" class="form-control" id="username" name="username" 
                                               value="${username}" required>
                                    </div>
                                    <div class="form-text">3-50 ký tự, chỉ bao gồm chữ, số và dấu gạch dưới</div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">Email *</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input type="email" class="form-control" id="email" name="email" 
                                               value="${email}" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="password" class="form-label">Mật khẩu *</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input type="password" class="form-control" id="password" name="password" required>
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password', 'toggleIcon1')">
                                            <i class="fas fa-eye" id="toggleIcon1"></i>
                                        </button>
                                    </div>
                                    <div class="form-text">Ít nhất 6 ký tự</div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu *</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword', 'toggleIcon2')">
                                            <i class="fas fa-eye" id="toggleIcon2"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Họ và tên *</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                    <input type="text" class="form-control" id="fullName" name="fullName" 
                                           value="${fullName}" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">Số điện thoại</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                        <input type="tel" class="form-control" id="phone" name="phone" 
                                               value="${phone}" placeholder="0123456789">
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="address" class="form-label">Địa chỉ</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                        <input type="text" class="form-control" id="address" name="address" 
                                               value="${address}" placeholder="Địa chỉ của bạn">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                                <label class="form-check-label" for="agreeTerms">
                                    Tôi đồng ý với <a href="#" target="_blank">Điều khoản sử dụng</a> 
                                    và <a href="#" target="_blank">Chính sách bảo mật</a>
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-user-plus me-2"></i>Đăng Ký
                            </button>
                        </form>
                        
                        <hr class="my-4">
                        
                        <div class="text-center">
                            <p class="mb-2">Đã có tài khoản?</p>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập
                            </a>
                        </div>
                        
                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                                <i class="fas fa-arrow-left me-1"></i>Về Trang Chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function togglePassword(fieldId, iconId) {
            const passwordField = document.getElementById(fieldId);
            const toggleIcon = document.getElementById(iconId);
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.className = 'fas fa-eye-slash';
            } else {
                passwordField.type = 'password';
                toggleIcon.className = 'fas fa-eye';
            }
        }
        
        // Password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                this.setCustomValidity('');
            }
        });
        
        // Phone number validation
        document.getElementById('phone').addEventListener('input', function() {
            const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
            if (this.value && !phoneRegex.test(this.value)) {
                this.setCustomValidity('Số điện thoại không hợp lệ');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
</body>
</html>
