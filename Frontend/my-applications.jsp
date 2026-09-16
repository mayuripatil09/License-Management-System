<%
    java.util.List<java.util.Map<String, String>> applications =
            (java.util.List<java.util.Map<String, String>>)
            request.getAttribute("applications");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Applications - License Management System</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="style.css">

</head>

<body>

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

        <a href="my-applications.jsp">
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


<main class="track-page">

    <div class="track-container">


        <div class="track-heading">

            <p class="hero-small-title">
                APPLICATION HISTORY
            </p>

            <h1>
                My <span>Applications.</span>
            </h1>

            <p>
                View all your submitted license applications
                and their current status.
            </p>

        </div>


        <div class="application-result"
             style="display: block;">

            <div class="track-result-header">

                <div class="track-search-icon">

                    <i class="fa-solid fa-folder-open"></i>

                </div>

                <div>

                    <h2>
                        Submitted Applications
                    </h2>

                    <p>
                        Your application history from the LMS database.
                    </p>

                </div>

            </div>


            <div style="overflow-x: auto; margin-top: 25px;">

                <table style="width: 100%; border-collapse: collapse;">

                    <thead>

                        <tr>

                            <th style="padding: 14px; text-align: left;">
                                Application ID
                            </th>

                            <th style="padding: 14px; text-align: left;">
                                License Type
                            </th>

                            <th style="padding: 14px; text-align: left;">
                                Application Date
                            </th>

                            <th style="padding: 14px; text-align: left;">
                                Status
                            </th>

                            <th style="padding: 14px; text-align: left;">
                                Action
                            </th>

                        </tr>

                    </thead>


                    <tbody>

<%
    if (applications != null && !applications.isEmpty()) {

        for (java.util.Map<String, String> app : applications) {
%>

                        <tr>

                            <td style="padding: 14px;">
                                <strong>
                                    <%= app.get("applicationNumber") %>
                                </strong>
                            </td>


                            <td style="padding: 14px;">
                                <%= app.get("licenseType") %>
                            </td>


                            <td style="padding: 14px;">
                                <%= app.get("applicationDate") %>
                            </td>


                            <td style="padding: 14px;">

                                <strong>
                                    <%= app.get("status") %>
                                </strong>

                            </td>


                            <td style="padding: 14px;">

                                <a
                                    class="primary-btn"
                                    href="track?applicationId=<%= app.get("applicationNumber") %>"
                                    style="text-decoration: none;"
                                >
                                    View
                                </a>

                            </td>

                        </tr>

<%
        }

    } else {
%>

                        <tr>

                            <td
                                colspan="5"
                                style="padding: 40px; text-align: center;"
                            >

                                <i class="fa-solid fa-file-circle-question"
                                   style="font-size: 35px;">
                                </i>

                                <h3>
                                    No Applications Found
                                </h3>

                                <p>
                                    You have not submitted any license applications yet.
                                </p>

                                <br>

                                <a
                                    href="apply-license.html"
                                    class="primary-btn"
                                    style="text-decoration: none;"
                                >
                                    Apply for a License
                                </a>

                            </td>

                        </tr>

<%
    }
%>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</main>


<div class="copyright">

    © 2026 License Management System.
    All rights reserved.

</div>

</body>

</html>