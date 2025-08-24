<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center py-3 border-bottom">
                    <h2><i class="fas fa-shopping-cart text-primary"></i> Quản Lý Đơn Hàng</h2>
                    <div>
                        <span class="badge bg-info me-2">${currentUser.username}</span>
                        <span class="badge bg-primary me-2">${currentUser.role}</span>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm ms-2">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </div>
                </div>

                <!-- Quick Stats -->
                <div class="row my-3">
                    <div class="col-md-3">
                        <div class="card text-center bg-primary text-white">
                            <div class="card-body">
                                <h4>${orders.size()}</h4>
                                <small>Tổng đơn hàng</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center bg-warning text-dark">
                            <div class="card-body">
                                <h4>
                                    <c:set var="pendingCount" value="0"/>
                                    <c:forEach var="order" items="${orders}">
                                        <c:if test="${order.status == 'PENDING'}">
                                            <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${pendingCount}
                                </h4>
                                <small>Chờ xác nhận</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center bg-info text-white">
                            <div class="card-body">
                                <h4>
                                    <c:set var="processingCount" value="0"/>
                                    <c:forEach var="order" items="${orders}">
                                        <c:if test="${order.status == 'CONFIRMED' || order.status == 'SHIPPED'}">
                                            <c:set var="processingCount" value="${processingCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${processingCount}
                                </h4>
                                <small>Đang xử lý</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center bg-success text-white">
                            <div class="card-body">
                                <h4>
                                    <c:set var="completedCount" value="0"/>
                                    <c:forEach var="order" items="${orders}">
                                        <c:if test="${order.status == 'DELIVERED'}">
                                            <c:set var="completedCount" value="${completedCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${completedCount}
                                </h4>
                                <small>Hoàn thành</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Orders Table -->
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-list"></i> Danh sách đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty orders}">
                            <div class="alert alert-info text-center">
                                <i class="fas fa-info-circle"></i> Chưa có đơn hàng nào trong hệ thống.
                            </div>
                        </c:if>

                        <c:if test="${not empty orders}">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Mã ĐH</th>
                                            <th>Khách hàng</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Ngày tạo</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${orders}">
                                            <tr>
                                                <td><strong>#${order.id}</strong></td>
                                                <td>
                                                    <strong>${order.userName}</strong><br>
                                                    <small class="text-muted">${order.phone}</small>
                                                </td>
                                                <td class="text-success fw-bold">
                                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                </td>
                                                <td>
                                                    <span class="badge 
                                                        <c:choose>
                                                            <c:when test='${order.status == "PENDING"}'>bg-warning text-dark</c:when>
                                                            <c:when test='${order.status == "CONFIRMED"}'>bg-info</c:when>
                                                            <c:when test='${order.status == "SHIPPED"}'>bg-primary</c:when>
                                                            <c:when test='${order.status == "DELIVERED"}'>bg-success</c:when>
                                                            <c:when test='${order.status == "CANCELLED"}'>bg-danger</c:when>
                                                            <c:otherwise>bg-secondary</c:otherwise>
                                                        </c:choose>">
                                                        <c:choose>
                                                            <c:when test='${order.status == "PENDING"}'>Chờ xác nhận</c:when>
                                                            <c:when test='${order.status == "CONFIRMED"}'>Đã xác nhận</c:when>
                                                            <c:when test='${order.status == "SHIPPED"}'>Đang giao</c:when>
                                                            <c:when test='${order.status == "DELIVERED"}'>Đã giao</c:when>
                                                            <c:when test='${order.status == "CANCELLED"}'>Đã hủy</c:when>
                                                            <c:otherwise>${order.status}</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-primary btn-sm" 
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#statusModal${order.id}">
                                                        <i class="fas fa-edit"></i> Sửa
                                                    </button>
                                                    <button type="button" class="btn btn-info btn-sm"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#viewModal${order.id}">
                                                        <i class="fas fa-eye"></i> Xem
                                                    </button>
                                                </td>
                                            </tr>

                                            <!-- Status Update Modal -->
                                            <div class="modal fade" id="statusModal${order.id}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Cập nhật trạng thái đơn hàng #${order.id}</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <form method="post" action="${pageContext.request.contextPath}/admin/simple-orders">
                                                            <div class="modal-body">
                                                                <input type="hidden" name="action" value="updateStatus">
                                                                <input type="hidden" name="orderId" value="${order.id}">
                                                                
                                                                <div class="mb-3">
                                                                    <label class="form-label">Khách hàng:</label>
                                                                    <div><strong>${order.userName}</strong> - ${order.phone}</div>
                                                                </div>
                                                                
                                                                <div class="mb-3">
                                                                    <label class="form-label">Tổng tiền:</label>
                                                                    <div class="text-success fw-bold">
                                                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                                    </div>
                                                                </div>
                                                                
                                                                <div class="mb-3">
                                                                    <label for="status${order.id}" class="form-label">Trạng thái mới:</label>
                                                                    <select class="form-select" id="status${order.id}" name="status" required>
                                                                        <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>Chờ xác nhận</option>
                                                                        <option value="CONFIRMED" ${order.status == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                                                                        <option value="SHIPPED" ${order.status == 'SHIPPED' ? 'selected' : ''}>Đang giao hàng</option>
                                                                        <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>Đã giao hàng</option>
                                                                        <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                                                                    </select>
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

                                            <!-- View Details Modal -->
                                            <div class="modal fade" id="viewModal${order.id}" tabindex="-1">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Chi tiết đơn hàng #${order.id}</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <h6>Thông tin khách hàng:</h6>
                                                                    <p><strong>Tên:</strong> ${order.userName}</p>
                                                                    <p><strong>Điện thoại:</strong> ${order.phone}</p>
                                                                    <p><strong>Email:</strong> ${order.userEmail}</p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <h6>Thông tin đơn hàng:</h6>
                                                                    <p><strong>Mã đơn:</strong> #${order.id}</p>
                                                                    <p><strong>Tổng tiền:</strong> 
                                                                        <span class="text-success">
                                                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                                        </span>
                                                                    </p>
                                                                    <p><strong>Trạng thái:</strong> 
                                                                        <span class="badge bg-primary">${order.status}</span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <hr>
                                                            <h6>Địa chỉ giao hàng:</h6>
                                                            <p>${order.shippingAddress}</p>
                                                            
                                                            <c:if test="${not empty order.notes}">
                                                                <h6>Ghi chú:</h6>
                                                                <p>${order.notes}</p>
                                                            </c:if>
                                                            
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <small><strong>Ngày tạo:</strong> 
                                                                        <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                                    </small>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <small><strong>Cập nhật:</strong> 
                                                                        <fmt:formatDate value="${order.updatedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                                    </small>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
