<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String fullName = (String) request.getAttribute("fullName");
    String username = (String) request.getAttribute("username");
    String email = (String) request.getAttribute("email");
    String role = (String) request.getAttribute("role");

    if (fullName == null) fullName = "";
    if (username == null) username = "";
    if (email == null) email = "";
    if (role == null) role = "";
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Admin Profile - License Management System
    </title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="style.css">

</head>

<body>


    <!-- =========================================
         NAVIGATION
    ========================================== -->

    <header class="navbar">

        <div class="logo">

            <div class="logo-icon">
                ⚖
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
         ADMIN PROFILE
    ========================================== -->

    <main class="admin-profile-page">


        <!-- Page Header -->

        <section class="admin-profile-header">

            <p class="admin-small-title">
                ADMINISTRATION
            </p>

            <h1>
                Admin Profile
            </h1>

            <p>
                View your administrator account information.
            </p>

        </section>


        <!-- Profile Card -->

        <section class="admin-profile-card">


            <!-- Profile Header -->

            <div class="admin-profile-top">

                <div class="admin-profile-avatar">

                    <i class="fa-solid fa-user-shield"></i>

                </div>

                <div>

                    <h2>
                        <%= fullName %>
                    </h2>

                    <p>
                        License Management System
                    </p>

                </div>

            </div>


            <!-- Account Information -->

            <div class="admin-profile-section">

                <h3>

                    <i class="fa-solid fa-user"></i>

                    Account Information

                </h3>


                <div class="admin-profile-grid">


                    <!-- Full Name -->

                    <div class="admin-profile-item">

                        <span>
                            Full Name
                        </span>

                        <strong>
                            <%= fullName %>
                        </strong>

                    </div>


                    <!-- Username -->

                    <div class="admin-profile-item">

                        <span>
                            Username
                        </span>

                        <strong>
                            <%= username %>
                        </strong>

                    </div>


                    <!-- Email -->

                    <div class="admin-profile-item">

                        <span>
                            Email
                        </span>

                        <strong>
                            <%= email %>
                        </strong>

                    </div>


                    <!-- Account Type -->

                    <div class="admin-profile-item">

                        <span>
                            Account Type
                        </span>

                        <strong>
                            Administrator
                        </strong>

                    </div>


                    <!-- Account Status -->

                    <div class="admin-profile-item">

                        <span>
                            Account Status
                        </span>

                        <strong class="profile-active">
                            Active
                        </strong>

                    </div>


                    <!-- Role -->

                    <div class="admin-profile-item">

                        <span>
                            Role
                        </span>

                        <strong>
                            <%= role %>
                        </strong>

                    </div>


                </div>

            </div>


            <!-- Profile Actions -->

           <div class="admin-profile-actions">

    <a
        href="admin-profile-edit"
        class="primary-btn"
        style="text-decoration: none;"
    >
        <i class="fa-solid fa-pen"></i>
        Edit Profile
    </a>

    <a
    href="admin-password-change"
    class="secondary-btn"
    style="text-decoration: none;"
>
    <i class="fa-solid fa-key"></i>
    Change Password
</a>
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


    <script src="script.js?v=20260915"></script>

</body>

</html>