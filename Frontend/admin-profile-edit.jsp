<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Edit Admin Profile - License Management System</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f7f1e6;
            color: #443b30;
        }

        .navbar {
            background: #fffaf2;
            padding: 18px 8%;
            border-bottom: 1px solid #dfd2bd;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
            color: #6f4e16;
        }

        .container {
            max-width: 700px;
            margin: 60px auto;
            padding: 0 20px;
        }

        .card {
            background: #fffdf8;
            border: 1px solid #dfd2bd;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 8px 25px rgba(80, 60, 30, 0.08);
        }

        h1 {
            font-family: Georgia, serif;
            margin-bottom: 10px;
            color: #3e3429;
        }

        .subtitle {
            color: #776b5d;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 13px 15px;
            border: 1px solid #cdbfa9;
            border-radius: 8px;
            font-size: 15px;
            background: white;
        }

        input:focus {
            outline: none;
            border-color: #a87820;
        }

        input[readonly] {
            background: #eee8dc;
            color: #766c60;
        }

        .buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 13px 24px;
            border-radius: 8px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            font-size: 15px;
        }

        .primary-btn {
            background: #8a6119;
            color: white;
        }

        .secondary-btn {
            background: #eee5d7;
            color: #4d4235;
        }

        .primary-btn:hover {
            background: #704d13;
        }

        .secondary-btn:hover {
            background: #ddd1bf;
        }
    </style>
</head>

<body>

    <div class="navbar">
        <div class="logo">⚖ LMS</div>

        <a href="admin-profile"
           class="btn secondary-btn">
            Back to Profile
        </a>
    </div>

    <div class="container">

        <div class="card">

            <h1>Edit Admin Profile</h1>

            <p class="subtitle">
                Update your administrator account information.
            </p>

            <form action="admin-profile-update" method="post">

                <div class="form-group">
                    <label for="fullName">Full Name</label>

                    <input
                        type="text"
                        id="fullName"
                        name="fullName"
                        value="<%= request.getAttribute("fullName") %>"
                        required
                    >
                </div>

                <div class="form-group">
                    <label for="username">Username</label>

                    <input
                        type="text"
                        id="username"
                        value="<%= request.getAttribute("username") %>"
                        readonly
                    >
                </div>

                <div class="form-group">
                    <label for="email">Email</label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        value="<%= request.getAttribute("email") %>"
                        required
                    >
                </div>

                <div class="buttons">

                    <button
                        type="submit"
                        class="btn primary-btn"
                    >
                        Save Changes
                    </button>

                    <a
                        href="admin-profile"
                        class="btn secondary-btn"
                    >
                        Cancel
                    </a>

                </div>

            </form>

        </div>

    </div>

</body>
</html>