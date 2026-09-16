<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Change Password - License Management System</title>

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
        }

        .navbar nav a:hover {
            color: #b77a1b;
        }

        /* ================= MAIN ================= */

        .password-page {
            width: 86%;
            max-width: 850px;

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

        /* ================= CARD ================= */

        .password-card {
            background: #fffdf9;

            border: 1px solid #e5d7c3;

            border-radius: 18px;

            padding: 38px;

            box-shadow:
                0 15px 40px rgba(77, 57, 30, 0.08);
        }

        .card-header {
            display: flex;
            align-items: center;

            gap: 16px;

            margin-bottom: 30px;
        }

        .password-icon {
            width: 58px;
            height: 58px;

            border-radius: 50%;

            background: #f1e3ca;

            color: #b77a1b;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 23px;
        }

        .card-header h2 {
            font-family: Georgia, "Times New Roman", serif;

            font-size: 25px;
            font-weight: 400;

            color: #2b2118;
        }

        .card-header p {
            margin-top: 5px;

            color: #776b5e;

            font-size: 13px;
        }

        /* ================= FORM ================= */

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;

            color: #675c51;

            font-size: 13px;
            font-weight: 600;

            margin-bottom: 8px;
        }

        .password-input {
            position: relative;
        }

        .password-input input {
            width: 100%;

            padding: 13px 45px 13px 14px;

            border: 1px solid #d9cbb8;

            border-radius: 7px;

            background: #fffdf9;

            color: #29221c;

            font-size: 14px;

            outline: none;

            transition: 0.2s;
        }

        .password-input input:focus {
            border-color: #b77a1b;

            box-shadow:
                0 0 0 3px rgba(183, 122, 27, 0.10);
        }

        .toggle-password {
            position: absolute;

            right: 14px;
            top: 50%;

            transform: translateY(-50%);

            border: none;

            background: transparent;

            color: #887a6c;

            cursor: pointer;

            font-size: 15px;
        }

        .toggle-password:hover {
            color: #b77a1b;
        }

        .password-note {
            margin-top: 7px;

            color: #8a7e71;

            font-size: 12px;
        }

        /* ================= ERROR ================= */

        .error-message {
            margin-bottom: 20px;

            padding: 12px 14px;

            border-radius: 7px;

            background: #f9e6df;

            border: 1px solid #e6c2b5;

            color: #9b4c35;

            font-size: 13px;
        }

        /* ================= BUTTONS ================= */

        .form-actions {
            display: flex;

            gap: 14px;

            margin-top: 30px;
        }

        .save-btn,
        .cancel-btn {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            gap: 8px;

            padding: 13px 23px;

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

            .password-page {
                width: 92%;
            }

            .password-card {
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

            <div class="logo-text">
                LMS
            </div>

            <div class="logo-subtitle">
                License Management System
            </div>

        </div>

    </div>


    <nav>

        <a href="index.html">
            Home
        </a>

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


<main class="password-page">


    <div class="heading">

        <div class="section-label">
            SECURITY
        </div>

        <h1>
            Change Your
            <span>Password.</span>
        </h1>

        <p>
            Keep your account secure by updating your password regularly.
        </p>

    </div>


    <section class="password-card">


        <div class="card-header">

            <div class="password-icon">
                <i class="fa-solid fa-lock"></i>
            </div>

            <div>

                <h2>
                    Update Password
                </h2>

                <p>
                    Enter your current password and choose a new one.
                </p>

            </div>

        </div>


        <%
            String error = request.getParameter("error");

            if ("empty".equals(error)) {
        %>

            <div class="error-message">
                Please fill in all password fields.
            </div>

        <%
            } else if ("wrong".equals(error)) {
        %>

            <div class="error-message">
                Current password is incorrect.
            </div>

        <%
            } else if ("mismatch".equals(error)) {
        %>

            <div class="error-message">
                New password and confirmation password do not match.
            </div>

        <%
            } else if ("length".equals(error)) {
        %>

            <div class="error-message">
                New password must contain at least 6 characters.
            </div>

        <%
            } else if ("failed".equals(error)) {
        %>

            <div class="error-message">
                Password could not be changed. Please try again.
            </div>

        <%
            }
        %>


        <form action="user-password-change" method="post">


            <div class="form-group">

                <label for="currentPassword">
                    Current Password
                </label>

                <div class="password-input">

                    <input
                        type="password"
                        id="currentPassword"
                        name="currentPassword"
                        required
                    >

                    <button
                        type="button"
                        class="toggle-password"
                        onclick="togglePassword('currentPassword', this)">

                        <i class="fa-solid fa-eye"></i>

                    </button>

                </div>

            </div>


            <div class="form-group">

                <label for="newPassword">
                    New Password
                </label>

                <div class="password-input">

                    <input
                        type="password"
                        id="newPassword"
                        name="newPassword"
                        required
                    >

                    <button
                        type="button"
                        class="toggle-password"
                        onclick="togglePassword('newPassword', this)">

                        <i class="fa-solid fa-eye"></i>

                    </button>

                </div>

                <div class="password-note">
                    Password must contain at least 6 characters.
                </div>

            </div>


            <div class="form-group">

                <label for="confirmPassword">
                    Confirm New Password
                </label>

                <div class="password-input">

                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        required
                    >

                    <button
                        type="button"
                        class="toggle-password"
                        onclick="togglePassword('confirmPassword', this)">

                        <i class="fa-solid fa-eye"></i>

                    </button>

                </div>

            </div>


            <div class="form-actions">

                <button
                    type="submit"
                    class="save-btn">

                    <i class="fa-solid fa-key"></i>

                    Change Password

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


<script>

    function togglePassword(inputId, button) {

        const input =
            document.getElementById(inputId);

        const icon =
            button.querySelector("i");

        if (input.type === "password") {

            input.type = "text";

            icon.classList.remove(
                "fa-eye"
            );

            icon.classList.add(
                "fa-eye-slash"
            );

        } else {

            input.type = "password";

            icon.classList.remove(
                "fa-eye-slash"
            );

            icon.classList.add(
                "fa-eye"
            );
        }
    }

</script>


</body>

</html>