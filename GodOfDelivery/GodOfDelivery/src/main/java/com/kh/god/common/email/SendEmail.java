package com.kh.god.common.email;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.MimeMessageHelper;

public class SendEmail {
	

  public void mailSending(String email , String name , String id) {
		String host = "smtp.naver.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
		final String USER = "escape_if_you_can@naver.com"; // 이메일 주소
		final String PASSWORD = "escapeifyoucan!"; // 비밀번호

		    
	      // SMTP 서버 정보를 설정한다.
			Properties props = new Properties();
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", 587);
			props.put("mail.smtp.auth", "true");

		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(USER, PASSWORD);
			}
		});
		
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(USER));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); // 수신자 이메일 주소

		
			
	
			message.setSubject("<GodOFDelivery> "+name+"고객님의 아이디 입니다."); // 메일 제목
			message.setText("고객님의 아이디는"+id+"입니다."); // 메일 내용
			
			// send the message
			Transport.send(message);
			System.out.println("Success Message Send");

		} catch (MessagingException e) {
			e.printStackTrace();
		}
		

  }
		
} 