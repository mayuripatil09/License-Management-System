package com.lms.servlet;

import com.lms.util.DatabaseConnection;

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

@WebServlet("/admin-application-details")
public class AdminApplicationDetailsServlet extends HttpServlet {

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

        String applicationNumber =
                request.getParameter("applicationId");

        if (applicationNumber == null ||
            applicationNumber.trim().isEmpty()) {

            response.sendRedirect("admin-applications");
            return;
        }

        String sql =
                "SELECT application_number, " +
                "full_name, dob, license_type, " +
                "address, application_date, status " +
                "FROM applications " +
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

            try (ResultSet resultSet =
                    statement.executeQuery()) {

                if (resultSet.next()) {

                    request.setAttribute(
                            "applicationNumber",
                            resultSet.getString(
                                    "application_number"
                            )
                    );

                    request.setAttribute(
                            "fullName",
                            resultSet.getString(
                                    "full_name"
                            )
                    );

                    request.setAttribute(
                            "dob",
                            resultSet.getString("dob")
                    );

                    request.setAttribute(
                            "licenseType",
                            resultSet.getString(
                                    "license_type"
                            )
                    );

                    request.setAttribute(
                            "address",
                            resultSet.getString(
                                    "address"
                            )
                    );

                    request.setAttribute(
                            "applicationDate",
                            resultSet.getString(
                                    "application_date"
                            )
                    );

                    request.setAttribute(
                            "status",
                            resultSet.getString("status")
                    );

                    request.getRequestDispatcher(
                            "admin-application-details.jsp"
                    ).forward(request, response);

                } else {

                    response.sendRedirect(
                            "admin-applications"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error loading application details: "
                    + e.getMessage()
            );
        }
    }
}