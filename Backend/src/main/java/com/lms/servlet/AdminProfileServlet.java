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

@WebServlet("/admin-profile")
public class AdminProfileServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get current session
        HttpSession session =
                request.getSession(false);

        // Check login
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

        // Get logged-in admin ID
        int userId =
                (Integer) session.getAttribute("userId");

        String sql =
                "SELECT id, full_name, username, email, role " +
                "FROM users " +
                "WHERE id = ?";

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

            try (
                ResultSet resultSet =
                        statement.executeQuery()
            ) {

                if (resultSet.next()) {

                    request.setAttribute(
                            "userId",
                            resultSet.getInt("id")
                    );

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

                    request.setAttribute(
                            "role",
                            resultSet.getString("role")
                    );

                    request.getRequestDispatcher(
                            "admin-profile.jsp"
                    ).forward(
                            request,
                            response
                    );

                } else {

                    response.sendRedirect(
                            "admin-login.html"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error loading admin profile: "
                    + e.getMessage()
            );
        }
    }
}