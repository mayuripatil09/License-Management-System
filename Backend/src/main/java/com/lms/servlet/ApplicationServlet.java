package com.lms.servlet;

import com.lms.util.DatabaseConnection;
import com.lms.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

@WebServlet("/apply")
@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class ApplicationServlet extends HttpServlet {

    // Files will be stored here on your computer
    private static final String UPLOAD_DIR =
            "C:/lms_uploads";


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing logged-in session
        HttpSession session =
                request.getSession(false);

        // Check whether user is logged in
        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.html");
            return;
        }

        // Get logged-in user's ID
        int userId =
                (Integer) session.getAttribute("userId");


        // ================================
        // GET FORM DATA
        // ================================

        String fullName =
                request.getParameter("fullName");

        String dob =
                request.getParameter("dob");

        String address =
                request.getParameter("address");

        String licenseType =
                request.getParameter("licenseType");


        // ================================
        // GET UPLOADED FILES
        // ================================

        Part photoPart =
                request.getPart("photo");

        Part aadhaarPart =
                request.getPart("aadhaar");


        // Check files
        if (photoPart == null ||
            photoPart.getSize() == 0) {

            response.getWriter().println(
                    "Photo is required."
            );

            return;
        }

        if (aadhaarPart == null ||
            aadhaarPart.getSize() == 0) {

            response.getWriter().println(
                    "Aadhaar document is required."
            );

            return;
        }


        // Create upload directory
        Path uploadDirectory =
                Paths.get(UPLOAD_DIR);

        Files.createDirectories(
                uploadDirectory
        );


        String applicationNumber = null;
        String applicationDate =
                LocalDate.now().toString();


        String photoFileName = null;
        String aadhaarFileName = null;


        String sql =
                "INSERT INTO applications " +
                "(user_id, full_name, dob, address, " +
                "license_type, application_date, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, 'PENDING')";


        try (
            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(
                            sql,
                            java.sql.Statement.RETURN_GENERATED_KEYS
                    )
        ) {

            // ================================
            // INSERT APPLICATION
            // ================================

            statement.setInt(
                    1,
                    userId
            );

            statement.setString(
                    2,
                    fullName
            );

            statement.setDate(
                    3,
                    java.sql.Date.valueOf(dob)
            );

            statement.setString(
                    4,
                    address
            );

            statement.setString(
                    5,
                    licenseType
            );

            statement.setDate(
                    6,
                    java.sql.Date.valueOf(
                            LocalDate.now()
                    )
            );


            statement.executeUpdate();


            // ================================
            // GET GENERATED DATABASE ID
            // ================================

            ResultSet keys =
                    statement.getGeneratedKeys();

            if (keys.next()) {

                int applicationId =
                        keys.getInt(1);


                // ================================
                // GENERATE APPLICATION NUMBER
                // ================================

                int year =
                        LocalDate.now().getYear();

                applicationNumber =
                        String.format(
                                "LMS-%d-%04d",
                                year,
                                applicationId
                        );


                // ================================
                // FILE NAMES
                // ================================

                photoFileName =
                        "photo_"
                        + applicationNumber
                        + getFileExtension(
                                photoPart
                        );

                aadhaarFileName =
                        "aadhaar_"
                        + applicationNumber
                        + getFileExtension(
                                aadhaarPart
                        );


                // ================================
                // SAVE PHOTO
                // ================================

                Path photoPath =
                        uploadDirectory.resolve(
                                photoFileName
                        );

                try (
                    InputStream inputStream =
                            photoPart.getInputStream()
                ) {

                    Files.copy(
                            inputStream,
                            photoPath,
                            StandardCopyOption.REPLACE_EXISTING
                    );
                }


                // ================================
                // SAVE AADHAAR
                // ================================

                Path aadhaarPath =
                        uploadDirectory.resolve(
                                aadhaarFileName
                        );

                try (
                    InputStream inputStream =
                            aadhaarPart.getInputStream()
                ) {

                    Files.copy(
                            inputStream,
                            aadhaarPath,
                            StandardCopyOption.REPLACE_EXISTING
                    );
                }


                // ================================
                // UPDATE APPLICATION NUMBER
                // AND FILE PATHS
                // ================================

                String updateSql =
                        "UPDATE applications SET " +
                        "application_number = ?, " +
                        "photo_path = ?, " +
                        "aadhaar_path = ? " +
                        "WHERE id = ?";


                try (
                    PreparedStatement updateStatement =
                            connection.prepareStatement(
                                    updateSql
                            )
                ) {

                    updateStatement.setString(
                            1,
                            applicationNumber
                    );

                    updateStatement.setString(
                            2,
                            photoPath.toString()
                    );

                    updateStatement.setString(
                            3,
                            aadhaarPath.toString()
                    );

                    updateStatement.setInt(
                            4,
                            applicationId
                    );

                    updateStatement.executeUpdate();
                }


                // ================================
                // STORE APPLICATION INFO IN SESSION
                // ================================

                session.setAttribute(
                        "applicationNumber",
                        applicationNumber
                );

                session.setAttribute(
                        "applicationName",
                        fullName
                );

                session.setAttribute(
                        "applicationLicenseType",
                        licenseType
                );

                session.setAttribute(
                        "applicationDate",
                        applicationDate
                );

                session.setAttribute(
                        "applicationStatus",
                        "PENDING"
                );


                // ================================
                // GET APPLICANT EMAIL
                // ================================

                String email = null;

                String emailSql =
                        "SELECT email " +
                        "FROM users " +
                        "WHERE id = ?";


                try (
                    PreparedStatement emailStatement =
                            connection.prepareStatement(
                                    emailSql
                            )
                ) {

                    emailStatement.setInt(
                            1,
                            userId
                    );

                    try (
                        ResultSet emailResult =
                                emailStatement.executeQuery()
                    ) {

                        if (emailResult.next()) {

                            email =
                                    emailResult.getString(
                                            "email"
                                    );
                        }
                    }
                }


                // ================================
                // SEND APPLICATION EMAIL
                // ================================

                if (email != null &&
                    !email.trim().isEmpty()) {

                    EmailUtil.sendApplicationEmail(
                            email,
                            applicationNumber,
                            fullName,
                            licenseType,
                            applicationDate,
                            "PENDING"
                    );
                }


                // ================================
                // GO TO SUCCESS PAGE
                // ================================

                response.sendRedirect(
                        "application-success.jsp"
                );


            } else {

                response.getWriter().println(
                        "Application submission failed."
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Application error: "
                    + e.getMessage()
            );
        }
    }


    // ================================
    // GET FILE EXTENSION
    // ================================

    private String getFileExtension(
            Part part) {

        String fileName =
                part.getSubmittedFileName();

        if (fileName == null ||
            !fileName.contains(".")) {

            return "";
        }

        String extension =
                fileName.substring(
                        fileName.lastIndexOf(".")
                );

        // Only keep a simple extension
        if (extension.length() > 10) {
            return "";
        }

        return extension.toLowerCase();
    }
}