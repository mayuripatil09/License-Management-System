# License Management System

A full-stack web-based License Management System that allows users to register, apply for licenses, upload required documents, track application status, and receive email notifications. Administrators can review applications, approve or reject them, manage users, and maintain their profiles.

## Features

### User Module
- User registration and login
- Secure session-based authentication
- Apply for a license
- Upload applicant photo and Aadhaar document
- Automatic application ID generation
- Track application status
- View submitted applications
- View application details
- Edit profile
- Change password
- Email notification after application submission
- Email notification when application status changes

### Admin Module
- Admin login
- View all license applications
- View complete application details
- View uploaded applicant documents
- Approve or reject applications
- Automatic email notification after approval/rejection
- Manage registered users
- View user details
- Delete users and associated applications
- Edit admin profile
- Change admin password

## Technologies Used

### Frontend
- HTML5
- CSS3
- JavaScript

### Backend
- Java
- JSP
- Java Servlets
- JDBC

### Database
- MySQL

### Server
- Apache Tomcat

### Email
- Jakarta Mail
- Gmail SMTP

## Project Structure

```text
License-Management-System/
│
├── Backend/
│   ├── lib/
│   └── src/
│       └── main/
│           ├── java/
│           │   └── com/lms/
│           │       ├── servlet/
│           │       └── util/
│           └── webapp/
│
├── Frontend/
│   ├── index.html
│   ├── login.html
│   ├── register.html
│   ├── user-dashboard.html
│   ├── apply-license.html
│   ├── track-application.html
│   ├── admin-login.html
│   ├── admin-dashboard.html
│   ├── style.css
│   └── script.js
│
└── README.md