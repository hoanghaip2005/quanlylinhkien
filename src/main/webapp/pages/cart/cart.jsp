<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - Phụ Tùng Xe Máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Include header -->
    <jsp:include page="../common/includes/header.jsp"/>
    
    <div class="container my-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                <li class="breadcrumb-item active">Giỏ hàng</li>
            </ol>
        </nav>
        
        <h2><i class="fas fa-shopping-cart"></i> Giỏ hàng của bạn</h2>
        
        <c:choose>
            <c:when test="${not empty cartItems}">
                <div class="row">
                    <!-- Cart Items -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <c:forEach var="item" items="${cartItems}" varStatus="status">
                                    <div class="row cart-item mb-3 ${status.last ? '' : 'border-bottom pb-3'}">
                                        <div class="col-md-2">
                                            <img src="${pageContext.request.contextPath}/resources/images/${item.productImage}" 
                                                 class="img-fluid rounded" alt="${item.productName}"
                                                 onerror="this.src='${pageContext.request.contextPath}/resources/images/default-product.jpg'">
                                        </div>
                                        <div class="col-md-4">
                                            <h6 class="mb-1">${item.productName}</h6>
                                            <small class="text-muted">Mã SP: ${item.productId}</small>
                                            <br>
                                            <small class="text-success">
                                                <c:choose>
                                                    <c:when test="${item.stockQuantity > 0}">
                                                        <i class="fas fa-check"></i> Còn hàng
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-times text-danger"></i> Hết hàng
                                                    </c:otherwise>
                                                </c:choose>
                                            </small>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="text-center">
                                                <strong>
                                                    <fmt:formatNumber value="${item.productPrice}" pattern="#,###" />₫
                                                </strong>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <form method="post" action="${pageContext.request.contextPath}/cart" style="display: inline;">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="productId" value="${item.productId}">
                                                <div class="input-group input-group-sm">
                                                    <input type="number" name="quantity" class="form-control text-center" 
                                                           value="${item.quantity}" min="1" max="${item.stockQuantity}">
                                                    <button class="btn btn-outline-primary" type="submit">
                                                        <i class="fas fa-sync"></i>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="col-md-2 text-end">
                                            <div class="mb-2">
                                                <strong class="text-primary">
                                                    <fmt:formatNumber value="${item.productPrice * item.quantity}" pattern="#,###" />₫
                                                </strong>
                                            </div>
                                            <form method="post" action="${pageContext.request.contextPath}/cart" style="display: inline;">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="productId" value="${item.productId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                        onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <!-- Actions -->
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary">
                                            <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                                        </a>
                                    </div>
                                    <div class="col-md-6 text-end">
                                        <!-- Loại bỏ các button không cần thiết -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order Summary -->
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Tóm tắt đơn hàng</h5>
                            </div>
                            <div class="card-body">
                                <c:set var="total" value="0" />
                                <c:forEach var="item" items="${cartItems}">
                                    <c:set var="total" value="${total + (item.productPrice * item.quantity)}" />
                                </c:forEach>
                                
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Tạm tính:</span>
                                    <span><fmt:formatNumber value="${total}" pattern="#,###" />₫</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Phí vận chuyển:</span>
                                    <span class="text-success">Miễn phí</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between mb-3">
                                    <strong>Tổng cộng:</strong>
                                    <strong class="text-primary">
                                        <fmt:formatNumber value="${total}" pattern="#,###" />₫
                                    </strong>
                                </div>
                                
                                <!-- Checkout Button -->
                                <div class="d-grid">
                                    <c:choose>
                                        <c:when test="${sessionScope.user != null}">
                                            <a href="${pageContext.request.contextPath}/order?action=checkout" 
                                               class="btn btn-success btn-lg">
                                                <i class="fas fa-credit-card"></i> Thanh toán
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/login?redirect=${pageContext.request.contextPath}/order?action=checkout" 
                                               class="btn btn-primary btn-lg">
                                                <i class="fas fa-sign-in-alt"></i> Đăng nhập để thanh toán
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <!-- Coupon Code -->
                                <div class="mt-3">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Mã giảm giá">
                                        <button class="btn btn-outline-secondary" type="button">
                                            Áp dụng
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Shopping Tips -->
                        <div class="card mt-3">
                            <div class="card-body">
                                <h6 class="card-title">
                                    <i class="fas fa-info-circle text-info"></i> Thông tin hữu ích
                                </h6>
                                <ul class="list-unstyled mb-0 small">
                                    <li><i class="fas fa-shipping-fast text-success"></i> Miễn phí vận chuyển cho đơn hàng trên 500.000₫</li>
                                    <li><i class="fas fa-shield-alt text-primary"></i> Bảo hành chính hãng</li>
                                    <li><i class="fas fa-undo text-warning"></i> Đổi trả trong 7 ngày</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Empty Cart -->
                <div class="text-center py-5">
                    <i class="fas fa-shopping-cart fa-4x text-muted mb-3"></i>
                    <h4>Giỏ hàng của bạn đang trống</h4>
                    <p class="text-muted">Hãy thêm một số sản phẩm vào giỏ hàng để tiếp tục</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Bắt đầu mua sắm
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Include footer -->
    <jsp:include page="../common/includes/footer.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Set global variables for JavaScript
        window.contextPath = '${pageContext.request.contextPath}';
        window.userLoggedIn = ${sessionScope.user != null ? 'true' : 'false'};
    </script>
    
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
    
    <script>
        function updateCartQuantity(productId, quantity) {
            if (quantity < 1) {
                removeFromCart(productId);
                return;
            }
            
            fetch('${pageContext.request.contextPath}/cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `action=update&productId=${productId}&quantity=${quantity}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert(data.message || 'Có lỗi xảy ra khi cập nhật giỏ hàng');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi cập nhật giỏ hàng');
            });
        }
        
        function removeFromCart(productId) {
            if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                fetch('${pageContext.request.contextPath}/cart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `action=remove&productId=${productId}`
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert(data.message || 'Có lỗi xảy ra khi xóa sản phẩm');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa sản phẩm');
                });
            }
        }
        
        function clearCart() {
            if (confirm('Bạn có chắc chắn muốn xóa tất cả sản phẩm trong giỏ hàng?')) {
                fetch('${pageContext.request.contextPath}/cart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=clear'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert(data.message || 'Có lỗi xảy ra khi xóa giỏ hàng');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa giỏ hàng');
                });
            }
        }
        
        function updateAllCart() {
            location.reload();
        }
    </script>
</body>
</html>
