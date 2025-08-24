// JavaScript for Phu Tung Xe Shop

// Global variables
let cart = [];

// Document ready
document.addEventListener('DOMContentLoaded', function() {
    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Update cart count on page load
    updateCartCount();
    
    // Add loading animation to forms
    addFormLoadingAnimation();
});

// Cart functions
function addToCart(productId, quantity = 1, callback = null) {
    console.log('addToCart called with productId:', productId, 'quantity:', quantity);
    
    const formData = new FormData();
    formData.append('action', 'add');
    formData.append('productId', productId);
    formData.append('quantity', quantity);
    
    console.log('Sending request to /phutungxe-shop/cart');
    
    fetch('/phutungxe-shop/cart', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        console.log('Response status:', response.status);
        return response.json();
    })
    .then(data => {
        console.log('Response data:', data);
        if (data.success) {
            alert('Đã thêm sản phẩm vào giỏ hàng!');
            if (callback && typeof callback === 'function') {
                callback();
            }
        } else {
            alert('Lỗi: ' + (data.message || 'Không thể thêm vào giỏ hàng'));
        }
    })
    .catch(error => {
        console.error('Fetch error:', error);
        alert('Có lỗi xảy ra: ' + error.message);
    });
}

function updateCartItem(productId, quantity) {
    const formData = new FormData();
    formData.append('action', 'update');
    formData.append('productId', productId);
    formData.append('quantity', quantity);
    
    fetch('/phutungxe-shop/cart', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            location.reload();
        } else {
            alert('Lỗi: ' + (data.message || 'Không thể cập nhật'));
        }
    })
    .catch(error => {
        alert('Có lỗi xảy ra: ' + error.message);
    });
}

function removeFromCart(productId) {
    if (!confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
        return;
    }
    
    const formData = new FormData();
    formData.append('action', 'remove');
    formData.append('productId', productId);
    
    fetch('/phutungxe-shop/cart', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Đã xóa sản phẩm!');
            location.reload();
        } else {
            alert('Lỗi: ' + (data.message || 'Không thể xóa'));
        }
    })
    .catch(error => {
        alert('Có lỗi xảy ra: ' + error.message);
    });
}

function clearCart() {
    if (!confirm('Bạn có chắc muốn xóa tất cả sản phẩm trong giỏ hàng?')) {
        return;
    }
    
    const formData = new FormData();
    formData.append('action', 'clear');
    
    fetch('/phutungxe-shop/cart', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Đã xóa tất cả sản phẩm!');
            location.reload();
        } else {
            alert('Lỗi: ' + (data.message || 'Không thể xóa'));
        }
    })
    .catch(error => {
        alert('Có lỗi xảy ra: ' + error.message);
    });
}

function updateCartCount(count = null) {
    const cartCountElement = document.getElementById('cart-count');
    if (!cartCountElement) return;
    
    if (count !== null) {
        cartCountElement.textContent = count;
        return;
    }
    
    // Fetch current cart count
    fetch('/phutungxe-shop/cart?action=count')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                cartCountElement.textContent = data.data.cartCount;
            }
        })
        .catch(error => console.error('Error:', error));
}

// Utility functions
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount).replace('₫', 'VNĐ');
}

function isUserLoggedIn() {
    return true; // Bỏ check đăng nhập tạm thời
}

function showLoginModal() {
    const modal = document.getElementById('loginModal');
    if (modal) {
        const bsModal = new bootstrap.Modal(modal);
        bsModal.show();
    } else {
        // Redirect to login page if modal doesn't exist
        window.location.href = '/phutungxe-shop/login';
    }
}

function showNotification(type, message) {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `alert alert-${type === 'success' ? 'success' : 'danger'} alert-dismissible fade show position-fixed`;
    notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
    
    notification.innerHTML = `
        <i class="fas fa-${type === 'success' ? 'check-circle' : 'exclamation-circle'} me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    document.body.appendChild(notification);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        notification.remove();
    }, 5000);
}

function addFormLoadingAnimation() {
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function() {
            const submitBtn = form.querySelector('button[type="submit"]');
            if (submitBtn) {
                submitBtn.disabled = true;
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = `
                    <span class="spinner-border spinner-border-sm me-2" role="status"></span>
                    Đang xử lý...
                `;
                
                // Re-enable button after 10 seconds (fallback)
                setTimeout(() => {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalText;
                }, 10000);
            }
        });
    });
}

// Product filter and search functions
function filterProducts(categoryId) {
    window.location.href = `/phutungxe-shop/products?action=category&categoryId=${categoryId}`;
}

function searchProducts(keyword) {
    if (keyword.trim() === '') {
        showNotification('error', 'Vui lòng nhập từ khóa tìm kiếm');
        return;
    }
    
    window.location.href = `/phutungxe-shop/products?action=search&keyword=${encodeURIComponent(keyword)}`;
}

// Quantity input controls
function increaseQuantity(inputId) {
    const input = document.getElementById(inputId);
    if (input) {
        const currentValue = parseInt(input.value) || 1;
        const maxValue = parseInt(input.getAttribute('max')) || 999;
        if (currentValue < maxValue) {
            input.value = currentValue + 1;
            input.dispatchEvent(new Event('change'));
        }
    }
}

function decreaseQuantity(inputId) {
    const input = document.getElementById(inputId);
    if (input) {
        const currentValue = parseInt(input.value) || 1;
        const minValue = parseInt(input.getAttribute('min')) || 1;
        if (currentValue > minValue) {
            input.value = currentValue - 1;
            input.dispatchEvent(new Event('change'));
        }
    }
}

// Image lazy loading
function lazyLoadImages() {
    const images = document.querySelectorAll('img[data-src]');
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.classList.remove('lazy');
                imageObserver.unobserve(img);
            }
        });
    });
    
    images.forEach(img => imageObserver.observe(img));
}

// Initialize lazy loading if images exist
if (document.querySelectorAll('img[data-src]').length > 0) {
    lazyLoadImages();
}

// Admin functions
function confirmDelete(message = 'Bạn có chắc muốn xóa?') {
    return confirm(message);
}

function updateOrderStatus(orderId, status) {
    if (!confirm('Bạn có chắc muốn thay đổi trạng thái đơn hàng?')) {
        return;
    }
    
    const formData = new FormData();
    formData.append('action', 'updateStatus');
    formData.append('orderId', orderId);
    formData.append('status', status);
    
    fetch('/phutungxe-shop/admin/orders', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('success', 'Cập nhật trạng thái thành công');
            location.reload();
        } else {
            showNotification('error', data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('error', 'Có lỗi xảy ra khi cập nhật trạng thái');
    });
}

// Form validation
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return true;
    
    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;
    
    requiredFields.forEach(field => {
        if (!field.value.trim()) {
            field.classList.add('is-invalid');
            isValid = false;
        } else {
            field.classList.remove('is-invalid');
        }
    });
    
    return isValid;
}

// Smooth scroll to top
function scrollToTop() {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
}

// Add scroll to top button
document.addEventListener('DOMContentLoaded', function() {
    // Create scroll to top button
    const scrollBtn = document.createElement('button');
    scrollBtn.innerHTML = '<i class="fas fa-chevron-up"></i>';
    scrollBtn.className = 'btn btn-primary position-fixed';
    scrollBtn.style.cssText = 'bottom: 20px; right: 20px; z-index: 1000; border-radius: 50%; width: 50px; height: 50px; display: none;';
    scrollBtn.onclick = scrollToTop;
    document.body.appendChild(scrollBtn);
    
    // Show/hide scroll button based on scroll position
    window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
            scrollBtn.style.display = 'block';
        } else {
            scrollBtn.style.display = 'none';
        }
    });
});

// Export functions for global use
window.addToCart = addToCart;
window.updateCartItem = updateCartItem;
window.removeFromCart = removeFromCart;
window.clearCart = clearCart;
window.formatCurrency = formatCurrency;
window.showNotification = showNotification;
window.increaseQuantity = increaseQuantity;
window.decreaseQuantity = decreaseQuantity;
window.confirmDelete = confirmDelete;
window.updateOrderStatus = updateOrderStatus;
window.filterProducts = filterProducts;
window.searchProducts = searchProducts;
