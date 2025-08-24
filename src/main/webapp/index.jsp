<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phụ Tùng Xe Máy - Trang Chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Include header -->
    <jsp:include page="pages/common/includes/header.jsp"/>
    
    <!-- Hero Section -->
    <section class="hero-section bg-primary text-white py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">Phụ Tùng Xe Máy Chính Hãng</h1>
                    <p class="lead mb-4">Chuyên cung cấp phụ tùng xe máy chất lượng cao với giá tốt nhất thị trường</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-light btn-lg">
                        <i class="fas fa-shopping-cart me-2"></i>Mua Ngay
                    </a>
                </div>
                <div class="col-lg-6">
                    <img src="${pageContext.request.contextPath}/resources/images/hero-motorcycle.jpg" 
                         alt="Xe máy" class="img-fluid rounded">
                </div>
            </div>
        </div>
    </section>
    
    <!-- Categories Section -->
    <section class="categories-section py-5">
        <div class="container">
            <h2 class="text-center mb-5">Danh Mục Sản Phẩm</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card category-card h-100">
                        <img src="${pageContext.request.contextPath}/resources/images/lop-xe.jpg" 
                             class="card-img-top" alt="Lốp xe">
                        <div class="card-body text-center">
                            <h5 class="card-title">Lốp Xe</h5>
                            <p class="card-text">Lốp xe máy các hãng nổi tiếng</p>
                            <a href="${pageContext.request.contextPath}/products?action=category&categoryId=1" 
                               class="btn btn-primary">Xem Sản Phẩm</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card category-card h-100">
                        <img src="${pageContext.request.contextPath}/resources/images/phanh.jpg" 
                             class="card-img-top" alt="Phanh">
                        <div class="card-body text-center">
                            <h5 class="card-title">Phanh</h5>
                            <p class="card-text">Má phanh, đĩa phanh chất lượng cao</p>
                            <a href="${pageContext.request.contextPath}/products?action=category&categoryId=2" 
                               class="btn btn-primary">Xem Sản Phẩm</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card category-card h-100">
                        <img src="${pageContext.request.contextPath}/resources/images/nhot.jpg" 
                             class="card-img-top" alt="Nhớt">
                        <div class="card-body text-center">
                            <h5 class="card-title">Nhớt</h5>
                            <p class="card-text">Dầu nhớt động cơ chính hãng</p>
                            <a href="${pageContext.request.contextPath}/products?action=category&categoryId=3" 
                               class="btn btn-primary">Xem Sản Phẩm</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Featured Products Section -->
    <section class="featured-products py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-5">Sản Phẩm Nổi Bật</h2>
            <div class="row" id="featured-products">
                <!-- Products will be loaded here -->
            </div>
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary btn-lg">
                    Xem Tất Cả Sản Phẩm
                </a>
            </div>
        </div>
    </section>
    
    <!-- Features Section -->
    <section class="features-section py-5">
        <div class="container">
            <div class="row">
                <div class="col-md-3 text-center mb-4">
                    <div class="feature-item">
                        <i class="fas fa-shipping-fast fa-3x text-primary mb-3"></i>
                        <h5>Giao Hàng Nhanh</h5>
                        <p>Giao hàng toàn quốc trong 24h</p>
                    </div>
                </div>
                <div class="col-md-3 text-center mb-4">
                    <div class="feature-item">
                        <i class="fas fa-medal fa-3x text-primary mb-3"></i>
                        <h5>Chất Lượng</h5>
                        <p>Sản phẩm chính hãng 100%</p>
                    </div>
                </div>
                <div class="col-md-3 text-center mb-4">
                    <div class="feature-item">
                        <i class="fas fa-tools fa-3x text-primary mb-3"></i>
                        <h5>Bảo Hành</h5>
                        <p>Bảo hành chính hãng theo quy định</p>
                    </div>
                </div>
                <div class="col-md-3 text-center mb-4">
                    <div class="feature-item">
                        <i class="fas fa-headset fa-3x text-primary mb-3"></i>
                        <h5>Hỗ Trợ 24/7</h5>
                        <p>Tư vấn và hỗ trợ mọi lúc</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Include footer -->
    <jsp:include page="pages/common/includes/footer.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Set global variables for JavaScript
        window.contextPath = '${pageContext.request.contextPath}';
        window.userLoggedIn = '${sessionScope.user != null ? "true" : "false"}';
    </script>
    
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
    
    <script>
        // Load featured products
        document.addEventListener('DOMContentLoaded', function() {
            loadFeaturedProducts();
        });
        
        function loadFeaturedProducts() {
            fetch('${pageContext.request.contextPath}/api/featured-products')
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        displayFeaturedProducts(data.products);
                    }
                })
                .catch(error => console.error('Error:', error));
        }
        
        function displayFeaturedProducts(products) {
            const container = document.getElementById('featured-products');
            container.innerHTML = '';
            
            products.slice(0, 8).forEach(product => {
                const productCard = createProductCard(product);
                container.appendChild(productCard);
            });
        }
        
        function createProductCard(product) {
            const colDiv = document.createElement('div');
            colDiv.className = 'col-lg-3 col-md-4 col-sm-6 mb-4';
            
            colDiv.innerHTML = `
                <div class="card product-card h-100">
                                         <img src="${pageContext.request.contextPath}/resources/images/\${product.image || 'default-product.jpg'}" 
                          class="card-img-top" alt="\${product.name}">
                    <div class="card-body d-flex flex-column">
                        <h6 class="card-title">\${product.name}</h6>
                        <p class="card-text text-muted small">\${product.brand}</p>
                        <div class="mt-auto">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="h6 text-primary mb-0">\${formatCurrency(product.price)}</span>
                                <small class="text-muted">Còn \${product.stockQuantity}</small>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/cart" class="mt-2">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="\${product.id}">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit" class="btn btn-primary btn-sm w-100">
                                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            `;
            
            return colDiv;
        }
    </script>
</body>
</html>
