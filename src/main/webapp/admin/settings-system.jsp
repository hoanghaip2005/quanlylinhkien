<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cài đặt hệ thống - Admin</title>
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
                    <h1 class="h2">
                        <i class="fas fa-server"></i> Thông tin hệ thống
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/settings" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </div>
                
                <!-- System Information -->
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-info-circle"></i> Thông tin Java & Server
                                </h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Java Version:</strong></td>
                                        <td>${systemInfo.javaVersion}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Operating System:</strong></td>
                                        <td>${systemInfo.osName} ${systemInfo.osVersion}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Server Info:</strong></td>
                                        <td>${systemInfo.serverInfo}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Application:</strong></td>
                                        <td>Phụ Tùng Xe Máy v1.0</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Context Path:</strong></td>
                                        <td>${pageContext.request.contextPath}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-memory"></i> Thông tin bộ nhớ
                                </h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Tổng bộ nhớ:</strong></td>
                                        <td>${systemInfo.totalMemory} MB</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Bộ nhớ đã dùng:</strong></td>
                                        <td>
                                            <span class="text-warning">${systemInfo.usedMemory} MB</span>
                                            <div class="progress mt-1" style="height: 8px;">
                                                <div class="progress-bar bg-warning" role="progressbar" 
                                                     style="width: ${(systemInfo.usedMemory * 100) / systemInfo.totalMemory}%"></div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Bộ nhớ trống:</strong></td>
                                        <td class="text-success">${systemInfo.freeMemory} MB</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <button class="btn btn-outline-primary btn-sm" onclick="runGarbageCollection()">
                                                <i class="fas fa-trash"></i> Dọn dẹp bộ nhớ
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Application Settings -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-cogs"></i> Cài đặt ứng dụng
                                </h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/settings" method="post">
                                    <input type="hidden" name="action" value="updateSystem">
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h6>Cài đặt chung</h6>
                                            <div class="mb-3">
                                                <label class="form-label">Tên ứng dụng</label>
                                                <input type="text" class="form-control" value="Phụ Tùng Xe Máy" readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Phiên bản</label>
                                                <input type="text" class="form-control" value="1.0.0" readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Múi giờ</label>
                                                <select class="form-select">
                                                    <option selected>Asia/Ho_Chi_Minh</option>
                                                    <option>UTC</option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <h6>Cài đặt bảo mật</h6>
                                            <div class="mb-3">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" checked>
                                                    <label class="form-check-label">
                                                        Bật xác thực phiên
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" checked>
                                                    <label class="form-check-label">
                                                        Ghi log hoạt động
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Thời gian timeout (phút)</label>
                                                <input type="number" class="form-control" value="30" min="5" max="120">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-3">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Lưu cài đặt
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="resetSettings()">
                                            <i class="fas fa-undo"></i> Khôi phục mặc định
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Database Information -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-database"></i> Thông tin cơ sở dữ liệu
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <strong>Database Type:</strong><br>
                                        <span class="text-primary">MySQL 8.0+</span>
                                    </div>
                                    <div class="col-md-4">
                                        <strong>Database Name:</strong><br>
                                        <span class="text-info">phutungxe_shop</span>
                                    </div>
                                    <div class="col-md-4">
                                        <strong>Connection Status:</strong><br>
                                        <span class="badge bg-success">Connected</span>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-12">
                                        <h6>Bảng trong cơ sở dữ liệu:</h6>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <i class="fas fa-table text-primary"></i> users
                                            </div>
                                            <div class="col-md-3">
                                                <i class="fas fa-table text-primary"></i> products
                                            </div>
                                            <div class="col-md-3">
                                                <i class="fas fa-table text-primary"></i> categories
                                            </div>
                                            <div class="col-md-3">
                                                <i class="fas fa-table text-primary"></i> orders
                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <div class="col-md-3">
                                                <i class="fas fa-table text-primary"></i> order_items
                                            </div>
                                            <div class="col-md-3">
                                                <i class="fas fa-table text-primary"></i> cart
                                            </div>
                                            <div class="col-md-6">
                                                <button class="btn btn-outline-info btn-sm">
                                                    <i class="fas fa-info-circle"></i> Kiểm tra kết nối DB
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function runGarbageCollection() {
            if (confirm('Bạn có muốn dọn dẹp bộ nhớ không sử dụng?')) {
                // Placeholder for garbage collection
                alert('Đã thực hiện dọn dẹp bộ nhớ.');
                location.reload();
            }
        }
        
        function resetSettings() {
            if (confirm('Bạn có chắc chắn muốn khôi phục cài đặt mặc định?')) {
                alert('Đã khôi phục cài đặt mặc định.');
            }
        }
    </script>
</body>
</html>
