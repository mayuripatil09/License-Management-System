package com.lms.util;

import java.sql.Connection;

public class TestDatabaseConnection {

    public static void main(String[] args) {

        Connection connection = DatabaseConnection.getConnection();

        if (connection != null) {
            System.out.println("Database connected successfully!");
        } else {
            System.out.println("Database connection failed!");
        }
    }
}