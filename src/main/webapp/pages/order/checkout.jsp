<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - Phụ Tùng Xe Máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Include header -->
    <jsp:include page="includes/header.jsp"/>
    
    <div class="container my-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                <li class="breadcrumb-item active">Thanh toán</li>
            </ol>
        </nav>
        
        <h2><i class="fas fa-credit-card"></i> Thanh toán đơn hàng</h2>
        
        <c:if test="${not empty message}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/order" method="post" id="checkoutForm">
            <input type="hidden" name="action" value="place">
            <c:if test="${isDirectCheckout}">
                <input type="hidden" name="productId" value="${param.productId}">
                <input type="hidden" name="quantity" value="${param.quantity}">
            </c:if>
            
            <div class="row">
                <!-- Billing Information -->
                <div class="col-lg-7">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-user"></i> Thông tin giao hàng</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="fullName" class="form-label">Họ và tên *</label>
                                        <input type="text" class="form-control" id="fullName" name="fullName" 
                                               value="${sessionScope.user.fullName}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Số điện thoại *</label>
                                        <input type="tel" class="form-control" id="phone" name="phone" 
                                               value="${sessionScope.user.phone}" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${sessionScope.user.email}" readonly>
                            </div>
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ giao hàng *</label>
                                <textarea class="form-control" id="address" name="address" 
                                          rows="3" required placeholder="Nhập địa chỉ chi tiết...">${sessionScope.user.address}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="notes" class="form-label">Ghi chú đơn hàng</label>
                                <textarea class="form-control" id="notes" name="notes" 
                                          rows="2" placeholder="Ghi chú thêm về đơn hàng (không bắt buộc)"></textarea>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Payment Method -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-credit-card"></i> Phương thức thanh toán</h5>
                        </div>
                        <div class="card-body">
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       id="cod" value="COD" checked>
                                <label class="form-check-label" for="cod">
                                    <i class="fas fa-money-bill-wave text-success"></i>
                                    Thanh toán khi nhận hàng (COD)
                                </label>
                                <small class="d-block text-muted mt-1">
                                    Thanh toán bằng tiền mặt khi nhận hàng
                                </small>
                            </div>
                            
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       id="bank" value="BANK_TRANSFER">
                                <label class="form-check-label" for="bank">
                                    <i class="fas fa-university text-primary"></i>
                                    Chuyển khoản ngân hàng
                                </label>
                                <small class="d-block text-muted mt-1">
                                    Chuyển khoản trước khi giao hàng
                                </small>
                            </div>
                            
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       id="momo" value="MOMO">
                                <label class="form-check-label" for="momo">
                                    <i class="fas fa-mobile-alt text-danger"></i>
                                    Ví điện tử MoMo
                                </label>
                                <small class="d-block text-muted mt-1">
                                    Thanh toán qua ví MoMo
                                </small>
                            </div>
                            
                            <!-- Bank Transfer Details (Hidden by default) -->
                            <div id="bankDetails" class="mt-3" style="display: none;">
                                <div class="alert alert-info">
                                    <h6>Thông tin chuyển khoản:</h6>
                                    <p class="mb-1"><strong>Ngân hàng:</strong> Vietcombank</p>
                                    <p class="mb-1"><strong>Số tài khoản:</strong> 1234567890</p>
                                    <p class="mb-1"><strong>Chủ tài khoản:</strong> Cửa hàng phụ tùng xe máy</p>
                                    <p class="mb-0"><strong>Nội dung:</strong> Thanh toan don hang [Mã đơn hàng]</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Order Summary -->
                <div class="col-lg-5">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-list"></i> Đơn hàng của bạn</h5>
                        </div>
                        <div class="card-body">
                            <!-- Cart Items Summary -->
                            <c:if test="${not empty cartItems}">
                                <div class="mb-3">
                                    <c:set var="total" value="0" />
                                    <c:forEach var="item" items="${cartItems}">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <div class="flex-grow-1">
                                                <h6 class="mb-0">${item.productName}</h6>
                                                <small class="text-muted">
                                                    <fmt:formatNumber value="${item.productPrice}" pattern="#,###" />₫ × ${item.quantity}
                                                </small>
                                            </div>
                                            <div class="text-end">
                                                <strong>
                                                    <fmt:formatNumber value="${item.productPrice * item.quantity}" pattern="#,###" />₫
                                                </strong>
                                            </div>
                                        </div>
                                        <c:set var="total" value="${total + (item.productPrice * item.quantity)}" />
                                    </c:forEach>
                                </div>
                                <hr>
                            </c:if>
                            
                            <!-- Order Totals -->
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tạm tính:</span>
                                <span><fmt:formatNumber value="${total}" pattern="#,###" />₫</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Phí vận chuyển:</span>
                                <span class="text-success">Miễn phí</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Thuế VAT:</span>
                                <span>Đã bao gồm</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-3">
                                <strong>Tổng cộng:</strong>
                                <strong class="text-primary h5">
                                    <fmt:formatNumber value="${total}" pattern="#,###" />₫
                                </strong>
                            </div>
                            
                            <!-- Terms and Conditions -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="terms" required>
                                <label class="form-check-label" for="terms">
                                    Tôi đồng ý với <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">điều khoản và điều kiện</a> *
                                </label>
                            </div>
                            
                            <!-- Place Order Button -->
                            <div class="d-grid">
                                <button type="submit" class="btn btn-success btn-lg" id="placeOrderBtn">
                                    <i class="fas fa-check"></i> Đặt hàng
                                </button>
                            </div>
                            
                            <!-- Security Info -->
                            <div class="text-center mt-3">
                                <small class="text-muted">
                                    <i class="fas fa-lock"></i> Thông tin của bạn được bảo mật
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Delivery Info -->
                    <div class="card mt-3">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="fas fa-shipping-fast text-primary"></i> Thông tin giao hàng
                            </h6>
                            <ul class="list-unstyled mb-0 small">
                                <li><i class="fas fa-check text-success"></i> Giao hàng trong 1-3 ngày</li>
                                <li><i class="fas fa-check text-success"></i> Miễn phí vận chuyển</li>
                                <li><i class="fas fa-check text-success"></i> Kiểm tra hàng trước khi thanh toán</li>
                                <li><i class="fas fa-check text-success"></i> Đổi trả trong 7 ngày</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <!-- Terms and Conditions Modal -->
    <div class="modal fade" id="termsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Điều khoản và điều kiện</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6>1. Điều khoản chung</h6>
                    <p>Khi sử dụng dịch vụ của chúng tôi, bạn đồng ý tuân thủ các điều khoản và điều kiện này.</p>
                    
                    <h6>2. Chính sách giao hàng</h6>
                    <p>Chúng tôi cam kết giao hàng trong thời gian từ 1-3 ngày làm việc tùy theo khu vực.</p>
                    
                    <h6>3. Chính sách thanh toán</h6>
                    <p>Chúng tôi chấp nhận thanh toán COD, chuyển khoản ngân hàng và ví điện tử.</p>
                    
                    <h6>4. Chính sách đổi trả</h6>
                    <p>Sản phẩm có thể được đổi trả trong vòng 7 ngày nếu còn nguyên vẹn và chưa sử dụng.</p>
                    
                    <h6>5. Bảo mật thông tin</h6>
                    <p>Chúng tôi cam kết bảo mật thông tin khách hàng theo quy định pháp luật.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Include footer -->
    <jsp:include page="includes/footer.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Payment method change handler
        document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const bankDetails = document.getElementById('bankDetails');
                if (this.value === 'BANK_TRANSFER') {
                    bankDetails.style.display = 'block';
                } else {
                    bankDetails.style.display = 'none';
                }
            });
        });
        
        // Form validation
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const fullName = document.getElementById('fullName').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const address = document.getElementById('address').value.trim();
            const terms = document.getElementById('terms').checked;
            
            if (!fullName || !phone || !address) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin giao hàng');
                return;
            }
            
            if (!terms) {
                e.preventDefault();
                alert('Vui lòng đồng ý với điều khoản và điều kiện');
                return;
            }
            
            // Disable submit button to prevent double submission
            const submitBtn = document.getElementById('placeOrderBtn');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
        });
        
        // Phone number validation
        document.getElementById('phone').addEventListener('input', function() {
            const phone = this.value.replace(/\D/g, '');
            if (phone.length > 10) {
                this.value = phone.substring(0, 10);
            }
        });
    </script>
</body>
</html>
