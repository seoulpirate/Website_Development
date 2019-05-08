<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="course.CourseDAO" %>
<%@ page import="course.Course" %>
<%@ page import="userbbs.UserBbsDAO" %>
<%@ page import="userbbs.UserBbs" %>
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
		String userLevel = null;
		String cname = null;
		String ccode = null;
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
				<li class="dropdown active">
					<a href="#" class="dropdown-toggle"
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
	<h1>강의자료</h1>		   		  
		<div class="jumbotron">	
			<form action="ucamBbsAction.jsp" method="post"> 
				<table>
					<tr>
					<%
						if(ccode != null){
					%>
						<label>과목정보: [<%=ccode%>]<%=cname %> </label>	
					<%
						}else{
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
	
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody> 
					<%
						UserBbsDAO ubbsDAO = new UserBbsDAO();
						ArrayList<UserBbs> list = ubbsDAO.getList(ccode);
						for(int i = 0; i<list.size(); i++){ 
					%>
					<tr>
						<td><%= list.size()-i %></td>
						<td><a href="ucamView.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14,16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(userLevel.equals("교수"))
				{			
			%>
				<a href="ucamwrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<%
				}
			%>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>