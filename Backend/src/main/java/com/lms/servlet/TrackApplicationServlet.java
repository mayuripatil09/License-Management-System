package com.lms.servlet;

import com.lms.util.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/track")
public class TrackApplicationServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String applicationId =
                request.getParameter("applicationId");

        if (applicationId == null ||
            applicationId.trim().isEmpty()) {

            request.setAttribute(
                    "found",
                    false
            );

            request.getRequestDispatcher(
                    "track-result.jsp"
            ).forward(request, response);

            return;
        }


        String sql =
                "SELECT application_number, " +
                "full_name, dob, license_type, " +
                "application_date, status " +
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
                    applicationId.trim()
            );


            ResultSet resultSet =
                    statement.executeQuery();


            if (resultSet.next()) {

                request.setAttribute(
                        "found",
                        true
                );

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
                        resultSet.getString(
                                "dob"
                        )
                );

                request.setAttribute(
                        "licenseType",
                        resultSet.getString(
                                "license_type"
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
                        resultSet.getString(
                                "status"
                        )
                );


            } else {

                request.setAttribute(
                        "found",
                        false
                );
            }


            request.getRequestDispatcher(
                    "track-result.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "found",
                    false
            );

            request.getRequestDispatcher(
                    "track-result.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}