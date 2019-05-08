<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*,javax.mail.*,javax.mail.internet.*,javax.activation.*" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", inital-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String subject = request.getParameter("mail-subject");
		String content = request.getParameter("mail-content");

		// case1. 하드 코딩
		//final String from = "pakuih@naver.com";
		//final String passwd = "9245puhyun93@";
		
		// case2. getParameter로 받음	
		System.out.print("address : " + request.getParameter("from"));
		System.out.println(", passwd : " + request.getParameter("passwd"));
		final String from = request.getParameter("from");
		final String passwd = request.getParameter("passwd");
		
		// naver인지 daum인지 확인.
		String str = request.getParameter("from");
		String ret = str.substring(str.lastIndexOf("@")+1);
		String hostAdd = "smtp." + ret;		
		
		if(request.getParameterValues("mail-addr") == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('보낼 학생을 체크하고 보내세요.')");
			script.println("history.back()");
			script.println("</script>");		
		}
		String[] to = request.getParameterValues("mail-addr");
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host", hostAdd); 
		prop.put("mail.smtp.port", 465); 
		prop.put("mail.smtp.auth", "true"); 
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		
		Session sess = Session.getInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, passwd);
            }
        });
        
       //Session sess = Session.getDefaultInstance(prop);
		try {
			Message msg = new MimeMessage(sess);
			msg.setFrom(new InternetAddress(from));
		
			for (int i = 0; i < to.length; ++i) {
				InternetAddress address = new InternetAddress(to[i]);

				msg.setRecipient(Message.RecipientType.TO, address);
				msg.setSubject(subject);
				msg.setSentDate(new java.util.Date());

				msg.setContent(content, "text/html;charset=utf-8");
				Transport.send(msg);

				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='ucamCare.jsp'");
				script.println("</script>");
			}
		} catch (AddressException e) { 
			// TODO Auto-generated catch block e.printStackTrace(); 
			//e.printStackTrace(); 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('받는 학생의 메일주소 처리에 실패하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} catch (MessagingException e) { 
			// TODO Auto-generated catch block e.printStackTrace(); 	
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('보내는 이의 메일주소 및 PW를 제대로 입력하세요.')");
			script.println("history.back()");
			script.println("</script>");
		}


	%>

</body>
</html>