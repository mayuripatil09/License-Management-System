package com.lms.servlet;

import com.lms.util.DatabaseConnection;
import com.lms.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/admin-password-change")
public class AdminPasswordChangeServlet extends HttpServlet {

    // Open Change Password page
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check admin login
        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("admin-login.html");
            return;
        }

        // Check admin role
        String role =
                (String) session.getAttribute("role");

        if (!"ADMIN".equalsIgnoreCase(role)) {

            response.sendRedirect("user-dashboard.html");
            return;
        }

        request.getRequestDispatcher(
                "admin-password-change.jsp"
        ).forward(
                request,
                response
        );
    }


    // Change password
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check admin login
        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("admin-login.html");
            return;
        }

        // Check admin role
        String role =
                (String) session.getAttribute("role");

        if (!"ADMIN".equalsIgnoreCase(role)) {

            response.sendRedirect("user-dashboard.html");
            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        String currentPassword =
                request.getParameter("currentPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");


        // Check empty fields
        if (currentPassword == null ||
            newPassword == null ||
            confirmPassword == null ||
            currentPassword.trim().isEmpty() ||
            newPassword.trim().isEmpty() ||
            confirmPassword.trim().isEmpty()) {

            response.sendRedirect(
                    "admin-password-change?error=empty"
            );
            return;
        }


        // Check password confirmation
        if (!newPassword.equals(confirmPassword)) {

            response.sendRedirect(
                    "admin-password-change?error=mismatch"
            );
            return;
        }


        // Minimum password length
        if (newPassword.length() < 6) {

            response.sendRedirect(
                    "admin-password-change?error=length"
            );
            return;
        }


        try (
            Connection connection =
                    DatabaseConnection.getConnection()
        ) {

            // Hash current password
            String hashedCurrentPassword =
                    PasswordUtil.hashPassword(currentPassword);


            // Get stored password
            String selectSql =
                    "SELECT password " +
                    "FROM users " +
                    "WHERE id = ? AND role = 'ADMIN'";

            try (
                PreparedStatement selectStatement =
                        connection.prepareStatement(selectSql)
            ) {

                selectStatement.setInt(1, userId);

                try (
                    ResultSet resultSet =
                            selectStatement.executeQuery()
                ) {

                    if (!resultSet.next()) {

                        response.sendRedirect(
                                "admin-profile"
                        );
                        return;
                    }

                    String storedPassword =
                            resultSet.getString("password");


                    // Compare hashed passwords
                    if (!storedPassword.equals(
                            hashedCurrentPassword)) {

                        response.sendRedirect(
                                "admin-password-change?error=wrong"
                        );
                        return;
                    }
                }
            }


            // Hash new password
            String hashedNewPassword =
                    PasswordUtil.hashPassword(newPassword);


            // Update password
            String updateSql =
                    "UPDATE users " +
                    "SET password = ? " +
                    "WHERE id = ? AND role = 'ADMIN'";

            try (
                PreparedStatement updateStatement =
                        connection.prepareStatement(updateSql)
            ) {

                updateStatement.setString(
                        1,
                        hashedNewPassword
                );

                updateStatement.setInt(
                        2,
                        userId
                );

                int rowsUpdated =
                        updateStatement.executeUpdate();


                if (rowsUpdated > 0) {

                    response.sendRedirect(
                            "admin-profile?passwordChanged=true"
                    );

                } else {

                    response.sendRedirect(
                            "admin-password-change?error=failed"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error changing password: "
                    + e.getMessage()
            );
        }
    }
}