<%
    String applicationNumber =
            (String) request.getAttribute("applicationNumber");

    String fullName =
            (String) request.getAttribute("fullName");

    String dob =
            (String) request.getAttribute("dob");

    String licenseType =
            (String) request.getAttribute("licenseType");

    String applicationDate =
            (String) request.getAttribute("applicationDate");

    String status =
            (String) request.getAttribute("status");

    Boolean found =
            (Boolean) request.getAttribute("found");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Application Result - License Management System
    </title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="style.css">

    <style>

        /* =========================================
           APPLICATION DETAILS TABLE
        ========================================== */

       .application-details {
    width: 100%;
    margin-top: 25px;
    display: block;
}

.application-table {
    width: 100%;
    min-width: 100%;
}
        .application-table {
            width: 100%;
            border-collapse: collapse;
            background: #fffdf9;
            border: 1px solid #dfcda9;
            border-radius: 10px;
            overflow: hidden;
        }

        .application-table tr {
            border-bottom: 1px solid #e4d7bd;
        }

        .application-table tr:last-child {
            border-bottom: none;
        }

        .application-table th {
            width: 35%;
            padding: 18px 20px;
            text-align: left;
            background: #f3e8d3;
            color: #443b30;
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .application-table td {
            padding: 18px 20px;
            color: #443b30;
            font-size: 16px;
            background: #fffdf9;
        }

        .application-table td strong {
            font-weight: 600;
        }

        /* =========================================
           STATUS
        ========================================== */

        .status-pending {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            background: #f3e3c5;
            color: #9a6915;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .status-approved {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            background: #dcefdc;
            color: #2f6b35;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .status-rejected {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            background: #f4dada;
            color: #9b3030;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
        }

        /* =========================================
           MOBILE RESPONSIVE
        ========================================== */

        @media (max-width: 700px) {

            .application-table th,
            .application-table td {
                padding: 14px 12px;
                font-size: 13px;
            }

            .application-table th {
                width: 40%;
            }

        }

    </style>

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
            onclick="window.location.href='index.html'">

            Logout

        </button>

    </div>

</header>



<!-- =========================================
     APPLICATION STATUS PAGE
========================================== -->

<main class="track-page">

    <div class="track-container">


        <!-- =====================================
             PAGE HEADING
        ====================================== -->

        <div class="track-heading">

            <p class="hero-small-title">
                APPLICATION STATUS
            </p>

            <h1>

                Application
                <span>Details.</span>

            </h1>

            <p>

                View the current status of your
                license application.

            </p>

        </div>



<%
    if (Boolean.TRUE.equals(found)) {
%>


        <!-- =====================================
             APPLICATION RESULT
        ====================================== -->

        <div class="application-result"
             style="display: block;">


            <!-- Result Header -->

            <div class="track-result-header">

                <div class="track-search-icon">

                    <i class="fa-solid fa-file-circle-check"></i>

                </div>


                <div>

                    <h2>
                        Application Details
                    </h2>

                    <p>
                        Your application information is shown below.
                    </p>

                </div>

            </div>



            <!-- =================================
                 APPLICATION DETAILS TABLE
            ================================== -->

            <div class="application-details">

                <table class="application-table">

                    <tbody>


                        <!-- Application ID -->

                        <tr>

                            <th>
                                Application ID
                            </th>

                            <td>

                                <strong>
                                    <%= applicationNumber %>
                                </strong>

                            </td>

                        </tr>



                        <!-- Applicant Name -->

                        <tr>

                            <th>
                                Applicant Name
                            </th>

                            <td>

                                <strong>
                                    <%= fullName %>
                                </strong>

                            </td>

                        </tr>



                        <!-- Date of Birth -->

                        <tr>

                            <th>
                                Date of Birth
                            </th>

                            <td>

                                <strong>
                                    <%= dob %>
                                </strong>

                            </td>

                        </tr>



                        <!-- License Type -->

                        <tr>

                            <th>
                                License Type
                            </th>

                            <td>

                                <strong>
                                    <%= licenseType %>
                                </strong>

                            </td>

                        </tr>



                        <!-- Application Date -->

                        <tr>

                            <th>
                                Application Date
                            </th>

                            <td>

                                <strong>
                                    <%= applicationDate %>
                                </strong>

                            </td>

                        </tr>



                        <!-- Status -->

                        <tr>

                            <th>
                                Status
                            </th>

                            <td>

<%
    if ("APPROVED".equalsIgnoreCase(status)) {
%>

                                <strong class="status-approved">
                                    <%= status %>
                                </strong>

<%
    } else if ("REJECTED".equalsIgnoreCase(status)) {
%>

                                <strong class="status-rejected">
                                    <%= status %>
                                </strong>

<%
    } else {
%>

                                <strong class="status-pending">
                                    <%= status %>
                                </strong>

<%
    }
%>

                            </td>

                        </tr>


                    </tbody>

                </table>

            </div>


        </div>


<%
    } else {
%>


        <!-- =====================================
             APPLICATION NOT FOUND
        ====================================== -->

        <div class="track-empty"
             style="display: block;">

            <div class="track-empty-icon">

                <i class="fa-solid fa-circle-exclamation"></i>

            </div>


            <h2>
                Application Not Found
            </h2>


            <p>

                No application was found with the entered
                Application ID.

            </p>


            <br>


            <a href="track-application.html"
               class="primary-btn">

                Try Again

            </a>

        </div>


<%
    }
%>


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