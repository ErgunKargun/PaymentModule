package com.pm.mail;

import java.io.File;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.MailParseException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class Mailer {
	private JavaMailSender mailSender;

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	public void sendMail(String to, String subject, String content, File invoiceFile) {

		MimeMessage message = mailSender.createMimeMessage();

		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			helper.setFrom("ergunkargun@gmail.com");
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(content);

			//FileSystemResource file = new FileSystemResource("C:\\log.txt");
			helper.addAttachment("Fatura", invoiceFile);

		} catch (MessagingException e) {
			throw new MailParseException(e);
		}
		mailSender.send(message);
	}
}