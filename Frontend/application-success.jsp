<%
    String applicationNumber =
            (String) session.getAttribute("applicationNumber");

    String applicationName =
            (String) session.getAttribute("applicationName");

    String applicationLicenseType =
            (String) session.getAttribute("applicationLicenseType");

    String applicationDate =
            (String) session.getAttribute("applicationDate");

    String applicationStatus =
            (String) session.getAttribute("applicationStatus");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Application Submitted - License Management System</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet" href="style.css">

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

            <a href="index.html">
                Home
            </a>

            <a href="user-dashboard.html">
                Dashboard
            </a>

            <a href="track-application.html">
                My Applications
            </a>

            <a href="profile.html">
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
         SUCCESS PAGE
    ========================================== -->

    <main class="success-page">

        <div class="success-card">

            <!-- Success Icon -->

            <div class="success-icon">

                <i class="fa-solid fa-check"></i>

            </div>


            <!-- Heading -->

            <p class="success-label">
                APPLICATION SUBMITTED
            </p>

            <h1>
                Application Submitted
                <span>Successfully.</span>
            </h1>

            <p class="success-message">

                Your license application has been submitted
                successfully. Please keep your Application ID
                for tracking your application.

            </p>


            <!-- Application Details -->

            <div class="application-details">


                <!-- Application ID -->

                <div class="detail-item">

                    <span>
                        Application ID
                    </span>

                    <strong>
                        <%= applicationNumber %>
                    </strong>

                </div>


                <!-- Applicant Name -->

                <div class="detail-item">

                    <span>
                        Applicant Name
                    </span>

                    <strong>
                        <%= applicationName %>
                    </strong>

                </div>


                <!-- License Type -->

                <div class="detail-item">

                    <span>
                        License Type
                    </span>

                    <strong>
                        <%= applicationLicenseType %>
                    </strong>

                </div>


                <!-- Application Date -->

                <div class="detail-item">

                    <span>
                        Application Date
                    </span>

                    <strong>
                        <%= applicationDate %>
                    </strong>

                </div>


                <!-- Status -->

                <div class="detail-item">

                    <span>
                        Status
                    </span>

                    <strong class="status-pending">
                        <%= applicationStatus %>
                    </strong>

                </div>


            </div>


            <!-- Email Information -->

            <div class="email-notice">

                <i class="fa-solid fa-envelope"></i>

                <p>

                    A confirmation email containing your
                    Application ID and license details will
                    be sent to your registered email address.

                </p>

            </div>


            <!-- Buttons -->

            <div class="success-buttons">

                <button
                    class="primary-btn"
                    onclick="window.location.href='track-application.html'"
                >
                    Track Application 
                </button>


                <button
                    class="secondary-btn"
                    onclick="window.location.href='user-dashboard.html'"
                >
                    Back to Dashboard
                </button>

            </div>


        </div>

    </main>


    <!-- =========================================
         FOOTER
    ========================================== -->

    <div class="copyright">

        © 2026 License Management System.
        All rights reserved.

    </div>


</body>

</html>