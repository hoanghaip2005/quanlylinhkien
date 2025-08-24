# Website Bán Phụ Tùng Xe Máy

Dự án website bán phụ tùng xe máy được xây dựng bằng Java MVC Servlet, JSP, MySQL.

## Tính năng

### Dành cho khách hàng (User):
- Đăng ký/Đăng nhập tài khoản
- Xem danh sách sản phẩm
- Tìm kiếm sản phẩm theo tên, danh mục
- Xem chi tiết sản phẩm
- Thêm sản phẩm vào giỏ hàng
- Quản lý giỏ hàng (cập nhật số lượng, xóa sản phẩm)
- Đặt hàng và thanh toán
- Xem lịch sử đơn hàng
- Quản lý thông tin cá nhân

### Dành cho quản trị viên (Admin):
- Dashboard với thống kê tổng quan
- Quản lý sản phẩm (CRUD)
- Quản lý danh mục sản phẩm (CRUD)
- Quản lý đơn hàng (xem, cập nhật trạng thái)
- Quản lý người dùng
- Báo cáo doanh thu

## Công nghệ sử dụng

- **Backend**: Java Servlet, JSP, JSTL
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5
- **Database**: MySQL 8.0
- **Server**: Apache Tomcat 9.0+
- **Build Tool**: Maven
- **IDE**: NetBeans 12+

## Yêu cầu hệ thống

- Java JDK 11 hoặc cao hơn
- Apache Tomcat 9.0+
- MySQL 8.0+
- NetBeans IDE 12+ (khuyến nghị)
- Maven 3.6+

## Hướng dẫn cài đặt

### 1. Chuẩn bị môi trường

1. **Cài đặt Java JDK 11+**
   - Tải và cài đặt từ Oracle hoặc OpenJDK
   - Thiết lập biến môi trường JAVA_HOME

2. **Cài đặt NetBeans IDE**
   - Tải NetBeans 12+ từ trang chủ Apache NetBeans
   - Chọn phiên bản có hỗ trợ Java EE

3. **Cài đặt Apache Tomcat**
   - Tải Tomcat 9.0+ từ trang chủ Apache
   - Giải nén và cấu hình trong NetBeans

4. **Cài đặt MySQL**
   - Tải và cài đặt MySQL 8.0+
   - Tạo user root với password: `210506`

### 2. Thiết lập cơ sở dữ liệu

1. **Tạo database**:
   ```sql
   CREATE DATABASE phutungxe_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

2. **Import dữ liệu**:
   - Chạy file SQL: `database/phutungxe_shop.sql`
   - File này sẽ tạo các bảng và dữ liệu mẫu

3. **Cấu hình kết nối database**:
   - Mở file `src/main/java/com/phutungxe/utils/DatabaseConnection.java`
   - Kiểm tra thông tin kết nối:
     ```java
     private static final String URL = "jdbc:mysql://localhost:3306/phutungxe_shop";
     private static final String USERNAME = "root";
     private static final String PASSWORD = "210506";
     ```

### 3. Import project vào NetBeans

1. **Mở NetBeans**
2. **File** → **Open Project**
3. **Chọn thư mục** `java_mysql_phutungxe`
4. **Click Open Project**

### 4. Cấu hình Tomcat trong NetBeans

1. **Tools** → **Servers**
2. **Add Server** → **Apache Tomcat**
3. **Chọn thư mục cài đặt Tomcat**
4. **Finish**

### 5. Chạy ứng dụng

1. **Right-click project** → **Properties**
2. **Run** → **Server**: Chọn Tomcat đã cấu hình
3. **Context Path**: `/phutungxe-shop`
4. **OK**
5. **Right-click project** → **Run**

### 6. Truy cập ứng dụng

- **URL**: `http://localhost:8080/phutungxe-shop/`
- **Tài khoản Admin**: 
  - Username: `admin`
  - Password: `123456`
- **Tài khoản User**:
  - Username: `user1`
  - Password: `123456`

## Cấu trúc thư mục

```
java_mysql_phutungxe/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── phutungxe/
│       │           ├── controller/      # Servlet controllers
│       │           ├── dao/            # Data Access Objects
│       │           ├── model/          # Model classes
│       │           └── utils/          # Utility classes
│       └── webapp/
│           ├── admin/                  # Admin pages
│           ├── css/                    # CSS files
│           ├── js/                     # JavaScript files
│           ├── images/                 # Image files
│           ├── includes/               # Common JSP includes
│           ├── WEB-INF/               # Web configuration
│           └── *.jsp                  # JSP pages
├── database/
│   └── phutungxe_shop.sql            # Database schema
└── pom.xml                           # Maven configuration
```

## Tài khoản mẫu

### Admin
- **Username**: admin
- **Password**: 123456
- **Quyền**: Quản trị toàn hệ thống

### User
- **Username**: user1
- **Password**: 123456
- **Quyền**: Khách hàng thông thường

## Tính năng chính

### 1. Quản lý sản phẩm
- Thêm, sửa, xóa sản phẩm
- Upload hình ảnh sản phẩm
- Quản lý tồn kho
- Phân loại theo danh mục

### 2. Quản lý đơn hàng
- Xử lý đơn hàng từ khách
- Cập nhật trạng thái đơn hàng
- Theo dõi thanh toán

### 3. Giỏ hàng
- Thêm/xóa sản phẩm
- Cập nhật số lượng
- Tính tổng tiền tự động

### 4. Thanh toán
- Thanh toán khi nhận hàng (COD)
- Chuyển khoản ngân hàng

## API Endpoints

### Public APIs
- `GET /products` - Danh sách sản phẩm
- `GET /products?action=detail&id={id}` - Chi tiết sản phẩm
- `GET /products?action=search&keyword={keyword}` - Tìm kiếm
- `POST /register` - Đăng ký
- `POST /login` - Đăng nhập

### User APIs (cần đăng nhập)
- `GET /cart` - Xem giỏ hàng
- `POST /cart` - Thêm vào giỏ hàng
- `GET /order` - Lịch sử đơn hàng
- `POST /order` - Đặt hàng

### Admin APIs (cần quyền admin)
- `GET /admin/dashboard` - Dashboard
- `GET /admin/products` - Quản lý sản phẩm
- `GET /admin/orders` - Quản lý đơn hàng
- `GET /admin/users` - Quản lý người dùng

## Xử lý lỗi

### Lỗi thường gặp

1. **Lỗi kết nối database**
   - Kiểm tra MySQL service đã chạy
   - Kiểm tra thông tin kết nối trong DatabaseConnection.java

2. **Lỗi 404**
   - Kiểm tra context path
   - Kiểm tra URL mapping trong servlet

3. **Lỗi compile**
   - Kiểm tra Java version
   - Clean và rebuild project

## Bảo mật

1. **Mã hóa mật khẩu**: Sử dụng BCrypt
2. **Session management**: Timeout sau 30 phút
3. **SQL Injection**: Sử dụng PreparedStatement
4. **XSS Protection**: Escape output trong JSP
5. **Authentication**: Filter kiểm tra đăng nhập
6. **Authorization**: Phân quyền admin/user

## Tối ưu hóa

1. **Database**: Index trên các cột thường query
2. **Frontend**: Minify CSS/JS
3. **Images**: Lazy loading cho hình ảnh
4. **Caching**: Session cache cho user data

## Tác giả

- **Developer**: [Tên của bạn]
- **Email**: [Email của bạn]
- **GitHub**: [GitHub URL]

## License

Dự án này được phát hành dưới MIT License.

## Đóng góp

Mọi đóng góp và phản hồi đều được hoan nghênh. Vui lòng tạo issue hoặc pull request.

---

**Lưu ý**: Đây là dự án học tập, không sử dụng cho mục đích thương mại mà không có sự cho phép.
