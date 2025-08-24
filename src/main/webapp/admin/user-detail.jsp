<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết người dùng - Admin</title>
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
                    <h1 class="h2">Chi tiết người dùng</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary me-2">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${user.id}" class="btn btn-primary">
                            <i class="fas fa-edit"></i> Chỉnh sửa
                        </a>
                    </div>
                </div>
                
                <c:if test="${not empty user}">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Thông tin cá nhân</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>ID:</strong></div>
                                        <div class="col-sm-9">${user.id}</div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Tên đăng nhập:</strong></div>
                                        <div class="col-sm-9">${user.username}</div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Email:</strong></div>
                                        <div class="col-sm-9">${user.email}</div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Họ tên:</strong></div>
                                        <div class="col-sm-9">${user.fullName}</div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Số điện thoại:</strong></div>
                                        <div class="col-sm-9">${user.phone}</div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Địa chỉ:</strong></div>
                                        <div class="col-sm-9">${user.address}</div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Vai trò:</strong></div>
                                        <div class="col-sm-9">
                                            <span class="badge ${user.role == 'ADMIN' ? 'bg-danger' : 'bg-primary'} fs-6">
                                                ${user.role}
                                            </span>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Trạng thái:</strong></div>
                                        <div class="col-sm-9">
                                            <span class="badge ${user.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'} fs-6">
                                                ${user.status == 'ACTIVE' ? 'Hoạt động' : 'Ngưng hoạt động'}
                                            </span>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Ngày tạo:</strong></div>
                                        <div class="col-sm-9">
                                            <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Cập nhật lần cuối:</strong></div>
                                        <div class="col-sm-9">
                                            <fmt:formatDate value="${user.updatedAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Thống kê hoạt động</h5>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span>Tổng số đơn hàng:</span>
                                        <span class="badge bg-primary">${orderCount != null ? orderCount : 0}</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span>Tổng giá trị mua:</span>
                                        <span class="text-success fw-bold">
                                            <fmt:formatNumber value="${totalSpent != null ? totalSpent : 0}" pattern="#,###" />₫
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span>Đơn hàng hoàn thành:</span>
                                        <span class="badge bg-success">${completedOrders != null ? completedOrders : 0}</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span>Đơn hàng đang xử lý:</span>
                                        <span class="badge bg-warning">${pendingOrders != null ? pendingOrders : 0}</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card mt-3">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Thao tác</h5>
                                </div>
                                <div class="card-body">
                                    <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${user.id}" 
                                       class="btn btn-primary btn-sm w-100 mb-2">
                                        <i class="fas fa-edit"></i> Chỉnh sửa thông tin
                                    </a>
                                    <c:if test="${sessionScope.user.id != user.id}">
                                        <c:choose>
                                            <c:when test="${user.status == 'ACTIVE'}">
                                                <button class="btn btn-warning btn-sm w-100 mb-2" 
                                                        onclick="toggleUserStatus(${user.id}, 'inactive')">
                                                    <i class="fas fa-ban"></i> Vô hiệu hóa
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-success btn-sm w-100 mb-2" 
                                                        onclick="toggleUserStatus(${user.id}, 'active')">
                                                    <i class="fas fa-check"></i> Kích hoạt
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/admin/orders_new?userId=${user.id}" 
                                       class="btn btn-info btn-sm w-100">
                                        <i class="fas fa-shopping-cart"></i> Xem đơn hàng
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${empty user}">
                    <div class="alert alert-warning">
                        <h4>Không tìm thấy người dùng</h4>
                        <p>Người dùng bạn đang tìm không tồn tại hoặc đã bị xóa.</p>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary">
                            Quay lại danh sách
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleUserStatus(userId, newStatus) {
            const message = newStatus === 'ACTIVE' ? 'kích hoạt' : 'vô hiệu hóa';
            if (confirm('Bạn có chắc chắn muốn ' + message + ' người dùng này?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/users?action=updateStatus&id=' + userId + '&status=' + newStatus;
            }
        }
    </script>
</body>
</html>
