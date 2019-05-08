<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="course.CourseDAO" %>
<%@ page import="course.Course" %>
<%@ page import="course.Student" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", inital-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>유캠 웹 사이트</title>
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		String cname = null;
		String ccode = null;
		String userLevel = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}		

		if(session.getAttribute("userLevel")!=null){
			userLevel = (String)session.getAttribute("userLevel");
		}	
		if(session.getAttribute("cname")!=null){
			cname = (String)session.getAttribute("cname");
		}
		if(session.getAttribute("ccode")!=null){
			ccode = (String)session.getAttribute("ccode");
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
				<li><a href="ucamMain.jsp"><%=userID %>의 메인 </a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">학습지원실 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="ucamBbs.jsp">강의자료실</a></li>
					</ul>
				</li>
				<li class="dropdown active"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">수강생관리 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="ucamCare.jsp">메일발송</a></li>
					</ul>
				</li>
			</ul>	
			<ul class="nav navbar-nav navbar-right">
				<li><a href="main.jsp">KW 홈페이지</a>
				<li><a href="logoutAction.jsp">로그아웃 </a></li>
			</ul>		
		</div>
	</nav>
	
	<div class="container">
	<h1>수강생관리</h1>		   		  
		<div class="jumbotron">	
			<form action="ucamCareAction.jsp" method="post">
				<table>
					<tr>
						<%
							if (ccode != null) {
						%>
						<label>과목정보: [<%=ccode%>]<%=cname%>
						</label>
						<%
							} else {
						%>
						<label>과목 정보: 없음</label>
						<%
							}
						%>
					</tr>
					<tr>
						<div class="row">
							<div class="col-md-4">
								<select class="form-control" name="ccode">
									<option value="<%=ccode %>">-- 선택 --</option>
									<%
										if(userID != null){
											CourseDAO courseDAO = new CourseDAO();
											ArrayList<Course> list = courseDAO.getList(userID, userLevel);
											for(int i = 0; i<list.size(); i++){					
									%>
									<option value="<%=list.get(i).getCcode()%>"><%=list.get(i).getCname() %></option>
									<%
											}
										}						
									%>
								</select>
							</div>
							<div class="col-md-2">
								<input type="submit" value="GO">
							</div>
						</div>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<form method="post" action="ucamMailAction.jsp">
	<div class="container">
		<div class="row">
			
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2" style="background-color: #eeeeee; text-align: center;">이메일 보내기 양식</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeHolder="글 제목" name="mail-subject" maxlength="50"></td>
							</tr>
							<tr>
								<td><textarea class="form-control" placeHolder="글 내용" name="mail-content" maxlength="2048" style="height: 250px"></textarea></td>
							</tr>
							<tr>
								<td><input type="text" class="form-control" placeHolder="보낸이 메일" name="from" maxlength="50"></td>
							</tr>
							<tr>
								<td><input type="password" class="form-control" placeHolder="메일 PW" name="passwd" maxlength="20"></td>
							</tr>
						</tbody>				
					</table>
					<input type="submit" class="btn btn-primary pull-right" value="보내기">	
		</div>
	</div>
	<br>
	<div class="container container-fluid">
		<div class="row">	
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">선택</th>
						<th style="background-color: #eeeeee; text-align: center;">No</th>
						<th style="background-color: #eeeeee; text-align: center;">아이디</th>
						<th style="background-color: #eeeeee; text-align: center;">이름</th>
						<th style="background-color: #eeeeee; text-align: center;">부서</th>
						<th style="background-color: #eeeeee; text-align: center;">이메일</th>
					</tr>
				</thead>
				<tbody>
					<%
						CourseDAO courseDAO = new CourseDAO();
						ArrayList<Student> list = courseDAO.getStd(ccode);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><input type="checkbox" name="mail-addr" value="<%=list.get(i).getSemail()%>"></td>
						<td><%=i + 1%></td>
						<td><%=list.get(i).getScode()%></td>
						<td><%=list.get(i).getSname()%></td>
						<td><%=list.get(i).getSdept()%></td>
						<td><%=list.get(i).getSemail()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>	
	</form>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>