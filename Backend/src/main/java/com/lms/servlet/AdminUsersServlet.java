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

@WebServlet("/admin-users")
public class AdminUsersServlet extends HttpServlet {

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

        List<Map<String, String>> users =
                new ArrayList<>();

        String sql =
                "SELECT id, full_name, username, email, role " +
                "FROM users " +
                "ORDER BY id DESC";

        try (
            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            ResultSet resultSet =
                    statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Map<String, String> user =
                        new HashMap<>();

                user.put(
                        "id",
                        String.valueOf(
                                resultSet.getInt("id")
                        )
                );

                user.put(
                        "fullName",
                        resultSet.getString("full_name")
                );

                user.put(
                        "username",
                        resultSet.getString("username")
                );

                user.put(
                        "email",
                        resultSet.getString("email")
                );

                user.put(
                        "role",
                        resultSet.getString("role")
                );

                users.add(user);
            }

            request.setAttribute(
                    "users",
                    users
            );

            request.getRequestDispatcher(
                    "admin-users.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println(
                    "Error loading users: "
                    + e.getMessage()
            );
        }
    }
}