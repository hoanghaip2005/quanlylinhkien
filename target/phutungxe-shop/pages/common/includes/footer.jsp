<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="bg-dark text-light py-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <h5><i class="fas fa-motorcycle me-2"></i>Phụ Tùng Xe Máy</h5>
                <p>Chuyên cung cấp phụ tùng xe máy chính hãng với chất lượng tốt nhất và giá cả hợp lý.</p>
                <div class="social-links">
                    <a href="#" class="text-light me-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-light me-3"><i class="fab fa-youtube"></i></a>
                    <a href="#" class="text-light me-3"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-light"><i class="fab fa-zalo"></i></a>
                </div>
            </div>
            
            <div class="col-lg-2 mb-4">
                <h6>Sản Phẩm</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/products?action=category&categoryId=1" class="text-light text-decoration-none">Lốp xe</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?action=category&categoryId=2" class="text-light text-decoration-none">Phanh</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?action=category&categoryId=3" class="text-light text-decoration-none">Nhớt</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?action=category&categoryId=4" class="text-light text-decoration-none">Lọc gió</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?action=category&categoryId=5" class="text-light text-decoration-none">Bóng đèn</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?action=category&categoryId=6" class="text-light text-decoration-none">Ắc quy</a></li>
                </ul>
            </div>
            
            <div class="col-lg-3 mb-4">
                <h6>Hỗ Trợ</h6>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-light text-decoration-none">Hướng dẫn mua hàng</a></li>
                    <li><a href="#" class="text-light text-decoration-none">Chính sách bảo hành</a></li>
                    <li><a href="#" class="text-light text-decoration-none">Chính sách đổi trả</a></li>
                    <li><a href="#" class="text-light text-decoration-none">Giao hàng và thanh toán</a></li>
                </ul>
            </div>
            
            <div class="col-lg-3 mb-4">
                <h6>Liên Hệ</h6>
                <ul class="list-unstyled">
                    <li><i class="fas fa-map-marker-alt me-2"></i>123 Đường ABC, Quận 1, TP.HCM</li>
                    <li><i class="fas fa-phone me-2"></i>0123 456 789</li>
                    <li><i class="fas fa-envelope me-2"></i>info@phutungxe.com</li>
                    <li><i class="fas fa-clock me-2"></i>Thời gian: 8:00 - 20:00 (T2-CN)</li>
                </ul>
            </div>
        </div>
        
        <hr class="my-4">
        
        <div class="row align-items-center">
            <div class="col-md-6">
                <p class="mb-0">&copy; 2024 Phụ Tùng Xe Máy. Tất cả quyền được bảo lưu.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <img src="${pageContext.request.contextPath}/images/payment-methods.svg" alt="Payment Methods" class="img-fluid" style="max-height: 40px;">
            </div>
        </div>
    </div>
</footer>
