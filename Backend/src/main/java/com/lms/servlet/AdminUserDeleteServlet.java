package com.lms.servlet;

import com.lms.util.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin-user-delete")
public class AdminUserDeleteServlet extends HttpServlet {

    private static final Path UPLOAD_DIR =
            Paths.get("C:/lms_uploads")
                 .toAbsolutePath()
                 .normalize();

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

        // Get user ID
        String userIdParameter =
                request.getParameter("userId");

        if (userIdParameter == null ||
            userIdParameter.trim().isEmpty()) {

            response.sendRedirect("admin-users");
            return;
        }

        int userId;

        try {

            userId =
                    Integer.parseInt(userIdParameter);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "admin-users?error=invalid"
            );

            return;
        }

        // Prevent admin from deleting their own account
        int loggedInUserId =
                (Integer) session.getAttribute("userId");

        if (userId == loggedInUserId) {

            response.sendRedirect(
                    "admin-users?error=self"
            );

            return;
        }

        List<Path> filesToDelete =
                new ArrayList<>();

        Connection connection = null;

        try {

            connection =
                    DatabaseConnection.getConnection();

            // Start transaction
            connection.setAutoCommit(false);

            // =========================================
            // 1. Check target user
            // =========================================

            String userSql =
                    "SELECT role " +
                    "FROM users " +
                    "WHERE id = ?";

            try (
                PreparedStatement statement =
                        connection.prepareStatement(userSql)
            ) {

                statement.setInt(1, userId);

                try (
                    ResultSet resultSet =
                            statement.executeQuery()
                ) {

                    if (!resultSet.next()) {

                        connection.rollback();

                        response.sendRedirect(
                                "admin-users?error=notfound"
                        );

                        return;
                    }

                    String targetRole =
                            resultSet.getString("role");

                    // Never delete ADMIN accounts
                    if ("ADMIN".equalsIgnoreCase(
                            targetRole
                    )) {

                        connection.rollback();

                        response.sendRedirect(
                                "admin-users?error=admin"
                        );

                        return;
                    }
                }
            }

            // =========================================
            // 2. Get uploaded document paths
            // =========================================

            String fileSql =
                    "SELECT photo_path, aadhaar_path " +
                    "FROM applications " +
                    "WHERE user_id = ?";

            try (
                PreparedStatement statement =
                        connection.prepareStatement(fileSql)
            ) {

                statement.setInt(1, userId);

                try (
                    ResultSet resultSet =
                            statement.executeQuery()
                ) {

                    while (resultSet.next()) {

                        String photoPath =
                                resultSet.getString("photo_path");

                        String aadhaarPath =
                                resultSet.getString("aadhaar_path");

                        addSafeFile(
                                filesToDelete,
                                photoPath
                        );

                        addSafeFile(
                                filesToDelete,
                                aadhaarPath
                        );
                    }
                }
            }

            // =========================================
            // 3. Delete user's applications
            // =========================================

            String applicationDeleteSql =
                    "DELETE FROM applications " +
                    "WHERE user_id = ?";

            try (
                PreparedStatement statement =
                        connection.prepareStatement(
                                applicationDeleteSql
                        )
            ) {

                statement.setInt(1, userId);

                statement.executeUpdate();
            }

            // =========================================
            // 4. Delete user account
            // =========================================

            String userDeleteSql =
                    "DELETE FROM users " +
                    "WHERE id = ?";

            int rowsDeleted;

            try (
                PreparedStatement statement =
                        connection.prepareStatement(
                                userDeleteSql
                        )
            ) {

                statement.setInt(1, userId);

                rowsDeleted =
                        statement.executeUpdate();
            }

            if (rowsDeleted == 0) {

                connection.rollback();

                response.sendRedirect(
                        "admin-users?error=notfound"
                );

                return;
            }

            // =========================================
            // 5. Commit database changes
            // =========================================

            connection.commit();

            // =========================================
            // 6. Delete uploaded files
            // =========================================

            for (Path file : filesToDelete) {

                try {

                    Files.deleteIfExists(file);

                } catch (Exception fileException) {

                    fileException.printStackTrace();
                }
            }

            // =========================================
            // 7. Return to Manage Users
            // =========================================

            response.sendRedirect(
                    "admin-users?deleted=true"
            );

        } catch (Exception e) {

            // Rollback database changes if something fails
            if (connection != null) {

                try {

                    connection.rollback();

                } catch (Exception rollbackException) {

                    rollbackException.printStackTrace();
                }
            }

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error deleting user: "
                    + e.getMessage()
            );

        } finally {

            if (connection != null) {

                try {

                    connection.setAutoCommit(true);
                    connection.close();

                } catch (Exception closeException) {

                    closeException.printStackTrace();
                }
            }
        }
    }

    // =========================================
    // Safely add an uploaded file for deletion
    // =========================================

    private void addSafeFile(
            List<Path> files,
            String filePath) {

        if (filePath == null ||
            filePath.trim().isEmpty()) {

            return;
        }

        try {

            Path path =
                    Paths.get(filePath)
                         .toAbsolutePath()
                         .normalize();

            // Only allow files inside C:/lms_uploads
            if (path.startsWith(UPLOAD_DIR)) {

                files.add(path);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}