package com.lms.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/license_management_system";

    private static final String USER =
            "root";

    private static final String PASSWORD =
            System.getenv("LMS_DB_PASSWORD");

      public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

        } catch (Exception e) {

            throw new RuntimeException(
                    "Database connection failed: " + e.getMessage(),
                    e
            );
        }
    }
}