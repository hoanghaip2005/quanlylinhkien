<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Session Debug</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h3>Session Information Debug</h3>
            </div>
            <div class="card-body">
                <h5>Current Session:</h5>
                <ul class="list-group">
                    <li class="list-group-item">
                        <strong>Session ID:</strong> ${pageContext.session.id}
                    </li>
                    <li class="list-group-item">
                        <strong>User Object:</strong> 
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                Found ✅
                            </c:when>
                            <c:otherwise>
                                <span class="text-danger">NULL ❌</span>
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <c:if test="${sessionScope.user != null}">
                        <li class="list-group-item">
                            <strong>Username:</strong> ${sessionScope.user.username}
                        </li>
                        <li class="list-group-item">
                            <strong>Role:</strong> 
                            <span class="badge ${sessionScope.user.role == 'ADMIN' ? 'bg-success' : 'bg-warning'}">
                                ${sessionScope.user.role}
                            </span>
                        </li>
                        <li class="list-group-item">
                            <strong>Full Name:</strong> ${sessionScope.user.fullName}
                        </li>
                        <li class="list-group-item">
                            <strong>Email:</strong> ${sessionScope.user.email}
                        </li>
                    </c:if>
                </ul>
                
                <hr>
                
                <h5>Admin Access Test:</h5>
                <c:choose>
                    <c:when test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                        <div class="alert alert-success">
                            ✅ <strong>Admin Access OK!</strong> Bạn có thể truy cập admin pages.
                        </div>
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary">
                                Test Admin Products
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/settings" class="btn btn-info">
                                Test Admin Settings
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-success">
                                Test Admin Dashboard
                            </a>
                        </div>
                    </c:when>
                    <c:when test="${sessionScope.user != null}">
                        <div class="alert alert-warning">
                            ⚠️ <strong>User logged in but NOT ADMIN!</strong> Role: ${sessionScope.user.role}
                        </div>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-warning">Logout</a>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Login as Admin</a>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger">
                            ❌ <strong>Not logged in!</strong> Please login first.
                        </div>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Login</a>
                    </c:otherwise>
                </c:choose>
                
                <hr>
                
                <h5>Quick Actions:</h5>
                <div class="btn-group" role="group">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">Home</a>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary">Login</a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-warning">Logout</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
