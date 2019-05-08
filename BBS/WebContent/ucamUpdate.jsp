<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="userbbs.UserBbs" %>
<%@ page import="userbbs.UserBbsDAO" %>
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
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		int bbsID = 0;
		/*글의 아이디값 즉, 글의 번호가 들어오지 않았다면... 유효하지않는 글이라고 출력해준다. */
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alret('유효하지 않은 글입니다.')");
			script.println("location.href = 'ucamBbs.jsp'");
			script.println("</script>");
		}
		UserBbs bbs = new UserBbsDAO().getuBbs(bbsID);
		/* 실제로 글을 작성한 사람이 맞는지 확인하는 작업 */
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alret('권한이 없습니다.')");
			script.println("location.href = 'ucamBbs.jsp'");
			script.println("</script>");
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
				<li class="dropdown"><a href="#" class="dropdown-toggle"
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
		<div class="row">
			<form method="post" action="ucamUpdateAction.jsp" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2" style="background-color: #eeeeee; text-align: center;">강의자료 글수정 양식</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeHolder="글 제목" name="bbsTitle" maxlength="50"></td>
							</tr>
							<tr>
								<td><textarea class="form-control" placeHolder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px"></textarea></td>
							</tr>
							<tr>
								<td><input class="form-control" type="file" name="fname"></td>
							</tr>
						</tbody>				
					</table>
					<input type="submit" class="btn btn-primary pull-right" value="글수정">
					<input type="hidden" name="bbsID" value="<%=request.getParameter("bbsID")%>">
			</form>			
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>