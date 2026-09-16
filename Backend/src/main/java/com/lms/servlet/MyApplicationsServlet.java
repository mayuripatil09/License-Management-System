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

@WebServlet("/my-applications")
public class MyApplicationsServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing login session
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


        List<Map<String, String>> applications =
                new ArrayList<>();


        String sql =
                "SELECT application_number, " +
                "license_type, application_date, status " +
                "FROM applications " +
                "WHERE user_id = ? " +
                "ORDER BY application_date DESC, id DESC";


        try (
            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    userId
            );


            ResultSet resultSet =
                    statement.executeQuery();


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
                        resultSet.getString(
                                "status"
                        )
                );


                applications.add(
                        application
                );
            }


        } catch (Exception e) {

            e.printStackTrace();
        }


        // Send applications to JSP
        request.setAttribute(
                "applications",
                applications
        );


        // Open My Applications page
        request.getRequestDispatcher(
                "my-applications.jsp"
        ).forward(
                request,
                response
        );
    }
}