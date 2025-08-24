-- Database: phutungxe_shop
-- Tạo database và sử dụng
CREATE DATABASE IF NOT EXISTS phutungxe_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE phutungxe_shop;

-- Bảng danh mục sản phẩm
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng người dùng
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    role ENUM('USER', 'ADMIN') DEFAULT 'USER',
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng sản phẩm
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    category_id INT,
    image VARCHAR(255),
    brand VARCHAR(100),
    model VARCHAR(100),
    year_compatible VARCHAR(50),
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Bảng giỏ hàng
CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_product (user_id, product_id)
);

-- Bảng đơn hàng
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_address TEXT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'SHIPPING', 'DELIVERED', 'CANCELLED') DEFAULT 'PENDING',
    payment_method ENUM('COD', 'BANK_TRANSFER') DEFAULT 'COD',
    payment_status ENUM('PENDING', 'PAID', 'FAILED') DEFAULT 'PENDING',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Bảng chi tiết đơn hàng
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Thêm dữ liệu mẫu

-- Thêm admin user
INSERT INTO users (username, email, password, full_name, phone, address, role) VALUES
('admin', 'admin@phutungxe.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', '0123456789', 'Hà Nội', 'ADMIN'),
('user1', 'user1@gmail.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Nguyễn Văn A', '0987654321', 'TP. Hồ Chí Minh', 'USER');

-- Thêm danh mục
INSERT INTO categories (name, description, image) VALUES
('Lốp xe', 'Lốp xe máy các loại', 'lop-xe.jpg'),
('Phanh', 'Má phanh, đĩa phanh, dầu phanh', 'phanh.jpg'),
('Nhớt', 'Dầu nhớt động cơ', 'nhot.jpg'),
('Lọc gió', 'Lọc gió các loại xe', 'loc-gio.jpg'),
('Bóng đèn', 'Bóng đèn pha, đèn xi nhan', 'bong-den.jpg'),
('Ắc quy', 'Ắc quy xe máy', 'ac-quy.jpg');

-- Thêm sản phẩm mẫu
INSERT INTO products (name, description, price, stock_quantity, category_id, image, brand, model, year_compatible) VALUES
('Lốp Michelin City Pro 80/90-17', 'Lốp xe máy Michelin City Pro kích thước 80/90-17, phù hợp cho xe số', 450000, 50, 1, 'lop-michelin-city-pro.jpg', 'Michelin', 'City Pro', '2010-2023'),
('Lốp Dunlop D307 90/90-14', 'Lốp xe tay ga Dunlop D307 kích thước 90/90-14', 380000, 30, 1, 'lop-dunlop-d307.jpg', 'Dunlop', 'D307', '2015-2023'),
('Má phanh Nissin Honda Winner', 'Má phanh trước Nissin cho Honda Winner 150', 120000, 20, 2, 'ma-phanh-nissin-winner.jpg', 'Nissin', 'Winner', '2017-2023'),
('Nhớt Motul 5100 10W40', 'Dầu nhớt bán tổng hợp Motul 5100 10W40 1L', 185000, 100, 3, 'nhot-motul-5100.jpg', 'Motul', '5100', '2010-2023'),
('Lọc gió DNA Honda Air Blade', 'Lọc gió cao cấp DNA cho Honda Air Blade', 85000, 25, 4, 'loc-gio-dna-airblade.jpg', 'DNA', 'Air Blade', '2010-2023'),
('Bóng đèn LED H4 Philips', 'Bóng đèn LED H4 Philips 6000K siêu sáng', 350000, 15, 5, 'bong-den-led-philips.jpg', 'Philips', 'LED H4', '2010-2023'),
('Ắc quy Yuasa YTX5L-BS', 'Ắc quy Yuasa YTX5L-BS 12V 4Ah cho xe tay ga', 280000, 40, 6, 'ac-quy-yuasa-ytx5l.jpg', 'Yuasa', 'YTX5L-BS', '2010-2023');

-- Cập nhật lại password cho tài khoản (password: 123456)
-- Lưu ý: Trong thực tế, password sẽ được hash bởi ứng dụng
UPDATE users SET password = '$2a$10$N9qo8uLOickgx2ZMRZoMye1K3HjyQlqA2EQnO7D5kMlYaLkH.l7CO' WHERE username IN ('admin', 'user1');
