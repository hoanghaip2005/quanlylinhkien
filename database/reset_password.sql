-- Script để reset password cho các tài khoản có sẵn
-- Password sẽ là PLAIN TEXT để dễ test

USE phutungxe_shop;

-- Xóa tất cả user cũ và tạo mới với password plain text
DELETE FROM users WHERE username IN ('admin', 'user1', 'admin2', 'user2');

-- Thêm lại admin user với password PLAIN TEXT
INSERT INTO users (username, email, password, full_name, phone, address, role) VALUES
('admin', 'admin@phutungxe.com', '123456', 'Administrator', '0123456789', 'Hà Nội', 'ADMIN'),
('user1', 'user1@gmail.com', '123456', 'Nguyễn Văn A', '0987654321', 'TP. Hồ Chí Minh', 'USER');

-- Thêm thêm một số tài khoản test khác với password dễ nhớ
INSERT INTO users (username, email, password, full_name, phone, address, role) VALUES
('admin2', 'admin2@admin.com', 'admin', 'Admin 2', '0987654322', 'Đà Nẵng', 'ADMIN'),
('user2', 'user2@user.com', 'user', 'Nguyễn Văn B', '0987654323', 'Cần Thơ', 'USER'),
('test', 'test@test.com', 'test', 'Test User', '0987654324', 'Huế', 'USER');

-- Hiển thị thông tin tài khoản
SELECT 'THÔNG TIN TÀI KHOẢN TEST (PLAIN TEXT PASSWORD):' as message;
SELECT username, email, password, full_name, role FROM users WHERE username IN ('admin', 'user1', 'admin2', 'user2', 'test');

SELECT '
DANH SÁCH TÀI KHOẢN VÀ PASSWORD:
admin@phutungxe.com / 123456 (ADMIN)
user1@gmail.com / 123456 (USER)  
admin2@admin.com / admin (ADMIN)
user2@user.com / user (USER)
test@test.com / test (USER)
' as login_info;
