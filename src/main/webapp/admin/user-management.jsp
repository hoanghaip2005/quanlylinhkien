<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - Admin</title>
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
                    <h1 class="h2">Quản lý người dùng</h1>
                </div>
                
                <!-- Success/Error Messages -->
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${sessionScope.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>
                
                <!-- Search and Filter -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <form action="${pageContext.request.contextPath}/admin/users" method="get" class="d-flex">
                            <input class="form-control me-2" type="search" name="search" 
                                   placeholder="Tìm kiếm theo tên, email..." value="${search}">
                            <button class="btn btn-outline-secondary" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" onchange="filterByRole(this.value)">
                            <option value="">Tất cả vai trò</option>
                            <option value="USER" ${selectedRole == 'USER' ? 'selected' : ''}>User</option>
                            <option value="ADMIN" ${selectedRole == 'ADMIN' ? 'selected' : ''}>Admin</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" onchange="filterByStatus(this.value)">
                            <option value="">Tất cả trạng thái</option>
                            <option value="ACTIVE" ${selectedStatus == 'ACTIVE' ? 'selected' : ''}>Hoạt động</option>
                            <option value="INACTIVE" ${selectedStatus == 'INACTIVE' ? 'selected' : ''}>Ngưng hoạt động</option>
                        </select>
                    </div>
                </div>
                
                <!-- Users Table -->
                <div class="card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty users}">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên đăng nhập</th>
                                                <th>Email</th>
                                                <th>Họ tên</th>
                                                <th>Số điện thoại</th>
                                                <th>Vai trò</th>
                                                <th>Trạng thái</th>
                                                <th>Ngày tạo</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="user" items="${users}">
                                                <tr>
                                                    <td>${user.id}</td>
                                                    <td><strong>${user.username}</strong></td>
                                                    <td>${user.email}</td>
                                                    <td>${user.fullName}</td>
                                                    <td>${user.phone}</td>
                                                    <td>
                                                        <span class="badge ${user.role == 'ADMIN' ? 'bg-danger' : 'bg-primary'}">
                                                            ${user.role}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="badge ${user.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'}">
                                                            ${user.status == 'ACTIVE' ? 'Hoạt động' : 'Ngưng hoạt động'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="${pageContext.request.contextPath}/admin/users?action=view&id=${user.id}" 
                                                               class="btn btn-sm btn-outline-info" title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/admin/users?action=simple&id=${user.id}" 
                                                               class="btn btn-sm btn-outline-primary" title="Sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <c:if test="${sessionScope.user.id != user.id}">
                                                                <form style="display: inline;" method="post" action="${pageContext.request.contextPath}/admin/users" 
                                                                      onsubmit="return confirm('XÓA VĨNH VIỄN người dùng \'${fn:escapeXml(user.username)}\'? Hành động này KHÔNG THỂ hoàn tác!')">
                                                                    <input type="hidden" name="action" value="delete">
                                                                    <input type="hidden" name="id" value="${user.id}">
                                                                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Xóa vĩnh viễn">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                    <h5>Không tìm thấy người dùng</h5>
                                    <p class="text-muted">Thử thay đổi bộ lọc hoặc thêm người dùng mới</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterByRole(role) {
            const url = new URL(window.location.href);
            if (role) {
                url.searchParams.set('role', role);
            } else {
                url.searchParams.delete('role');
            }
            window.location.href = url.toString();
        }
        
        function filterByStatus(status) {
            const url = new URL(window.location.href);
            if (status) {
                url.searchParams.set('status', status);
            } else {
                url.searchParams.delete('status');
            }
            window.location.href = url.toString();
        }
    </script>
</body>
</html>
