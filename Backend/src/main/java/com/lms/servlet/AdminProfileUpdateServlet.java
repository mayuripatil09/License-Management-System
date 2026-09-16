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

@WebServlet("/admin-profile-update")
public class AdminProfileUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(
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

        // Get updated values
        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        // Basic validation
        if (fullName == null ||
            fullName.trim().isEmpty() ||
            email == null ||
            email.trim().isEmpty()) {

            response.sendRedirect(
                    "admin-profile?error=empty"
            );

            return;
        }

        fullName = fullName.trim();
        email = email.trim();

        // Basic email validation
        if (!email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
        )) {

            response.sendRedirect(
                    "admin-profile?error=email"
            );

            return;
        }

        String sql =
                "UPDATE users " +
                "SET full_name = ?, email = ? " +
                "WHERE id = ? " +
                "AND role = 'ADMIN'";

        try (
            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(1, fullName);
            statement.setString(2, email);
            statement.setInt(3, userId);

            int rowsUpdated =
                    statement.executeUpdate();

            if (rowsUpdated > 0) {

                // Update session information
                session.setAttribute(
                        "fullName",
                        fullName
                );

                session.setAttribute(
                        "email",
                        email
                );

                response.sendRedirect(
                        "admin-profile?updated=true"
                );

            } else {

                response.sendRedirect(
                        "admin-profile?error=notfound"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error updating admin profile: "
                    + e.getMessage()
            );
        }
    }
}