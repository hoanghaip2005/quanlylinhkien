<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Phụ Tùng Xe Máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm mt-5">
                    <div class="card-body p-4">
                        <div class="text-center mb-4">
                            <h3><i class="fas fa-motorcycle me-2 text-primary"></i>Phụ Tùng Xe Máy</h3>
                            <h5 class="card-title">Đăng Nhập</h5>
                        </div>
                        
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle me-2"></i>${successMessage}
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Tên đăng nhập</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control" id="username" name="username" 
                                           value="${username}" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">Mật khẩu</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword()">
                                        <i class="fas fa-eye" id="toggleIcon"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">
                                    Ghi nhớ đăng nhập
                                </label>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập
                            </button>
                        </form>
                        
                        <hr class="my-4">
                        
                        <div class="text-center">
                            <p class="mb-2">Chưa có tài khoản?</p>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-primary">
                                <i class="fas fa-user-plus me-2"></i>Đăng Ký Ngay
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
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.className = 'fas fa-eye-slash';
            } else {
                passwordField.type = 'password';
                toggleIcon.className = 'fas fa-eye';
            }
        }
        
        // Demo accounts info
        document.addEventListener('DOMContentLoaded', function() {
            const demoInfo = document.createElement('div');
            demoInfo.className = 'alert alert-info mt-3';
            demoInfo.innerHTML = `
                <strong>Tài khoản demo:</strong><br>
                <small>Admin: admin / 123456</small><br>
                <small>User: user1 / 123456</small>
            `;
            document.querySelector('.card-body').appendChild(demoInfo);
        });
    </script>
</body>
</html>
