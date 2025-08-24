package com.phutungxe.config;

public class DatabaseConfig {
    // Database configuration constants
    public static final String DB_URL = "jdbc:mysql://localhost:3306/phutungxe";
    public static final String DB_USERNAME = "root";
    public static final String DB_PASSWORD = "";
    public static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // Connection pool settings
    public static final int INITIAL_POOL_SIZE = 5;
    public static final int MAX_POOL_SIZE = 20;
    public static final int MAX_TIMEOUT = 30000;
    
    private DatabaseConfig() {
        // Private constructor to prevent instantiation
    }
}
