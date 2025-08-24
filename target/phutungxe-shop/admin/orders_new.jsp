<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .table-hover tbody tr:hover {
            background-color: #f8f9fa;
        }
        .status-badge {
            font-size: 0.8em;
            padding: 0.4em 0.8em;
        }
        .status-PENDING { background-color: #ffc107; color: #000; }
        .status-CONFIRMED { background-color: #17a2b8; color: #fff; }
        .status-SHIPPING { background-color: #fd7e14; color: #fff; }
        .status-DELIVERED { background-color: #28a745; color: #fff; }
        .status-CANCELLED { background-color: #dc3545; color: #fff; }
        .card {
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            border: 1px solid rgba(0, 0, 0, 0.125);
        }
        .btn-sm {
            font-size: 0.8rem;
            padding: 0.25rem 0.5rem;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar">
                <div class="p-3">
                    <h5 class="text-white">
                        <i class="fas fa-motorcycle me-2"></i>
                        Admin Panel
                    </h5>
                    <hr class="text-white">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/products">
                                <i class="fas fa-box me-2"></i>Sản phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white active bg-white bg-opacity-25" href="${pageContext.request.contextPath}/admin/orders_new">
                                <i class="fas fa-shopping-cart me-2"></i>Đơn hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users me-2"></i>Người dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="fas fa-tags me-2"></i>Danh mục
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-10">
                <div class="p-4">
                    <!-- Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2><i class="fas fa-shopping-cart me-2 text-primary"></i>Quản lý Đơn hàng</h2>
                        <div>
                            <span class="text-muted">Tổng cộng: <strong>${orders.size()}</strong> đơn hàng</span>
                        </div>
                    </div>

                    <!-- Alerts -->
                    <c:if test="${not empty sessionScope.message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${sessionScope.message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="message" scope="session"/>
                    </c:if>
                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="error" scope="session"/>
                    </c:if>

                    <!-- Orders Table -->
                    <div class="card">
                        <div class="card-header bg-white">
                            <h5 class="mb-0">
                                <i class="fas fa-list me-2"></i>Danh sách Đơn hàng
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <div class="text-center py-5">
                                        <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Chưa có đơn hàng nào</h5>
                                        <p class="text-muted">Đơn hàng sẽ xuất hiện tại đây khi khách hàng đặt mua.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Khách hàng</th>
                                                    <th>Ngày đặt</th>
                                                    <th>Tổng tiền</th>
                                                    <th>Trạng thái</th>
                                                    <th>Địa chỉ giao hàng</th>
                                                    <th class="text-center">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <td>
                                                            <strong>#${order.id}</strong>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <strong>${order.fullName}</strong>
                                                                <br>
                                                                <small class="text-muted">${order.phone}</small>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                        </td>
                                                        <td>
                                                            <strong class="text-success">
                                                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                            </strong>
                                                        </td>
                                                        <td>
                                                            <span class="badge status-badge status-${order.status}">
                                                                <c:choose>
                                                                    <c:when test="${order.status == 'PENDING'}">Chờ xử lý</c:when>
                                                                    <c:when test="${order.status == 'CONFIRMED'}">Đã xác nhận</c:when>
                                                                    <c:when test="${order.status == 'SHIPPING'}">Đang giao</c:when>
                                                                    <c:when test="${order.status == 'DELIVERED'}">Đã giao</c:when>
                                                                    <c:when test="${order.status == 'CANCELLED'}">Đã hủy</c:when>
                                                                    <c:otherwise>${order.status}</c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <small>${order.shippingAddress}</small>
                                                        </td>
                                                        <td class="text-center">
                                                            <div class="btn-group" role="group">
                                                                <!-- Update Status Button -->
                                                                <button type="button" class="btn btn-sm btn-outline-primary" 
                                                                        data-bs-toggle="modal" 
                                                                        data-bs-target="#updateStatusModal" 
                                                                        data-order-id="${order.id}"
                                                                        data-current-status="${order.status}"
                                                                        data-order-info="#${order.id} - ${order.fullName}">
                                                                    <i class="fas fa-edit"></i> Sửa
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Status Modal -->
    <div class="modal fade" id="updateStatusModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-edit me-2"></i>Cập nhật Trạng thái Đơn hàng
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/admin/orders_new">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="orderId" id="modalOrderId">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Đơn hàng:</label>
                            <p class="text-muted" id="modalOrderInfo"></p>
                        </div>
                        
                        <div class="mb-3">
                            <label for="modalStatus" class="form-label fw-bold">Trạng thái mới:</label>
                            <select class="form-select" name="status" id="modalStatus" required>
                                <option value="PENDING">Chờ xử lý</option>
                                <option value="CONFIRMED">Đã xác nhận</option>
                                <option value="SHIPPING">Đang giao hàng</option>
                                <option value="DELIVERED">Đã giao hàng</option>
                                <option value="CANCELLED">Đã hủy</option>
                            </select>
                        </div>
                        
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Lưu ý:</strong> Việc thay đổi trạng thái đơn hàng sẽ ảnh hưởng đến quy trình xử lý đơn hàng.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Hủy
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Cập nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Handle update status modal
        document.addEventListener('DOMContentLoaded', function() {
            const updateModal = document.getElementById('updateStatusModal');
            updateModal.addEventListener('show.bs.modal', function(event) {
                const button = event.relatedTarget;
                const orderId = button.getAttribute('data-order-id');
                const currentStatus = button.getAttribute('data-current-status');
                const orderInfo = button.getAttribute('data-order-info');
                
                // Update modal content
                document.getElementById('modalOrderId').value = orderId;
                document.getElementById('modalOrderInfo').textContent = orderInfo;
                document.getElementById('modalStatus').value = currentStatus;
            });
        });
    </script>
</body>
</html>
