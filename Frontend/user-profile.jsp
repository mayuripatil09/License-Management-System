<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Profile - License Management System</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #faf6ee;
            color: #2d261f;
            min-height: 100vh;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            height: 82px;
            background: #fffdf9;
            border-bottom: 1px solid #eadfcf;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;

            box-shadow: 0 2px 10px rgba(80, 60, 30, 0.05);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            width: 42px;
            height: 42px;

            border-radius: 50%;

            background: #b77a1b;
            color: white;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 20px;
        }

        .logo-text {
            font-family: Georgia, "Times New Roman", serif;
            font-size: 20px;
            font-weight: bold;
            color: #1f1a15;
        }

        .logo-subtitle {
            font-size: 12px;
            color: #6f665c;
            margin-top: 2px;
        }

        .navbar nav {
            display: flex;
            align-items: center;
            gap: 34px;
        }

        .navbar nav a {
            text-decoration: none;
            color: #302a24;
            font-size: 14px;
            transition: 0.2s;
        }

        .navbar nav a:hover {
            color: #b77a1b;
        }

        /* ================= MAIN ================= */

        .profile-page {
            width: 86%;
            max-width: 1250px;

            margin: 0 auto;
            padding: 58px 0 80px;
        }

        .profile-heading {
            margin-bottom: 30px;
        }

        .section-label {
            color: #ad721a;
            font-size: 12px;
            letter-spacing: 4px;
            font-weight: 500;
            margin-bottom: 12px;
        }

        .profile-heading h1 {
            font-family: Georgia, "Times New Roman", serif;

            font-size: 42px;
            font-weight: 400;

            color: #201a15;

            margin-bottom: 10px;
        }

        .profile-heading h1 span {
            color: #b77a1b;
        }

        .profile-heading p {
            color: #6c6258;
            font-size: 15px;
        }

        /* ================= PROFILE CARD ================= */

        .profile-card {
            background: #fffdf9;

            border: 1px solid #e5d7c3;
            border-radius: 18px;

            overflow: hidden;

            box-shadow:
                0 15px 40px rgba(77, 57, 30, 0.08);
        }

        /* ================= CARD HEADER ================= */

        .profile-card-header {
            min-height: 120px;

            background:
                linear-gradient(
                    90deg,
                    #f1e3ca,
                    #f8eddc
                );

            border-bottom: 1px solid #e0cfb5;

            display: flex;
            align-items: center;

            padding: 28px 32px;

            gap: 18px;
        }

        .profile-icon {
            width: 68px;
            height: 68px;

            border-radius: 50%;

            background: #b77a1b;
            color: white;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 27px;

            box-shadow: 0 5px 15px rgba(100, 65, 20, 0.15);
        }

        .profile-card-header h2 {
            font-family: Georgia, "Times New Roman", serif;

            font-size: 27px;
            font-weight: 400;

            color: #2b2118;

            margin-bottom: 5px;
        }

        .profile-card-header p {
            color: #776b5e;
            font-size: 14px;
        }

        /* ================= CONTENT ================= */

        .profile-content {
            padding: 38px 38px 35px;
        }

        .profile-content > .section-label {
            margin-bottom: 20px;
        }

        /* ================= INFORMATION GRID ================= */

        .profile-table {
            width: 100%;

            border: 1px solid #e5d8c7;

            background: #fffdf9;
        }

        .profile-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
        }

        .profile-row + .profile-row {
            border-top: 1px solid #e5d8c7;
        }

        .profile-item {
            min-height: 92px;

            padding: 20px;

            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .profile-item + .profile-item {
            border-left: 1px solid #e5d8c7;
        }

        .profile-item span {
            color: #817568;
            font-size: 12px;
            margin-bottom: 7px;
        }

        .profile-item strong {
            color: #282019;
            font-size: 15px;
            font-weight: 500;
        }

        .profile-item .active-status {
            color: #a96f13;
            font-weight: 600;
        }

        /* ================= BUTTONS ================= */

        .profile-actions {
            display: flex;
            gap: 14px;

            margin-top: 28px;
        }

        .primary-btn,
        .secondary-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            gap: 9px;

            min-width: 150px;

            padding: 13px 20px;

            border-radius: 7px;

            font-size: 14px;

            text-decoration: none;

            transition: all 0.2s ease;

            cursor: pointer;
        }

        .primary-btn {
            background: #b77a1b;
            color: white;

            border: 1px solid #b77a1b;
        }

        .primary-btn:hover {
            background: #9d6614;
            border-color: #9d6614;
            transform: translateY(-1px);
        }

        .secondary-btn {
            background: #fffdf9;
            color: #9f6814;

            border: 1px solid #b77a1b;
        }

        .secondary-btn:hover {
            background: #f8eddb;
            transform: translateY(-1px);
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 800px) {

            .navbar {
                padding: 0 25px;
            }

            .navbar nav {
                gap: 15px;
            }

            .profile-page {
                width: 92%;
                padding-top: 40px;
            }

            .profile-heading h1 {
                font-size: 34px;
            }

            .profile-row {
                grid-template-columns: 1fr;
            }

            .profile-item + .profile-item {
                border-left: none;
                border-top: 1px solid #e5d8c7;
            }

        }

    </style>

</head>


<body>

<header class="navbar">

    <div class="logo">

        <div class="logo-icon">
            <i class="fa-solid fa-scale-balanced"></i>
        </div>

        <div>
            <div class="logo-text">LMS</div>
            <div class="logo-subtitle">
                License Management System
            </div>
        </div>

    </div>


    <nav>

        <a href="index.html">Home</a>

        <a href="user-dashboard.html">
            Dashboard
        </a>

        <a href="my-applications">
            My Applications
        </a>

        <a href="user-profile">
            Profile
        </a>

    </nav>

</header>


<main class="profile-page">


    <div class="profile-heading">

        <div class="section-label">
            MY PROFILE
        </div>

        <h1>
            Your Account,
            <span>Your Details.</span>
        </h1>

        <p>
            View and manage your personal account information.
        </p>

    </div>


    <section class="profile-card">


        <div class="profile-card-header">

            <div class="profile-icon">
                <i class="fa-solid fa-user"></i>
            </div>

            <div>

                <h2>
                    <%= request.getAttribute("fullName") %>
                </h2>

                <p>
                    License Applicant
                </p>

            </div>

        </div>


        <div class="profile-content">


            <div class="section-label">
                ACCOUNT INFORMATION
            </div>


            <div class="profile-table">


                <div class="profile-row">

                    <div class="profile-item">

                        <span>
                            Full Name
                        </span>

                        <strong>
                            <%= request.getAttribute("fullName") %>
                        </strong>

                    </div>


                    <div class="profile-item">

                        <span>
                            Username
                        </span>

                        <strong>
                            <%= request.getAttribute("username") %>
                        </strong>

                    </div>

                </div>


                <div class="profile-row">

                    <div class="profile-item">

                        <span>
                            Email Address
                        </span>

                        <strong>
                            <%= request.getAttribute("email") %>
                        </strong>

                    </div>


                    <div class="profile-item">

                        <span>
                            Account Type
                        </span>

                        <strong>
                            License Applicant
                        </strong>

                    </div>

                </div>


                <div class="profile-row">

                    <div class="profile-item">

                        <span>
                            Account Status
                        </span>

                        <strong class="active-status">
                            Active
                        </strong>

                    </div>


                    <div class="profile-item">

                        <span>
                            User ID
                        </span>

                        <strong>
                            <%= request.getAttribute("userId") %>
                        </strong>

                    </div>

                </div>


            </div>


            <div class="profile-actions">

                <a href="user-profile-edit"
                   class="primary-btn">

                    <i class="fa-solid fa-pen"></i>

                    Edit Profile

                </a>


                <a href="user-password-change"
                   class="secondary-btn">

                    <i class="fa-solid fa-lock"></i>

                    Change Password

                </a>

            </div>


        </div>

    </section>

</main>

</body>

</html>