<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.phutungxe.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Debug Admin Access</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h4>Debug Admin Access</h4>
            </div>
            <div class="card-body">
                <h5>Session Information:</h5>
                <ul>
                    <li><strong>Session ID:</strong> <%= session.getId() %></li>
                    <li><strong>User Object:</strong> <%= session.getAttribute("user") %></li>
                    <c:if test="${not empty sessionScope.user}">
                        <li><strong>User ID:</strong> ${sessionScope.user.id}</li>
                        <li><strong>Username:</strong> ${sessionScope.user.username}</li>
                        <li><strong>Email:</strong> ${sessionScope.user.email}</li>
                        <li><strong>Role:</strong> ${sessionScope.user.role}</li>
                        <li><strong>Role Check 1:</strong> ${"ADMIN".equals(sessionScope.user.role)}</li>
                        <li><strong>Role Check 2:</strong> ${"admin".equals(sessionScope.user.role)}</li>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <li><strong>User:</strong> NOT LOGGED IN</li>
                    </c:if>
                </ul>
                
                <h5>URL Parameters:</h5>
                <ul>
                    <li><strong>Action:</strong> ${param.action}</li>
                    <li><strong>ID:</strong> ${param.id}</li>
                    <li><strong>Context Path:</strong> ${pageContext.request.contextPath}</li>
                    <li><strong>Request URI:</strong> <%= request.getRequestURI() %></li>
                    <li><strong>Query String:</strong> <%= request.getQueryString() %></li>
                </ul>

                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary">Back to Products</a>
                    <a href="${pageContext.request.contextPath}/admin/products?action=simple&id=1" class="btn btn-success">Test Simple Edit ID=1</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
