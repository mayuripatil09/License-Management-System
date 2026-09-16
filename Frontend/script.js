// =========================================
// PASSWORD VISIBILITY
// =========================================

function togglePassword(inputId, button) {

    const passwordInput =
        document.getElementById(inputId);

    const icon =
        button.querySelector("i");

    if (passwordInput.type === "password") {

        passwordInput.type = "text";

        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");

    } else {

        passwordInput.type = "password";

        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");

    }

}


// =========================================
// REGISTER FORM
// =========================================

const registerForm =
    document.getElementById("registerForm");

if (registerForm) {

    registerForm.addEventListener(
        "submit",
        function(event) {

            const password =
                document.getElementById("password").value;

            const confirmPassword =
                document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {

                event.preventDefault();

                alert(
                    "Password and Confirm Password do not match."
                );

                return;
            }

            // Allow the form to submit to RegisterServlet

        }
    );

}


// =========================================
// LOGIN FORM
// =========================================

const loginForm =
    document.getElementById("loginForm");

if (loginForm) {

    loginForm.addEventListener(
        "submit",
        function(event) {

            const username =
                document
                    .getElementById("loginUsername")
                    .value
                    .trim();

            const password =
                document
                    .getElementById("loginPassword")
                    .value;

            if (username === "" || password === "") {

                event.preventDefault();

                alert(
                    "Please enter username and password."
                );

            }

        }
    );

}


// =========================================
// LICENSE APPLICATION FORM
// =========================================

const applicationForm =
    document.getElementById("applicationForm");

if (applicationForm) {

    const dobInput =
        document.getElementById("dob");

    const ageError =
        document.getElementById("ageError");


    // Hide error when page first opens

    if (ageError) {
        ageError.style.display = "none";
    }


    // =====================================
    // CHECK AGE WHEN DOB CHANGES
    // =====================================

    if (dobInput) {

        dobInput.addEventListener(
            "change",
            function() {

                if (this.value === "") {

                    if (ageError) {
                        ageError.style.display = "none";
                    }

                    return;
                }


                const birthDate =
                    new Date(this.value);

                const today =
                    new Date();

                let age =
                    today.getFullYear()
                    - birthDate.getFullYear();

                const monthDifference =
                    today.getMonth()
                    - birthDate.getMonth();


                if (
                    monthDifference < 0 ||
                    (
                        monthDifference === 0 &&
                        today.getDate()
                        < birthDate.getDate()
                    )
                ) {

                    age--;

                }


                if (age < 18) {

                    if (ageError) {
                        ageError.style.display = "block";
                    }

                    dobInput.classList.add(
                        "input-error"
                    );

                } else {

                    if (ageError) {
                        ageError.style.display = "none";
                    }

                    dobInput.classList.remove(
                        "input-error"
                    );

                }

            }
        );

    }


    // =====================================
    // CHECK AGE BEFORE SUBMISSION
    // =====================================

    applicationForm.addEventListener(
        "submit",
        function(event) {

            if (!dobInput || dobInput.value === "") {
                return;
            }


            const birthDate =
                new Date(dobInput.value);

            const today =
                new Date();

            let age =
                today.getFullYear()
                - birthDate.getFullYear();

            const monthDifference =
                today.getMonth()
                - birthDate.getMonth();


            if (
                monthDifference < 0 ||
                (
                    monthDifference === 0 &&
                    today.getDate()
                    < birthDate.getDate()
                )
            ) {

                age--;

            }


            if (age < 18) {

                event.preventDefault();

                if (ageError) {
                    ageError.style.display = "block";
                }

                dobInput.classList.add(
                    "input-error"
                );

                alert(
                    "You are not eligible. Minimum age required is 18."
                );

                return;

            }

            // Allow the form to submit to ApplicationServlet

        }
    );

}


// =========================================
// ADMIN LOGIN FORM
// =========================================
//
// Admin login is handled by LoginServlet.
//
// admin-login.html submits to:
//
// http://localhost:8080/lms/login
//
// LoginServlet checks:
// - username
// - password
// - ADMIN role
// - MySQL database
//
// No JavaScript is required here.
//
// =========================================


// =========================================
// ADMIN APPLICATION DECISION
// =========================================
//
// IMPORTANT:
//
// Application approval and rejection are now
// handled by:
//
// AdminApplicationDecisionServlet
//
// The servlet:
// - updates MySQL
// - sends email
// - redirects to application details
//
// Therefore, the old localStorage-based
// approval/rejection code has been removed.
//
// =========================================


// =========================================
// ADMIN MANAGE USERS
// =========================================
//
// User View and Delete operations are handled
// by backend functionality.
//
// The old JavaScript demo alert for:
//
// "User Details"
//
// has been removed.
//
// The View button now opens:
//
// admin-user-details?userId=USER_ID
//
// =========================================


// =========================================
// USER SEARCH
// =========================================

const userSearch =
    document.getElementById("userSearch");

if (userSearch) {

    userSearch.addEventListener(
        "input",
        function() {

            const searchText =
                this.value
                    .toLowerCase()
                    .trim();

            const table =
                document.querySelector(
                    ".users-table-wrapper table"
                );

            if (!table) {
                return;
            }


            const rows =
                table.querySelectorAll(
                    "tbody tr"
                );


            rows.forEach(function(row) {

                const rowText =
                    row.textContent
                        .toLowerCase();

                if (
                    searchText === "" ||
                    rowText.includes(searchText)
                ) {

                    row.style.display = "";

                } else {

                    row.style.display = "none";

                }

            });

        }
    );

}


// =========================================
// ADMIN PROFILE
// =========================================
//
// Profile editing is not connected to the
// backend yet.
//
// We keep this temporary message until the
// Admin Profile backend is implemented.
//
// =========================================

const editAdminProfile =
    document.getElementById("editAdminProfile");

if (editAdminProfile) {

    editAdminProfile.addEventListener(
        "click",
        function() {

            alert(
                "Edit Profile\n\n" +
                "Profile editing will be available after backend integration."
            );

        }
    );

}


// =========================================
// CHANGE ADMIN PASSWORD
// =========================================
//
// Password changing is not connected to the
// backend yet.
//
// We keep this temporary message until the
// password-change backend is implemented.
//
// =========================================

const changeAdminPassword =
    document.getElementById(
        "changeAdminPassword"
    );

if (changeAdminPassword) {

    changeAdminPassword.addEventListener(
        "click",
        function() {

            alert(
                "Change Password\n\n" +
                "Password change will be available after backend integration."
            );

        }
    );

}