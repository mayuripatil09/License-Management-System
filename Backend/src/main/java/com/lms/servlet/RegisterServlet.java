package com.lms.servlet;

import com.lms.util.DatabaseConnection;
import com.lms.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String hashedPassword =
        PasswordUtil.hashPassword(password);

        String sql = """
                INSERT INTO users
                (full_name, username, email, password, role)
                VALUES (?, ?, ?, ?, 'USER')
                """;

        try (
            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(1, fullName);
            statement.setString(2, username);
            statement.setString(3, email);
            statement.setString(4, hashedPassword);

            int result = statement.executeUpdate();

            if (result > 0) {

    response.sendRedirect(
            "registration-success.html"
    );

} else {

    response.getWriter().println(
            "Registration failed!"
    );
}
        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error during registration: "
                    + e.getMessage()
            );
        }
    }
}
