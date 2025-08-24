<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Debug Order</title>
</head>
<body>
    <h2>Debug Order Servlet</h2>
    
    <h3>Session Info:</h3>
    <p>User: ${sessionScope.user}</p>
    <p>User ID: ${sessionScope.user.id}</p>
    <p>Username: ${sessionScope.user.username}</p>
    
    <h3>Test Links:</h3>
    <a href="${pageContext.request.contextPath}/order">Order Default</a><br/>
    <a href="${pageContext.request.contextPath}/order?action=checkout">Order Checkout</a><br/>
    <a href="${pageContext.request.contextPath}/order?action=history">Order History</a><br/>
    <strong><a href="${pageContext.request.contextPath}/order-history">Simple Order History (NEW)</a></strong><br/>
    
    <h3>Context Path:</h3>
    <p>${pageContext.request.contextPath}</p>
</body>
</html>
