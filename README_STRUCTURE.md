# Cấu Trúc Thư Mục Dự Án Phụ Tùng Xe

## Tổng Quan
Dự án đã được tổ chức lại theo mô hình MVC (Model-View-Controller) với kiến trúc layered architecture để dễ bảo trì và mở rộng.

## Cấu Trúc Java Packages

### 1. Controller Layer (`src/main/java/com/phutungxe/controller/`)
- **admin/** - Các controller xử lý chức năng admin
  - `AdminProductServlet.java` - Quản lý sản phẩm
  - `AdminUserServlet.java` - Quản lý người dùng
  - `AdminCategoryServlet.java` - Quản lý danh mục
  - `AdminOrderServlet.java` - Quản lý đơn hàng
  - `AdminDashboardServlet.java` - Dashboard admin
  - `AdminSettingsServlet.java` - Cài đặt hệ thống
  - `AdminReportsServlet.java` - Báo cáo

- **auth/** - Các controller xử lý xác thực
  - `LoginServlet.java` - Đăng nhập
  - `RegisterServlet.java` - Đăng ký
  - `LogoutServlet.java` - Đăng xuất
  - `AuthenticationFilter.java` - Filter xác thực
  - `CharacterEncodingFilter.java` - Filter encoding

- **cart/** - Các controller xử lý giỏ hàng
  - `CartServlet.java` - Xử lý giỏ hàng
  - `TestCartServlet.java` - Test giỏ hàng
  - `TestCartPageServlet.java` - Test trang giỏ hàng
  - `SimpleCartServlet.java` - Giỏ hàng đơn giản

- **order/** - Các controller xử lý đơn hàng
  - `OrderServlet.java` - Xử lý đơn hàng
  - `OrdersNewServlet.java` - Đơn hàng mới
  - `SimpleOrderServlet.java` - Đơn hàng đơn giản
  - `OrderHistoryServlet.java` - Lịch sử đơn hàng
  - `CheckoutServlet.java` - Thanh toán

- **product/** - Các controller xử lý sản phẩm
  - `ProductServlet.java` - Xử lý sản phẩm
  - `ApiProductServlet.java` - API sản phẩm

### 2. Model Layer (`src/main/java/com/phutungxe/model/`)
- **entity/** - Các entity classes
  - `Product.java` - Entity sản phẩm
  - `Category.java` - Entity danh mục
  - `User.java` - Entity người dùng
  - `Order.java` - Entity đơn hàng
  - `OrderItem.java` - Entity chi tiết đơn hàng
  - `CartItem.java` - Entity giỏ hàng

- **dto/** - Data Transfer Objects (để tạo sau)
- **vo/** - Value Objects (để tạo sau)

### 3. DAO Layer (`src/main/java/com/phutungxe/dao/`)
- **impl/** - Các implementation của DAO
  - `ProductDAO.java` - Data access cho sản phẩm
  - `CategoryDAO.java` - Data access cho danh mục
  - `UserDAO.java` - Data access cho người dùng
  - `OrderDAO.java` - Data access cho đơn hàng
  - `CartDAO.java` - Data access cho giỏ hàng

- **interface/** - Các interface của DAO (để tạo sau)

### 4. Service Layer (`src/main/java/com/phutungxe/service/`)
- **impl/** - Các implementation của service
  - `ProductServiceImpl.java` - Business logic cho sản phẩm

### 5. Utils (`src/main/java/com/phutungxe/utils/`)
- **database/** - Các utility liên quan database
  - `DatabaseConnection.java` - Kết nối database
- **security/** - Các utility liên quan bảo mật
  - `PasswordUtils.java` - Xử lý mật khẩu
  - `PasswordTestUtil.java` - Test mật khẩu
- **common/** - Các utility chung
  - `StringUtils.java` - Xử lý chuỗi

### 6. Config (`src/main/java/com/phutungxe/config/`)
- `DatabaseConfig.java` - Cấu hình database

### 7. Exception (`src/main/java/com/phutungxe/exception/`)
- `ServiceException.java` - Exception cho service layer
- `DAOException.java` - Exception cho DAO layer

## Cấu Trúc Webapp

### 1. Pages (`src/main/webapp/pages/`)
- **admin/** - Các trang admin
  - `admin-test.jsp` - Test admin
- **auth/** - Các trang xác thực
  - `login.jsp` - Trang đăng nhập
  - `register.jsp` - Trang đăng ký
- **cart/** - Các trang giỏ hàng
  - `cart.jsp` - Trang giỏ hàng
- **order/** - Các trang đơn hàng
  - `checkout.jsp` - Trang thanh toán
  - `order-success.jsp` - Trang thành công
  - `order-history.jsp` - Trang lịch sử
  - `simple-order-history.jsp` - Lịch sử đơn giản
  - `debug-order.jsp` - Debug đơn hàng
- **product/** - Các trang sản phẩm
  - `product-detail.jsp` - Chi tiết sản phẩm
  - `product-list.jsp` - Danh sách sản phẩm
- **common/** - Các trang chung
  - `session-debug.jsp` - Debug session
  - `includes/` - Các file include

### 2. Resources (`src/main/webapp/resources/`)
- **css/** - Stylesheets
- **js/** - JavaScript files
- **images/** - Hình ảnh
- **fonts/** - Font chữ (để tạo sau)

### 3. WEB-INF
- `web.xml` - Cấu hình web application

## Lợi Ích Của Cấu Trúc Mới

1. **Dễ bảo trì**: Mỗi layer có trách nhiệm riêng biệt
2. **Dễ mở rộng**: Có thể thêm service layer, DTO, VO dễ dàng
3. **Dễ test**: Có thể test từng layer riêng biệt
4. **Tái sử dụng**: Các utility và service có thể tái sử dụng
5. **Chuẩn hóa**: Tuân thủ các pattern phổ biến trong Java web

## Hướng Dẫn Sử Dụng

### Để thêm controller mới:
1. Xác định loại controller (admin, auth, cart, order, product)
2. Tạo file trong package tương ứng
3. Cập nhật package declaration

### Để thêm service mới:
1. Tạo interface trong `service/`
2. Tạo implementation trong `service/impl/`
3. Inject vào controller

### Để thêm trang mới:
1. Xác định loại trang
2. Tạo file JSP trong package tương ứng
3. Cập nhật các link và reference

## Lưu Ý Quan Trọng

### Đã được cập nhật:
- ✅ Tất cả package declarations
- ✅ Tất cả import statements
- ✅ Đường dẫn JSP trong controllers
- ✅ Cấu trúc thư mục theo chuẩn

### Cần kiểm tra thêm:
- Các link trong JSP files
- Các include path trong JSP
- URL mapping trong web.xml
- Các reference đến file tài nguyên (CSS, JS, images)

## Cách Kiểm Tra

1. **Compile project** để đảm bảo không có lỗi import
2. **Chạy ứng dụng** để kiểm tra các trang hoạt động
3. **Kiểm tra console** để tìm các lỗi đường dẫn
4. **Test từng chức năng** để đảm bảo hoạt động bình thường

## Hỗ Trợ

Nếu gặp vấn đề sau khi tổ chức lại:
1. Kiểm tra console logs
2. Kiểm tra đường dẫn file
3. Kiểm tra import statements
4. Kiểm tra package declarations
