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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin-applications")
public class AdminApplicationsServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("admin-login.html");
            return;
        }

        // Check ADMIN role
        String role =
                (String) session.getAttribute("role");

        if (!"ADMIN".equalsIgnoreCase(role)) {

            response.sendRedirect("user-dashboard.html");
            return;
        }

        List<Map<String, String>> applications =
                new ArrayList<>();

        String sql =
                "SELECT application_number, " +
                "full_name, dob, license_type, " +
                "application_date, status " +
                "FROM applications " +
                "ORDER BY application_date DESC, id DESC";

        try (
            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            ResultSet resultSet =
                    statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Map<String, String> application =
                        new HashMap<>();

                application.put(
                        "applicationNumber",
                        resultSet.getString(
                                "application_number"
                        )
                );

                application.put(
                        "fullName",
                        resultSet.getString(
                                "full_name"
                        )
                );

                application.put(
                        "dob",
                        resultSet.getString("dob")
                );

                application.put(
                        "licenseType",
                        resultSet.getString(
                                "license_type"
                        )
                );

                application.put(
                        "applicationDate",
                        resultSet.getString(
                                "application_date"
                        )
                );

                application.put(
                        "status",
                        resultSet.getString("status")
                );

                applications.add(application);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        request.setAttribute(
                "applications",
                applications
        );

        request.getRequestDispatcher(
                "admin-application.jsp"
        ).forward(request, response);
    }
}
