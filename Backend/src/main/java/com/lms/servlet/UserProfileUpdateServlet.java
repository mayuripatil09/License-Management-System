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

@WebServlet("/user-profile-update")
public class UserProfileUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(
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

        // Normal users only
        String role =
                (String) session.getAttribute("role");

        if ("ADMIN".equalsIgnoreCase(role)) {

            response.sendRedirect("admin-profile");
            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        // Basic validation
        if (fullName == null ||
            email == null ||
            fullName.trim().isEmpty() ||
            email.trim().isEmpty()) {

            response.sendRedirect(
                    "user-profile-edit?error=empty"
            );

            return;
        }

        fullName = fullName.trim();
        email = email.trim();

        // Basic email validation
        if (!email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {

            response.sendRedirect(
                    "user-profile-edit?error=email"
            );

            return;
        }

        String sql =
                "UPDATE users " +
                "SET full_name = ?, email = ? " +
                "WHERE id = ? AND role <> 'ADMIN'";

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
                        "user-profile?updated=true"
                );

            } else {

                response.sendRedirect(
                        "user-profile-edit?error=failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error updating profile: "
                    + e.getMessage()
            );
        }
    }
}