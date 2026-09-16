<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    List<Map<String, String>> users =
            (List<Map<String, String>>) request.getAttribute("users");

    String deleted = request.getParameter("deleted");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Manage Users - Admin | License Management System
    </title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="style.css">

    <style>

        /* =========================================
           USER ACTION MESSAGES
        ========================================== */

        .user-message {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 14px 18px;
            border-radius: 10px;

            font-weight: 600;

            display: flex;
            align-items: center;
            gap: 10px;

            box-sizing: border-box;
        }

        .success-message {
            background: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }

        .error-message {
            background: #fff3e0;
            color: #b45309;
            border: 1px solid #f0c36a;
        }

    </style>

</head>


<body>


    <!-- =========================================
         SUCCESS / ERROR MESSAGES
    ========================================== -->

    <% if ("true".equals(deleted)) { %>

        <div class="user-message success-message">

            <i class="fa-solid fa-circle-check"></i>

            User deleted successfully.

        </div>

    <% } %>


    <% if ("applications".equals(error)) { %>

        <div class="user-message error-message">

            <i class="fa-solid fa-triangle-exclamation"></i>

            User cannot be deleted because this user has existing license applications.

        </div>

    <% } %>


    <% if ("admin".equals(error)) { %>

        <div class="user-message error-message">

            <i class="fa-solid fa-shield-halved"></i>

            Admin accounts cannot be deleted.

        </div>

    <% } %>


    <% if ("self".equals(error)) { %>

        <div class="user-message error-message">

            <i class="fa-solid fa-lock"></i>

            You cannot delete your own admin account.

        </div>

    <% } %>


    <% if ("notfound".equals(error)) { %>

        <div class="user-message error-message">

            <i class="fa-solid fa-circle-exclamation"></i>

            User not found.

        </div>

    <% } %>


    <% if ("invalid".equals(error)) { %>

        <div class="user-message error-message">

            <i class="fa-solid fa-circle-exclamation"></i>

            Invalid user ID.

        </div>

    <% } %>


    <!-- =========================================
         NAVIGATION
    ========================================== -->

    <header class="navbar">

        <div class="logo">

            <div class="logo-icon">
                <i class="fa-solid fa-scale-balanced"></i>
            </div>

            <div class="logo-text">

                <h2>LMS</h2>

                <p>
                    License Management System
                </p>

            </div>

        </div>


        <nav>

            <a href="admin-dashboard.html">
                Dashboard
            </a>

            <a href="admin-applications">
                Applications
            </a>

            <a href="admin-users">
                Users
            </a>

            <a href="admin-profile">
                Profile
            </a>

        </nav>


        <div class="nav-buttons">

            <button
                class="login-btn"
                onclick="window.location.href='index.html'"
            >
                Logout
            </button>

        </div>

    </header>


    <!-- =========================================
         MANAGE USERS
    ========================================== -->

    <main class="admin-users-page">


        <!-- Page Header -->

        <section class="admin-users-header">

            <p class="admin-small-title">
                ADMINISTRATION
            </p>

            <h1>
                Manage Users
            </h1>

            <p>
                View and manage users registered with the
                License Management System.
            </p>

        </section>


        <!-- Search -->

        <section class="users-controls">

            <div class="users-search">

                <i class="fa-solid fa-magnifying-glass"></i>

                <input
                    type="text"
                    id="userSearch"
                    placeholder="Search by name, username or email"
                >

            </div>

        </section>


        <!-- Users Table -->

        <section class="users-table-card">

            <div class="users-table-heading">

                <h2>
                    Registered Users
                </h2>

                <span>
                    Manage registered user accounts
                </span>

            </div>


            <div class="users-table-wrapper">

                <table>

                    <thead>

                        <tr>

                            <th>
                                ID
                            </th>

                            <th>
                                Full Name
                            </th>

                            <th>
                                Username
                            </th>

                            <th>
                                Email
                            </th>

                            <th>
                                Role
                            </th>

                            <th>
                                Status
                            </th>

                            <th>
                                Action
                            </th>

                        </tr>

                    </thead>


                    <tbody>

                    <%

                        if (users != null && !users.isEmpty()) {

                            for (Map<String, String> user : users) {

                                String id =
                                        user.get("id");

                                String fullName =
                                        user.get("fullName");

                                String username =
                                        user.get("username");

                                String email =
                                        user.get("email");

                                String role =
                                        user.get("role");

                    %>


                        <tr>


                            <td>
                                <%= id %>
                            </td>


                            <td>
                                <%= fullName %>
                            </td>


                            <td>
                                <%= username %>
                            </td>


                            <td>
                                <%= email %>
                            </td>


                            <td>

                                <span class="user-role">
                                    <%= role %>
                                </span>

                            </td>


                            <td>

                                <span class="user-status active">
                                    Active
                                </span>

                            </td>


                            <td>


                                <!-- =================================
                                     VIEW USER
                                ================================== -->

                                <a
                                    href="admin-user-details?userId=<%= id %>"
                                    class="user-view-btn"
                                >

                                    <i class="fa-solid fa-eye"></i>

                                    View

                                </a>


                                <!-- =================================
                                     DELETE USER
                                ================================== -->

                                <form
                                    action="admin-user-delete"
                                    method="post"
                                    style="display:inline;"
                                    onsubmit="return confirm('Are you sure you want to delete this user?');"
                                >

                                    <input
                                        type="hidden"
                                        name="userId"
                                        value="<%= id %>"
                                    >


                                    <button
                                        type="submit"
                                        class="user-delete-btn"
                                    >

                                        <i class="fa-solid fa-trash"></i>

                                        Delete

                                    </button>

                                </form>


                            </td>

                        </tr>


                    <%

                            }

                        } else {

                    %>


                        <tr>

                            <td
                                colspan="7"
                                style="text-align: center; padding: 40px;"
                            >

                                No registered users found.

                            </td>

                        </tr>


                    <%

                        }

                    %>


                    </tbody>

                </table>

            </div>

        </section>


    </main>


    <!-- =========================================
         FOOTER
    ========================================== -->

    <div class="copyright">

        © 2026 License Management System.

        All rights reserved.

    </div>


    <!-- =========================================
         JAVASCRIPT
    ========================================== -->

    <script src="script.js?v=20260915"></script>


</body>

</html>