package com.lms.util;

import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;

    private static final String SENDER_EMAIL =
            "mayuripatil.vk@gmail.com";

    // Put your NEW Gmail App Password here.
    // Do NOT send the password to me.
    private static final String SENDER_PASSWORD =
             System.getenv("LMS_EMAIL_PASSWORD");


    // ================================
    // APPLICATION SUBMISSION EMAIL
    // ================================
    public static void sendApplicationEmail(
            String recipientEmail,
            String applicationNumber,
            String applicantName,
            String licenseType,
            String applicationDate,
            String status) {

        try {

            Properties properties = new Properties();

            properties.put(
                    "mail.smtp.auth",
                    "true"
            );

            properties.put(
                    "mail.smtp.starttls.enable",
                    "true"
            );

            properties.put(
                    "mail.smtp.host",
                    SMTP_HOST
            );

            properties.put(
                    "mail.smtp.port",
                    SMTP_PORT
            );

            Session session =
                    Session.getInstance(properties);

            Message message =
                    new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(SENDER_EMAIL)
            );

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(recipientEmail)
            );

            message.setSubject(
                    "License Application Submitted - "
                    + applicationNumber
            );

            String emailBody =
                    "Dear " + applicantName + ",\n\n"
                    + "Your license application has been "
                    + "submitted successfully.\n\n"
                    + "Application Details:\n"
                    + "Application ID: "
                    + applicationNumber + "\n"
                    + "Applicant Name: "
                    + applicantName + "\n"
                    + "License Type: "
                    + licenseType + "\n"
                    + "Application Date: "
                    + applicationDate + "\n"
                    + "Status: "
                    + status + "\n\n"
                    + "You can use your Application ID "
                    + "to track your application status.\n\n"
                    + "Regards,\n"
                    + "License Management System";

            message.setText(emailBody);

            // Explicitly provide Gmail credentials
            Transport transport =
                    session.getTransport("smtp");

            transport.connect(
                    SMTP_HOST,
                    SMTP_PORT,
                    SENDER_EMAIL,
                    SENDER_PASSWORD
            );

            transport.sendMessage(
                    message,
                    message.getAllRecipients()
            );

            transport.close();

            System.out.println(
                    "Application submission email sent successfully."
            );

        } catch (Exception e) {

            e.printStackTrace();
        }
    }


    // ================================
    // APPLICATION STATUS EMAIL
    // ================================
    public static void sendApplicationStatusEmail(
            String recipientEmail,
            String applicationNumber,
            String applicantName,
            String licenseType,
            String applicationDate,
            String status) {

        try {

            Properties properties = new Properties();

            properties.put(
                    "mail.smtp.auth",
                    "true"
            );

            properties.put(
                    "mail.smtp.starttls.enable",
                    "true"
            );

            properties.put(
                    "mail.smtp.host",
                    SMTP_HOST
            );

            properties.put(
                    "mail.smtp.port",
                    SMTP_PORT
            );

            Session session =
                    Session.getInstance(properties);

            Message message =
                    new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(SENDER_EMAIL)
            );

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(recipientEmail)
            );

            String subject;

            if ("APPROVED".equalsIgnoreCase(status)) {

                subject =
                        "License Application Approved - "
                        + applicationNumber;

            } else if ("REJECTED".equalsIgnoreCase(status)) {

                subject =
                        "License Application Rejected - "
                        + applicationNumber;

            } else {

                subject =
                        "License Application Status Update - "
                        + applicationNumber;
            }

            message.setSubject(subject);

            String emailBody =
                    "Dear " + applicantName + ",\n\n";

            if ("APPROVED".equalsIgnoreCase(status)) {

                emailBody +=
                        "Congratulations!\n\n"
                        + "Your license application has been "
                        + "approved.\n\n";

            } else if ("REJECTED".equalsIgnoreCase(status)) {

                emailBody +=
                        "We regret to inform you that your "
                        + "license application has been rejected.\n\n";

            } else {

                emailBody +=
                        "There has been an update to your "
                        + "license application.\n\n";
            }

            emailBody +=
                    "Application Details:\n"
                    + "Application ID: "
                    + applicationNumber + "\n"
                    + "Applicant Name: "
                    + applicantName + "\n"
                    + "License Type: "
                    + licenseType + "\n"
                    + "Application Date: "
                    + applicationDate + "\n"
                    + "Current Status: "
                    + status + "\n\n"
                    + "You can use your Application ID "
                    + "to track your application status.\n\n"
                    + "Regards,\n"
                    + "License Management System";

            message.setText(emailBody);

            // Explicitly provide Gmail credentials
            Transport transport =
                    session.getTransport("smtp");

            transport.connect(
                    SMTP_HOST,
                    SMTP_PORT,
                    SENDER_EMAIL,
                    SENDER_PASSWORD
            );

            transport.sendMessage(
                    message,
                    message.getAllRecipients()
            );

            transport.close();

            System.out.println(
                    "Application status email sent successfully."
            );

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}