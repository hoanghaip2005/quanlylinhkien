<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - Admin</title>
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
                    <h1 class="h2">Chi tiết đơn hàng #${order.id}</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/orders_new" class="btn btn-outline-secondary me-2">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateOrderModal">
                            <i class="fas fa-edit"></i> Cập nhật đơn hàng
                        </button>
                    </div>
                </div>
                
                <c:if test="${not empty order}">
                    <div class="row">
                        <!-- Order Information -->
                        <div class="col-lg-8">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Thông tin đơn hàng</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <strong>Mã đơn hàng:</strong> #${order.id}
                                            </div>
                                            <div class="mb-3">
                                                <strong>Khách hàng:</strong> ${order.customerName}
                                            </div>
                                            <div class="mb-3">
                                                <strong>Email:</strong> ${order.email}
                                            </div>
                                            <div class="mb-3">
                                                <strong>Số điện thoại:</strong> ${order.phone}
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <strong>Ngày đặt:</strong> 
                                                <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                            </div>
                                            <div class="mb-3">
                                                <strong>Trạng thái:</strong>
                                                <span class="badge ${order.status == 'PENDING' ? 'bg-warning' : 
                                                                   order.status == 'CONFIRMED' ? 'bg-info' :
                                                                   order.status == 'SHIPPING' ? 'bg-primary' :
                                                                   order.status == 'DELIVERED' ? 'bg-success' : 'bg-danger'}">
                                                    ${order.status == 'PENDING' ? 'Chờ xác nhận' :
                                                      order.status == 'CONFIRMED' ? 'Đã xác nhận' :
                                                      order.status == 'SHIPPING' ? 'Đang giao' :
                                                      order.status == 'DELIVERED' ? 'Đã giao' : 'Đã hủy'}
                                                </span>
                                            </div>
                                            <div class="mb-3">
                                                <strong>Thanh toán:</strong>
                                                <span class="badge ${order.paymentStatus == 'PAID' ? 'bg-success' : 
                                                                   order.paymentStatus == 'PENDING' ? 'bg-warning' : 'bg-danger'}">
                                                    ${order.paymentStatus == 'PAID' ? 'Đã thanh toán' : 
                                                      order.paymentStatus == 'PENDING' ? 'Chờ thanh toán' : 'Thất bại'}
                                                </span>
                                            </div>
                                            <div class="mb-3">
                                                <strong>Phương thức:</strong>
                                                <span class="badge ${order.paymentMethod == 'COD' ? 'bg-warning' : 'bg-info'}">
                                                    ${order.paymentMethod}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="mb-3">
                                                <strong>Địa chỉ giao hàng:</strong><br>
                                                ${order.shippingAddress}
                                            </div>
                                            <c:if test="${not empty order.notes}">
                                                <div class="mb-3">
                                                    <strong>Ghi chú:</strong><br>
                                                    ${order.notes}
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Order Items -->
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Sản phẩm đã đặt</h5>
                                </div>
                                <div class="card-body">
                                    <c:if test="${not empty orderItems}">
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Sản phẩm</th>
                                                        <th>Giá</th>
                                                        <th>Số lượng</th>
                                                        <th>Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="item" items="${orderItems}">
                                                        <tr>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <img src="${pageContext.request.contextPath}/resources/images/${item.productImage}" 
                                                                         class="img-thumbnail me-3" style="width: 60px; height: 60px; object-fit: cover;"
                                                                         alt="${item.productName}"
                                                                         onerror="this.src='${pageContext.request.contextPath}/resources/images/default-product.jpg'">
                                                                    <div>
                                                                        <strong>${item.productName}</strong><br>
                                                                        <small class="text-muted">ID: ${item.productId}</small>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <fmt:formatNumber value="${item.price}" pattern="#,###" />₫
                                                            </td>
                                                            <td>${item.quantity}</td>
                                                            <td>
                                                                <strong class="text-success">
                                                                    <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###" />₫
                                                                </strong>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                                <tfoot>
                                                    <tr class="table-active">
                                                        <th colspan="3">Tổng cộng:</th>
                                                        <th>
                                                            <strong class="text-success">
                                                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />₫
                                                            </strong>
                                                        </th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Order Actions -->
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Thao tác</h5>
                                </div>
                                <div class="card-body">
                                    <button class="btn btn-primary btn-sm w-100 mb-2" 
                                            data-bs-toggle="modal" data-bs-target="#updateOrderModal">
                                        <i class="fas fa-edit"></i> Cập nhật đơn hàng
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/users?action=view&id=${order.userId}" 
                                       class="btn btn-info btn-sm w-100 mb-2">
                                        <i class="fas fa-user"></i> Xem khách hàng
                                    </a>
                                    <button class="btn btn-success btn-sm w-100 mb-2" onclick="printOrder()">
                                        <i class="fas fa-print"></i> In đơn hàng
                                    </button>
                                </div>
                            </div>
                            
                            <div class="card mt-3">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Tóm tắt</h5>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Số sản phẩm:</span>
                                        <span>${orderItems.size()}</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Tổng số lượng:</span>
                                        <span>
                                            <c:set var="totalQuantity" value="0" />
                                            <c:forEach var="item" items="${orderItems}">
                                                <c:set var="totalQuantity" value="${totalQuantity + item.quantity}" />
                                            </c:forEach>
                                            ${totalQuantity}
                                        </span>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between">
                                        <strong>Tổng tiền:</strong>
                                        <strong class="text-success">
                                            <fmt:formatNumber value="${order.totalAmount}" pattern="#,###" />₫
                                        </strong>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${empty order}">
                    <div class="alert alert-warning">
                        <h4>Không tìm thấy đơn hàng</h4>
                        <p>Đơn hàng bạn đang tìm không tồn tại.</p>
                        <a href="${pageContext.request.contextPath}/admin/orders_new" class="btn btn-primary">
                            Quay lại danh sách
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- Update Order Modal -->
    <div class="modal fade" id="updateOrderModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cập nhật đơn hàng #${order.id}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/orders_new" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${order.id}">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="orderStatus" class="form-label">Trạng thái đơn hàng</label>
                            <select class="form-select" id="orderStatus" name="status">
                                <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>Chờ xác nhận</option>
                                <option value="CONFIRMED" ${order.status == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                                <option value="SHIPPING" ${order.status == 'SHIPPING' ? 'selected' : ''}>Đang giao</option>
                                <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>Đã giao</option>
                                <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="paymentStatus" class="form-label">Trạng thái thanh toán</label>
                            <select class="form-select" id="paymentStatus" name="paymentStatus">
                                <option value="PENDING" ${order.paymentStatus == 'PENDING' ? 'selected' : ''}>Chờ thanh toán</option>
                                <option value="PAID" ${order.paymentStatus == 'PAID' ? 'selected' : ''}>Đã thanh toán</option>
                                <option value="FAILED" ${order.paymentStatus == 'FAILED' ? 'selected' : ''}>Thất bại</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="orderNotes" class="form-label">Ghi chú</label>
                            <textarea class="form-control" id="orderNotes" name="notes" rows="3">${order.notes}</textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function printOrder() {
            window.print();
        }
    </script>
</body>
</html>
