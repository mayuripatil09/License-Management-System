<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Edit Profile - License Management System</title>

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

        /* NAVBAR */

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
            gap: 34px;
        }

        .navbar nav a {
            text-decoration: none;
            color: #302a24;
            font-size: 14px;
        }

        .navbar nav a:hover {
            color: #b77a1b;
        }

        /* MAIN */

        .edit-page {
            width: 86%;
            max-width: 900px;
            margin: 0 auto;
            padding: 60px 0 80px;
        }

        .heading {
            margin-bottom: 30px;
        }

        .section-label {
            color: #ad721a;
            font-size: 12px;
            letter-spacing: 4px;
            margin-bottom: 12px;
        }

        .heading h1 {
            font-family: Georgia, "Times New Roman", serif;
            font-size: 42px;
            font-weight: 400;
            color: #201a15;
        }

        .heading h1 span {
            color: #b77a1b;
        }

        .heading p {
            margin-top: 10px;
            color: #6c6258;
            font-size: 15px;
        }

        /* FORM CARD */

        .edit-card {
            background: #fffdf9;
            border: 1px solid #e5d7c3;
            border-radius: 18px;

            padding: 38px;

            box-shadow:
                0 15px 40px rgba(77, 57, 30, 0.08);
        }

        .form-title {
            font-family: Georgia, "Times New Roman", serif;
            font-size: 25px;
            font-weight: 400;

            color: #2b2118;

            margin-bottom: 28px;
        }

        /* FORM */

        .form-group {
            margin-bottom: 23px;
        }

        .form-group label {
            display: block;

            color: #675c51;

            font-size: 13px;
            font-weight: 600;

            margin-bottom: 8px;
        }

        .form-group input {
            width: 100%;

            padding: 13px 14px;

            border: 1px solid #d9cbb8;
            border-radius: 7px;

            background: #fffdf9;

            color: #29221c;

            font-size: 14px;

            outline: none;

            transition: 0.2s;
        }

        .form-group input:focus {
            border-color: #b77a1b;

            box-shadow:
                0 0 0 3px rgba(183, 122, 27, 0.10);
        }

        .form-group input[readonly] {
            background: #f3eee5;
            color: #817568;
            cursor: not-allowed;
        }

        .help-text {
            margin-top: 6px;
            font-size: 12px;
            color: #8a7e71;
        }

        /* BUTTONS */

        .form-actions {
            display: flex;
            gap: 14px;

            margin-top: 32px;
        }

        .save-btn,
        .cancel-btn {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            gap: 8px;

            padding: 13px 24px;

            border-radius: 7px;

            font-size: 14px;

            text-decoration: none;

            cursor: pointer;

            transition: 0.2s;
        }

        .save-btn {
            background: #b77a1b;
            color: white;

            border: 1px solid #b77a1b;
        }

        .save-btn:hover {
            background: #9d6614;
        }

        .cancel-btn {
            background: #fffdf9;
            color: #9f6814;

            border: 1px solid #b77a1b;
        }

        .cancel-btn:hover {
            background: #f8eddb;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 0 25px;
            }

            .navbar nav {
                gap: 15px;
            }

            .edit-page {
                width: 92%;
            }

            .edit-card {
                padding: 25px;
            }

            .heading h1 {
                font-size: 34px;
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


<main class="edit-page">


    <div class="heading">

        <div class="section-label">
            EDIT PROFILE
        </div>

        <h1>
            Update Your
            <span>Information.</span>
        </h1>

        <p>
            Update your personal account information below.
        </p>

    </div>


    <section class="edit-card">

        <h2 class="form-title">
            Account Information
        </h2>


        <form action="user-profile-update" method="post">


            <div class="form-group">

                <label for="fullName">
                    Full Name
                </label>

                <input
                    type="text"
                    id="fullName"
                    name="fullName"
                    value="<%= request.getAttribute("fullName") %>"
                    required
                >

            </div>


            <div class="form-group">

                <label for="username">
                    Username
                </label>

                <input
                    type="text"
                    id="username"
                    name="username"
                    value="<%= request.getAttribute("username") %>"
                    readonly
                >

                <div class="help-text">
                    Username cannot be changed.
                </div>

            </div>


            <div class="form-group">

                <label for="email">
                    Email Address
                </label>

                <input
                    type="email"
                    id="email"
                    name="email"
                    value="<%= request.getAttribute("email") %>"
                    required
                >

            </div>


            <div class="form-actions">

                <button
                    type="submit"
                    class="save-btn">

                    <i class="fa-solid fa-check"></i>

                    Save Changes

                </button>


                <a
                    href="user-profile"
                    class="cancel-btn">

                    <i class="fa-solid fa-xmark"></i>

                    Cancel

                </a>

            </div>


        </form>

    </section>

</main>

</body>

</html>