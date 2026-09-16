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

@WebServlet("/admin-user-details")
public class AdminUserDetailsServlet extends HttpServlet {

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

        String userId =
                request.getParameter("userId");

        if (userId == null ||
            userId.trim().isEmpty()) {

            response.sendRedirect("admin-users");
            return;
        }

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
                    Integer.parseInt(userId)
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
                            "admin-user-details.jsp"
                    ).forward(
                            request,
                            response
                    );

                } else {

                    response.sendRedirect(
                            "admin-users"
                    );
                }
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "admin-users"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error loading user details: "
                    + e.getMessage()
            );
        }
    }
}