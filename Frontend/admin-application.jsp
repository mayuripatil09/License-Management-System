<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Applications - Admin | License Management System</title>

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

            <a href="http://localhost:8080/lms/admin-applications">
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
         APPLICATIONS PAGE
    ========================================== -->

    <main class="admin-applications-page">


        <!-- Page Heading -->

        <section class="admin-applications-header">

            <p class="admin-small-title">
                ADMINISTRATION
            </p>

            <h1>
                License Applications
            </h1>

            <p>
                Review and manage license applications submitted
                by registered users.
            </p>

        </section>



        <!-- Search and Filter -->

        <section class="application-controls">

            <div class="application-search">

                <i class="fa-solid fa-magnifying-glass"></i>

                <input
                    type="text"
                    id="applicationSearch"
                    placeholder="Search by application ID or applicant name"
                >

            </div>


            <select id="applicationStatusFilter">

                <option value="ALL">
                    All Status
                </option>

                <option value="PENDING">
                    Pending
                </option>

                <option value="APPROVED">
                    Approved
                </option>

                <option value="REJECTED">
                    Rejected
                </option>

            </select>

        </section>



        <!-- Applications Table -->

        <section class="applications-table-card">

            <div class="table-heading">

                <h2>
                    All Applications
                </h2>

                <span>
                    Manage submitted applications
                </span>

            </div>


            <div class="table-wrapper">

                <table>

                    <thead>

                        <tr>

                            <th>
                                Application ID
                            </th>

                            <th>
                                Applicant Name
                            </th>

                            <th>
                                License Type
                            </th>

                            <th>
                                Application Date
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
                        List<Map<String, String>> applications =
                            (List<Map<String, String>>)
                            request.getAttribute("applications");

                        if (applications != null &&
                            !applications.isEmpty()) {

                            for (Map<String, String> app : applications) {

                                String applicationNumber =
                                    app.get("applicationNumber");

                                String fullName =
                                    app.get("fullName");

                                String licenseType =
                                    app.get("licenseType");

                                String applicationDate =
                                    app.get("applicationDate");

                                String status =
                                    app.get("status");

                                String statusClass =
                                    "pending";

                                if ("APPROVED".equalsIgnoreCase(status)) {

                                    statusClass = "approved";

                                } else if ("REJECTED".equalsIgnoreCase(status)) {

                                    statusClass = "rejected";

                                }
                    %>

                        <tr>

                            <td>
                                <%= applicationNumber %>
                            </td>

                            <td>
                                <%= fullName %>
                            </td>

                            <td>
                                <%= licenseType %>
                            </td>

                            <td>
                                <%= applicationDate %>
                            </td>

                            <td>

                                <span class="application-status <%= statusClass %>">
                                    <%= status %>
                                </span>

                            </td>

                            <td>

                                <button
                                    class="table-view-btn"
                                    onclick="window.location.href='admin-application-details?applicationId=<%= applicationNumber %>'"
                                >
                                    View Details
                                </button>

                            </td>

                        </tr>

                    <%
                            }

                        } else {
                    %>

                        <tr>

                            <td
                                colspan="6"
                                style="text-align: center; padding: 40px;"
                            >
                                No applications found.
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



    <script src="script.js"></script>

</body>

</html>