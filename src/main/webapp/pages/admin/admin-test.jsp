<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin URL Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Admin URL Test Page</h2>
        <div class="alert alert-info">
            <h4>Test URLs:</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products">Admin Products</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/settings">Admin Settings</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">Admin Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders">Admin Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/categories">Admin Categories</a></li>
            </ul>
        </div>
        
        <div class="alert alert-warning">
            <h4>Session Info:</h4>
            <p><strong>User:</strong> ${sessionScope.user != null ? sessionScope.user.username : 'Not logged in'}</p>
            <p><strong>Role:</strong> ${sessionScope.user != null ? sessionScope.user.role : 'N/A'}</p>
            <p><strong>Context Path:</strong> ${pageContext.request.contextPath}</p>
        </div>
        
        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Login</a>
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Home</a>
        </div>
    </div>
</body>
</html>
