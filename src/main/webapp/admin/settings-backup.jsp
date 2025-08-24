<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sao lưu dữ liệu - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
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
                        <i class="fas fa-download"></i> Sao lưu & Khôi phục
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/settings" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </div>
                
                <!-- Success Messages -->
                <c:if test="${param.success eq 'completed'}">
                    <div class="alert alert-success alert-dismissible fade show">
                        Sao lưu dữ liệu thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <div class="row">
                    <!-- Backup Section -->
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-download"></i> Tạo bản sao lưu
                                </h5>
                            </div>
                            <div class="card-body">
                                <p>Tạo bản sao lưu toàn bộ dữ liệu hệ thống bao gồm:</p>
                                <ul>
                                    <li>Danh sách người dùng</li>
                                    <li>Thông tin sản phẩm</li>
                                    <li>Danh mục sản phẩm</li>
                                    <li>Đơn hàng và chi tiết</li>
                                    <li>Cài đặt hệ thống</li>
                                </ul>
                                
                                <form action="${pageContext.request.contextPath}/admin/settings" method="post">
                                    <input type="hidden" name="action" value="backup">
                                    
                                    <div class="mb-3">
                                        <label for="backupType" class="form-label">Loại sao lưu</label>
                                        <select class="form-select" id="backupType" name="backupType">
                                            <option value="full">Sao lưu toàn bộ</option>
                                            <option value="data">Chỉ dữ liệu</option>
                                            <option value="settings">Chỉ cài đặt</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="backupName" class="form-label">Tên file sao lưu</label>
                                        <input type="text" class="form-control" id="backupName" name="backupName" 
                                               value="backup_<fmt:formatDate value='<%=new java.util.Date()%>' pattern='yyyyMMdd_HHmmss'/>" readonly>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="includeImages" name="includeImages" checked>
                                            <label class="form-check-label" for="includeImages">
                                                Bao gồm hình ảnh sản phẩm
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-download"></i> Tạo sao lưu
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Restore Section -->
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-upload"></i> Khôi phục dữ liệu
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    <strong>Cảnh báo:</strong> Khôi phục dữ liệu sẽ ghi đè lên dữ liệu hiện tại. 
                                    Hãy tạo bản sao lưu trước khi thực hiện.
                                </div>
                                
                                <form action="${pageContext.request.contextPath}/admin/settings" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="restore">
                                    
                                    <div class="mb-3">
                                        <label for="backupFile" class="form-label">Chọn file sao lưu</label>
                                        <input type="file" class="form-control" id="backupFile" name="backupFile" 
                                               accept=".sql,.zip,.tar.gz" required>
                                        <div class="form-text">Chấp nhận file .sql, .zip, .tar.gz</div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="confirmRestore" required>
                                            <label class="form-check-label" for="confirmRestore">
                                                Tôi hiểu rằng việc này sẽ ghi đè dữ liệu hiện tại
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-warning">
                                        <i class="fas fa-upload"></i> Khôi phục dữ liệu
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Backup History -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-history"></i> Lịch sử sao lưu
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Tên file</th>
                                                <th>Loại</th>
                                                <th>Kích thước</th>
                                                <th>Ngày tạo</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>backup_20250820_143000.sql</td>
                                                <td><span class="badge bg-primary">Toàn bộ</span></td>
                                                <td>2.4 MB</td>
                                                <td>20/08/2025 14:30</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary" onclick="downloadBackup('backup_20250820_143000.sql')">
                                                        <i class="fas fa-download"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger" onclick="deleteBackup('backup_20250820_143000.sql')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>backup_20250819_093000.sql</td>
                                                <td><span class="badge bg-info">Dữ liệu</span></td>
                                                <td>1.8 MB</td>
                                                <td>19/08/2025 09:30</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary" onclick="downloadBackup('backup_20250819_093000.sql')">
                                                        <i class="fas fa-download"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger" onclick="deleteBackup('backup_20250819_093000.sql')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>backup_20250818_160000.sql</td>
                                                <td><span class="badge bg-success">Cài đặt</span></td>
                                                <td>0.2 MB</td>
                                                <td>18/08/2025 16:00</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary" onclick="downloadBackup('backup_20250818_160000.sql')">
                                                        <i class="fas fa-download"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger" onclick="deleteBackup('backup_20250818_160000.sql')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                
                                <div class="text-center">
                                    <small class="text-muted">
                                        Hệ thống tự động xóa các bản sao lưu cũ hơn 30 ngày.
                                        <br>Khuyến nghị tạo sao lưu hàng tuần để đảm bảo an toàn dữ liệu.
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Automated Backup Settings -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-clock"></i> Sao lưu tự động
                                </h5>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/settings" method="post">
                                    <input type="hidden" name="action" value="updateAutoBackup">
                                    
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" id="enableAutoBackup" checked>
                                                    <label class="form-check-label" for="enableAutoBackup">
                                                        Bật sao lưu tự động
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label for="backupFrequency" class="form-label">Tần suất</label>
                                                <select class="form-select" id="backupFrequency">
                                                    <option value="daily">Hàng ngày</option>
                                                    <option value="weekly" selected>Hàng tuần</option>
                                                    <option value="monthly">Hàng tháng</option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-4">
                                            <div class="mb-3">
                                                <label for="backupTime" class="form-label">Thời gian</label>
                                                <input type="time" class="form-control" id="backupTime" value="02:00">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-save"></i> Lưu cài đặt
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function downloadBackup(filename) {
            alert('Tải xuống file: ' + filename);
            // Implement download functionality
        }
        
        function deleteBackup(filename) {
            if (confirm('Bạn có chắc chắn muốn xóa file sao lưu: ' + filename + '?')) {
                alert('Đã xóa file: ' + filename);
                // Implement delete functionality
            }
        }
        
        // Auto-generate backup name with current timestamp
        document.addEventListener('DOMContentLoaded', function() {
            const now = new Date();
            const timestamp = now.getFullYear() + 
                String(now.getMonth() + 1).padStart(2, '0') + 
                String(now.getDate()).padStart(2, '0') + '_' +
                String(now.getHours()).padStart(2, '0') + 
                String(now.getMinutes()).padStart(2, '0') + 
                String(now.getSeconds()).padStart(2, '0');
            
            const backupNameInput = document.getElementById('backupName');
            if (backupNameInput) {
                backupNameInput.value = 'backup_' + timestamp;
            }
        });
    </script>
</body>
</html>
