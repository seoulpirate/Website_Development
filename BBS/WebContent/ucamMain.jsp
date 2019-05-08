<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="course.CourseDAO" %>
<%@ page import="course.Course" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", inital-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>유캠 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		String userLevel = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		
		if(session.getAttribute("userLevel")!=null){
			userLevel = (String)session.getAttribute("userLevel");
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>	
				<span class="icon-bar"></span>	
				<span class="icon-bar"></span>		
			</button>
			<a class="navbar-brand" href="ucamMain.jsp"><img src="images/kw.PNG" height=25px/></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="ucamMain.jsp"><%=userID %>의 메인 </a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">학습지원실 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="ucamBbs.jsp">강의자료실</a></li>
					</ul>
				</li>
				<%
					if (userLevel.equals("교수")) {
				%>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">수강생관리 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="ucamCare.jsp">메일발송</a></li>
					</ul>
				</li>
				<%
					}
				%>
			</ul>			
			<ul class="nav navbar-nav navbar-right">
				<li><a href="main.jsp">KW 홈페이지</a>
				<li><a href="logoutAction.jsp">로그아웃 </a></li>
			</ul>		
		</div>
	</nav>
	
	<div class="container">
	<h1>수강 과목</h1>
		<div class="jumbotron">			
			<div class="container">
				<div class="row">
				<div class="col-md-10">
					<table class="table table">
						<thead>
							<tr>
								<th>과목명</th>
								<th>강의시수</th>
								<th>강의실</th>
							</tr>						
						</thead>
						<tbody>
							<%
							if(userID != null){
								CourseDAO courseDAO = new CourseDAO();
								ArrayList<Course> list = courseDAO.getList(userID, userLevel);
								for(int i = 0; i<list.size(); i++){	
							%>
							<tr>
								<td>[<%=list.get(i).getCcode() %>] <%= list.get(i).getCname()%></td>
								<td><%= list.get(i).getCtime() %> </td>
								<td><%= list.get(i).getCroom() %> </td>		
							</tr>
							<%
								}
								if(list.size() != 0){
								session.setAttribute("cname", list.get(0).getCname());
								session.setAttribute("ccode", list.get(0).getCcode());
								}
							}
							%>
						</tbody>
					
					</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>