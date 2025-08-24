package com.phutungxe.utils.security;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility để test và tạo password hash
 */
public class PasswordTestUtil {

    public static void main(String[] args) {
        // Test với password "123456"
        String plainPassword = "123456";

        // Tạo hash mới
        String newHash = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        System.out.println("New hash for '123456': " + newHash);

        // Test các hash có sẵn trong database
        String hash1 = "$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi";
        String hash2 = "$2a$10$N9qo8uLOickgx2ZMRZoMye1K3HjyQlqA2EQnO7D5kMlYaLkH.l7CO";

        System.out.println("\nTesting existing hashes:");
        System.out.println("Hash 1 matches '123456': " + BCrypt.checkpw(plainPassword, hash1));
        System.out.println("Hash 2 matches '123456': " + BCrypt.checkpw(plainPassword, hash2));

        // Test với password khác
        String[] testPasswords = { "password", "admin", "admin123", "123456" };

        System.out.println("\nTesting different passwords with hash2:");
        for (String pwd : testPasswords) {
            boolean matches = BCrypt.checkpw(pwd, hash2);
            System.out.println("Password '" + pwd + "' matches: " + matches);
        }

        // Tạo hash cho các password thông dụng
        System.out.println("\nGenerating hashes for common passwords:");
        String[] commonPasswords = { "123456", "admin123", "password" };
        for (String pwd : commonPasswords) {
            String hash = BCrypt.hashpw(pwd, BCrypt.gensalt());
            System.out.println("Password '" + pwd + "' hash: " + hash);
        }
    }
}
