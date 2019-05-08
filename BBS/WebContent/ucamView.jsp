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
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		if(session.getAttribute("userLevel")!=null){
			userLevel = (String)session.getAttribute("userLevel");
		}
		int bbsID = 0;
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
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판 글
							보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID()%></td>
					</tr>
					<tr>
						<td>작성 일자</td>
						<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"	+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<td>첨부파일</td>
						<td colspan="2">
							<%
								if (bbs.getFileName() != null) {
							%> <a id="downA" href="#"> <%=bbs.getFileName()%></a> 
								<script type="text/javascript">
									// 영문 파일은 그냥 다운로드 클릭시 정상 작동 한글파일명은 쿼리문을 날릴 경우 인코딩 문제가 발생 할 수 있다. 즉, 한글이 깨져 정상작동하지 않을 수 있음.
									// 쿼리문자열을 한글에 보낼 때는 항상 인코딩을 해서 보내주도록 하자.
									document.getElementById("downA").addEventListener("click", function(event) {
           						 	event.preventDefault(); // a 태그의 기본 동작을 막음
            						event.stopPropagation(); // 이벤트의 전파를 막음
            						// fileName1을 utf-8로 인코딩한다.
           							var fName = encodeURIComponent("<%=bbs.getFileName()%>");
            						// 인코딩된 파일이름을 쿼리문자열에 포함시켜 다운로드 페이지로 이동
           							window.location.href = "fileDown1.jsp?file_name="+fName;
       							 });
								</script>
							<%
 								}
 							%>
						</td>
					</tr>
				</tbody>
			</table>
			<a href="ucamBbs.jsp" class="btn btn-primary">목록</a>
			<%
				if (userID != null && userID.equals(bbs.getUserID())) {
			%>
			<a href="ucamUpdate.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
			<a onClick="return confirm('정말로 삭제하시겠습니까?')"
				href="ucamDeleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>