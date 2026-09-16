<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Integer userId =
            (Integer) request.getAttribute("userId");

    String fullName =
            (String) request.getAttribute("fullName");

    String username =
            (String) request.getAttribute("username");

    String email =
            (String) request.getAttribute("email");

    String role =
            (String) request.getAttribute("role");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        User Details - Admin | License Management System
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
     USER DETAILS
========================================== -->

<main class="admin-users-page">

    <section class="admin-users-header">

        <p class="admin-small-title">
            ADMINISTRATION
        </p>

        <h1>
            User Details
        </h1>

        <p>
            View information about the registered user account.
        </p>

    </section>



    <!-- =========================================
         USER CARD
    ========================================== -->

    <section class="application-details-card">


        <div class="application-details-top">

            <div>

                <span class="details-label">
                    USER ID
                </span>

                <h2>
                    <%= userId %>
                </h2>

            </div>


            <span class="application-status approved">
                ACTIVE
            </span>

        </div>



        <!-- =====================================
             USER INFORMATION
        ====================================== -->

        <div class="details-section">

            <h3>

                <i class="fa-solid fa-user"></i>

                User Information

            </h3>


            <div class="details-grid">


                <!-- Full Name -->

                <div class="detail-item">

                    <span>
                        Full Name
                    </span>

                    <strong>
                        <%= fullName %>
                    </strong>

                </div>



                <!-- Username -->

                <div class="detail-item">

                    <span>
                        Username
                    </span>

                    <strong>
                        <%= username %>
                    </strong>

                </div>



                <!-- Email -->

                <div class="detail-item">

                    <span>
                        Email Address
                    </span>

                    <strong>
                        <%= email %>
                    </strong>

                </div>



                <!-- Role -->

                <div class="detail-item">

                    <span>
                        Role
                    </span>

                    <strong>
                        <%= role %>
                    </strong>

                </div>


            </div>

        </div>



        <!-- =====================================
             ACCOUNT STATUS
        ====================================== -->

        <div class="details-section">

            <h3>

                <i class="fa-solid fa-shield-halved"></i>

                Account Status

            </h3>


            <p class="decision-description">

                This account is currently active in the
                License Management System.

            </p>


            <div class="decision-message approved-message">

                <i class="fa-solid fa-circle-check"></i>

                Account Active

            </div>

        </div>



        <!-- =====================================
             BACK BUTTON
        ====================================== -->

        <div class="details-back">

            <button
                type="button"
                class="secondary-btn"
                onclick="window.location.href='admin-users'"
            >

                ← Back to Users

            </button>

        </div>


    </section>

</main>



<!-- =========================================
     FOOTER
========================================= -->

<div class="copyright">

    © 2026 License Management System.
    All rights reserved.

</div>


</body>

</html>