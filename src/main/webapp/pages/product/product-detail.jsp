<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - Phụ Tùng Xe Máy</title>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                <li class="breadcrumb-item active">${product.name}</li>
            </ol>
        </nav>
        
        <div class="row">
            <!-- Product Image -->
            <div class="col-lg-6 mb-4">
                <div class="text-center">
                    <img src="${pageContext.request.contextPath}/resources/images/${product.image}" 
                         class="img-fluid rounded" alt="${product.name}"
                         onerror="this.src='${pageContext.request.contextPath}/resources/images/default-product.jpg'"
                         style="max-height: 500px;">
                </div>
            </div>
            
            <!-- Product Info -->
            <div class="col-lg-6">
                <h1 class="h2 mb-3">${product.name}</h1>
                
                <div class="mb-3">
                    <span class="badge bg-secondary me-2">${product.brand}</span>
                    <span class="badge bg-info">${product.categoryName}</span>
                </div>
                
                <div class="row mb-3">
                    <div class="col-sm-6">
                        <h3 class="text-primary">
                            <fmt:formatNumber value="${product.price}" pattern="#,###" />₫
                        </h3>
                    </div>
                    <div class="col-sm-6 text-sm-end">
                        <c:choose>
                            <c:when test="${product.stockQuantity > 0}">
                                <span class="text-success">
                                    <i class="fas fa-check-circle"></i> Còn ${product.stockQuantity} sản phẩm
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-danger">
                                    <i class="fas fa-times-circle"></i> Hết hàng
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="mb-4">
                    <h5>Mô tả sản phẩm:</h5>
                    <p class="text-muted">${product.description}</p>
                </div>
                
                <!-- Add to Cart Form -->
                <c:if test="${product.stockQuantity > 0}">
                    <div class="row mb-4">
                        <div class="col-6 col-md-4">
                            <label for="quantity" class="form-label">Số lượng:</label>
                            <div class="input-group">
                                <button class="btn btn-outline-secondary" type="button" onclick="decreaseQuantity()">
                                    <i class="fas fa-minus"></i>
                                </button>
                                <input type="number" class="form-control text-center" id="quantity" value="1" 
                                       min="1" max="${product.stockQuantity}">
                                <button class="btn btn-outline-secondary" type="button" onclick="increaseQuantity()">
                                    <i class="fas fa-plus"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-grid gap-2 d-md-flex">
                        <form method="post" action="${pageContext.request.contextPath}/cart" style="display: inline;">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="hidden" name="quantity" id="hiddenQuantity" value="1">
                            <button type="submit" class="btn btn-primary btn-lg me-md-2">
                                <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                            </button>
                        </form>
                        <form method="get" action="${pageContext.request.contextPath}/order" style="display: inline;">
                            <input type="hidden" name="action" value="checkout">
                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="hidden" name="quantity" id="hiddenQuantityBuy" value="1">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="fas fa-bolt"></i> Mua ngay
                            </button>
                        </form>
                    </div>
                </c:if>
                
                <c:if test="${product.stockQuantity == 0}">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle"></i>
                        Sản phẩm này hiện đang hết hàng. Vui lòng quay lại sau!
                    </div>
                </c:if>
            </div>
        </div>
        
        <!-- Product Details Tabs -->
        <div class="row mt-5">
            <div class="col-12">
                <ul class="nav nav-tabs" id="productTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="specs-tab" data-bs-toggle="tab" 
                                data-bs-target="#specs" type="button" role="tab">
                            Thông số kỹ thuật
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="description-tab" data-bs-toggle="tab" 
                                data-bs-target="#description" type="button" role="tab">
                            Mô tả chi tiết
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="shipping-tab" data-bs-toggle="tab" 
                                data-bs-target="#shipping" type="button" role="tab">
                            Vận chuyển
                        </button>
                    </li>
                </ul>
                
                <div class="tab-content" id="productTabsContent">
                    <div class="tab-pane fade show active" id="specs" role="tabpanel">
                        <div class="p-4">
                            <div class="row">
                                <div class="col-md-6">
                                    <table class="table table-bordered">
                                        <tr>
                                            <td><strong>Tên sản phẩm:</strong></td>
                                            <td>${product.name}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Thương hiệu:</strong></td>
                                            <td>${product.brand}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Danh mục:</strong></td>
                                            <td>${product.categoryName}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Giá:</strong></td>
                                            <td><fmt:formatNumber value="${product.price}" pattern="#,###" />₫</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Tình trạng:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.stockQuantity > 0}">
                                                        <span class="badge bg-success">Còn hàng</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Hết hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="tab-pane fade" id="description" role="tabpanel">
                        <div class="p-4">
                            <h5>Mô tả chi tiết sản phẩm</h5>
                            <p>${product.description}</p>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i>
                                <strong>Lưu ý:</strong> Hình ảnh sản phẩm chỉ mang tính chất minh họa. 
                                Sản phẩm thực tế có thể khác biệt về màu sắc và chi tiết.
                            </div>
                        </div>
                    </div>
                    
                    <div class="tab-pane fade" id="shipping" role="tabpanel">
                        <div class="p-4">
                            <h5>Thông tin vận chuyển</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card border-primary">
                                        <div class="card-body">
                                            <h6 class="card-title">
                                                <i class="fas fa-shipping-fast text-primary"></i>
                                                Giao hàng nhanh
                                            </h6>
                                            <p class="card-text">
                                                Giao hàng trong vòng 1-2 ngày tại nội thành TP.HCM
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card border-success">
                                        <div class="card-body">
                                            <h6 class="card-title">
                                                <i class="fas fa-shield-alt text-success"></i>
                                                Bảo hành chính hãng
                                            </h6>
                                            <p class="card-text">
                                                Bảo hành theo quy định của nhà sản xuất
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Related Products -->
        <c:if test="${not empty relatedProducts}">
            <div class="row mt-5">
                <div class="col-12">
                    <h3>Sản phẩm liên quan</h3>
                    <div class="row">
                        <c:forEach var="relatedProduct" items="${relatedProducts}" end="3">
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="card product-card h-100">
                                    <img src="${pageContext.request.contextPath}/resources/images/${relatedProduct.image}" 
                                         class="card-img-top" alt="${relatedProduct.name}"
                                         onerror="this.src='${pageContext.request.contextPath}/resources/images/default-product.jpg'">
                                    <div class="card-body">
                                        <h6 class="card-title">${relatedProduct.name}</h6>
                                        <p class="card-text text-primary">
                                            <fmt:formatNumber value="${relatedProduct.price}" pattern="#,###" />₫
                                        </p>
                                        <a href="${pageContext.request.contextPath}/products?action=detail&id=${relatedProduct.id}" 
                                           class="btn btn-outline-primary btn-sm">
                                            Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <!-- Include footer -->
    <jsp:include page="../common/includes/footer.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Set global variables for JavaScript
        window.contextPath = '${pageContext.request.contextPath}';
        window.userLoggedIn = ${sessionScope.user != null};
        window.productId = ${product.id};
        window.maxQuantity = ${product.stockQuantity};
    </script>
    
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
    
    <script>
        function increaseQuantity() {
            const qtyInput = document.getElementById('quantity');
            const currentQty = parseInt(qtyInput.value);
            if (currentQty < window.maxQuantity) {
                qtyInput.value = currentQty + 1;
                updateHiddenQuantity();
            }
        }
        
        function decreaseQuantity() {
            const qtyInput = document.getElementById('quantity');
            const currentQty = parseInt(qtyInput.value);
            if (currentQty > 1) {
                qtyInput.value = currentQty - 1;
                updateHiddenQuantity();
            }
        }
        
        function updateHiddenQuantity() {
            const quantity = document.getElementById('quantity').value;
            document.getElementById('hiddenQuantity').value = quantity;
            document.getElementById('hiddenQuantityBuy').value = quantity;
        }
        
        // Update hidden inputs when quantity changes
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('quantity').addEventListener('change', updateHiddenQuantity);
        });
    </script>
</body>
</html>
