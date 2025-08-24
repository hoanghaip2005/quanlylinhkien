package com.phutungxe.utils.security;

// import org.mindrot.jbcrypt.BCrypt; // Tạm thời comment để dùng plain text

public class PasswordUtils {

    /**
     * Hash a password - CHANGED TO PLAIN TEXT FOR TESTING
     */
    public static String hashPassword(String plainPassword) {
        // return BCrypt.hashpw(plainPassword, BCrypt.gensalt()); // Comment BCrypt
        return plainPassword; // Trả về plain text luôn
    }

    /**
     * Verify a password - CHANGED TO PLAIN TEXT COMPARISON
     */
    public static boolean verifyPassword(String plainPassword, String storedPassword) {
        // return BCrypt.checkpw(plainPassword, hashedPassword); // Comment BCrypt
        return plainPassword.equals(storedPassword); // So sánh plain text
    }

    /**
     * Check if password meets requirements
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 3) { // Giảm từ 6 xuống 3 cho dễ test
            return false;
        }
        return true;
    }

    /**
     * Generate a random password
     */
    public static String generateRandomPassword(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int index = (int) (Math.random() * characters.length());
            password.append(characters.charAt(index));
        }

        return password.toString();
    }
}
