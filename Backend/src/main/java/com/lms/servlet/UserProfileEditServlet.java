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

@WebServlet("/user-profile-edit")
public class UserProfileEditServlet extends HttpServlet {

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

            response.sendRedirect("login.html");
            return;
        }

        // Admin should use admin profile
        String role =
                (String) session.getAttribute("role");

        if ("ADMIN".equalsIgnoreCase(role)) {

            response.sendRedirect("admin-profile");
            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        String sql =
                "SELECT full_name, username, email " +
                "FROM users " +
                "WHERE id = ?";

        try (
            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(1, userId);

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                if (resultSet.next()) {

                    request.setAttribute(
                            "fullName",
                            resultSet.getString("full_name")
                    );

                    request.setAttribute(
                            "username",
                            resultSet.getString("username")
                    );

                    request.setAttribute(
                            "email",
                            resultSet.getString("email")
                    );

                    request.getRequestDispatcher(
                            "user-profile-edit.jsp"
                    ).forward(
                            request,
                            response
                    );

                } else {

                    response.sendRedirect(
                            "user-profile"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error loading edit profile: "
                    + e.getMessage()
            );
        }
    }
}