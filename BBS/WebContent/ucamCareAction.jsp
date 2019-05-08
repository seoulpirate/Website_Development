<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="course.CourseDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="course" class="course.Course" scope="page"/>
<jsp:setProperty name="course" property="ccode"/>
<jsp:setProperty name="course" property="cname"/>
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
		String ccode = null;
		
		if(session.getAttribute("ccode") != null){
			ccode = (String)session.getAttribute("ccode");
		}
		
		session.setAttribute("ccode", course.getCcode());		

		CourseDAO courseDAO = new CourseDAO();
		session.setAttribute("cname", courseDAO.getCoursecode(course.getCcode()));
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='ucamCare.jsp'");
		script.println("</script>");
	
	%>
</body>
</html>