package com.lms.servlet;

import com.lms.util.DatabaseConnection;
import com.lms.util.EmailUtil;

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

@WebServlet("/admin-application-decision")
public class AdminApplicationDecisionServlet extends HttpServlet {

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

        String applicationNumber =
                request.getParameter("applicationId");

        String decision =
                request.getParameter("decision");

        // Validate input
        if (applicationNumber == null ||
            applicationNumber.trim().isEmpty() ||
            decision == null) {

            response.sendRedirect("admin-applications");
            return;
        }

        String status;

        if ("APPROVE".equalsIgnoreCase(decision)) {

            status = "APPROVED";

        } else if ("REJECT".equalsIgnoreCase(decision)) {

            status = "REJECTED";

        } else {

            response.sendRedirect("admin-applications");
            return;
        }

        String selectSql =
                "SELECT a.full_name, a.license_type, " +
                "a.application_date, u.email " +
                "FROM applications a " +
                "JOIN users u ON a.user_id = u.id " +
                "WHERE a.application_number = ?";

        String updateSql =
                "UPDATE applications " +
                "SET status = ? " +
                "WHERE application_number = ?";

        try (
            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement selectStatement =
                    connection.prepareStatement(selectSql);

            PreparedStatement updateStatement =
                    connection.prepareStatement(updateSql)
        ) {

            // Get applicant details
            selectStatement.setString(
                    1,
                    applicationNumber
            );

            String applicantName = null;
            String licenseType = null;
            String applicationDate = null;
            String applicantEmail = null;

            try (
                ResultSet resultSet =
                        selectStatement.executeQuery()
            ) {

                if (resultSet.next()) {

                    applicantName =
                            resultSet.getString("full_name");

                    licenseType =
                            resultSet.getString("license_type");

                    applicationDate =
                            resultSet.getString("application_date");

                    applicantEmail =
                            resultSet.getString("email");

                } else {

                    response.sendRedirect(
                            "admin-applications"
                    );

                    return;
                }
            }

            // Update application status
            updateStatement.setString(
                    1,
                    status
            );

            updateStatement.setString(
                    2,
                    applicationNumber
            );

            int rowsUpdated =
                    updateStatement.executeUpdate();

            if (rowsUpdated > 0) {

                // Send status email
                EmailUtil.sendApplicationStatusEmail(
                        applicantEmail,
                        applicationNumber,
                        applicantName,
                        licenseType,
                        applicationDate,
                        status
                );
            }

            response.sendRedirect(
                    "admin-application-details?applicationId="
                    + applicationNumber
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error updating application status: "
                    + e.getMessage()
            );
        }
    }
}