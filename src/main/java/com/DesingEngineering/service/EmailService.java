package com.DesingEngineering.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendOtpEmail(String to, String otp) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject("🔐 Password Reset OTP – College Placement System");

        String emailBody = String.format(
            "Dear Student,\n\n" +
            "We received a request to reset your password for the College Placement System.\n\n" +
            "Your One-Time Password (OTP) is: **%s**\n\n" +
            "This OTP is valid for 10 minutes. Please do not share it with anyone.\n\n" +
            "If you did not request a password reset, please ignore this email or contact our support.\n\n" +
            "Best regards,\n" +
            "Placement Cell\n" +
            "Design Engineering College\n" +
            "Email:  | Phone: ",
            otp
        );

        message.setText(emailBody);
        mailSender.send(message);
    }
}