package com.DesingEngineering.service;

import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.DesingEngineering.entity.StudentEntity;

import jakarta.mail.internet.MimeMessage;

@Service
public class MailerService {

	@Autowired
	JavaMailSender javaMailSender;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	public void sendWelcomeMail(StudentEntity student) {
		
		MimeMessage message = javaMailSender.createMimeMessage();

		Resource resource = resourceLoader.getResource("classpath:templates/WelcomeMailTemplate.html");
		
		try {
			String html = new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);

			MimeMessageHelper helper;

			String body = html.replace("${name}", student.getStudentName()).replace("${email}", student.getEmail())
					.replace("${loginUrl}", "http://localhost:9997/login").replace("${companyName}", "Dessign Engineering Project");

			helper = new MimeMessageHelper(message, true);
			helper.setTo(student.getEmail());
			helper.setSubject("Welcome aboard in Collage Environment !!! ");
			helper.setText(body, true);

			javaMailSender.send(message);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
