package com.lms.servlet;

import com.lms.util.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/admin-document")
public class DocumentServlet extends HttpServlet {

    private static final String UPLOAD_DIR =
            "C:/lms_uploads";

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check logged-in session
        HttpSession session =
                request.getSession(false);

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

        // Get application ID
        String applicationNumber =
                request.getParameter("applicationId");

        // Get document type
        String documentType =
                request.getParameter("type");

        if (applicationNumber == null ||
            applicationNumber.trim().isEmpty() ||
            documentType == null) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid document request."
            );

            return;
        }

        String columnName;

        if ("photo".equalsIgnoreCase(documentType)) {

            columnName = "photo_path";

        } else if ("aadhaar".equalsIgnoreCase(documentType)) {

            columnName = "aadhaar_path";

        } else {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid document type."
            );

            return;
        }

        String sql =
                "SELECT " + columnName +
                " FROM applications " +
                "WHERE application_number = ?";

        try (
            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    applicationNumber
            );

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                if (!resultSet.next()) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Application not found."
                    );

                    return;
                }

                String filePath =
                        resultSet.getString(columnName);

                if (filePath == null ||
                    filePath.trim().isEmpty()) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Document not found."
                    );

                    return;
                }

                // Make sure the file is inside our upload folder
                Path uploadDirectory =
                        Paths.get(UPLOAD_DIR)
                             .toAbsolutePath()
                             .normalize();

                Path requestedFile =
                        Paths.get(filePath)
                             .toAbsolutePath()
                             .normalize();

                if (!requestedFile.startsWith(
                        uploadDirectory)) {

                    response.sendError(
                            HttpServletResponse.SC_FORBIDDEN,
                            "Access denied."
                    );

                    return;
                }

                if (!Files.exists(requestedFile) ||
                    !Files.isRegularFile(requestedFile)) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Document file does not exist."
                    );

                    return;
                }

                // Determine content type
                String contentType =
                        Files.probeContentType(
                                requestedFile
                        );

                if (contentType == null) {

                    if ("aadhaar".equalsIgnoreCase(
                            documentType)) {

                        contentType =
                                "application/pdf";

                    } else {

                        contentType =
                                "image/jpeg";
                    }
                }

                response.setContentType(
                        contentType
                );

                response.setHeader(
                        "Content-Disposition",
                        "inline; filename=\"" +
                        requestedFile.getFileName() +
                        "\""
                );

                response.setContentLengthLong(
                        Files.size(requestedFile)
                );

                // Send file to browser
                try (
                    OutputStream outputStream =
                            response.getOutputStream()
                ) {

                    Files.copy(
                            requestedFile,
                            outputStream
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error loading document."
            );
        }
    }
}