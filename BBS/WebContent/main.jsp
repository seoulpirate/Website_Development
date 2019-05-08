<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", inital-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
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
			<a class="navbar-brand" href="main.jsp"><img src="images/kw.PNG" height=25px/></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인 </a></li>
				<li><a href="bbs.jsp" style="color:#8B0000;font-weight:bold">KW-게시판 </a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else{
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="ucamMain.jsp">UCAM 접속</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
			
		</div>
	</nav>

	<div class="container">
		<!--  ⑦ Carousel start  -->
		<div class="row">
			<!--  ⑦ Carousel start  -->
			<div id="carouselWide">

				<!-- Images Slider Start -->
				<div id="carousel-example-generic" class="carousel slide"
					data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0"
							class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
						<!--<li data-target="#carousel-example-generic" data-slide-to="3"></li>-->
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img src="images/1.jpg">
							<div class="carousel-caption">KWANGWOON Univ - 1</div>
						</div>
						<div class="item">
							<img src="images/2.jpg" height="580">
							<div class="carousel-caption">KWANGWOON Univ - 2</div>
						</div>
						<div class="item">
							<img src="images/3.jpg" >
							<div class="carousel-caption">KWANGWOON Univ - 3</div>
						</div>
					</div>

					<!-- Controls -->
					<a class="left carousel-control" href="#carousel-example-generic"
						role="button" data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#carousel-example-generic"
						role="button" data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				<!-- Images Slider End -->
			</div>
			<!--/#carouselWide -->
		</div>
		<!--/.row  -->

		<!--  ⑧ Contents start  -->
        <!-- <div id="contents">

            Contents 들러갈 곳 

            </div> -->    
         <!--  ⑨ footer start 
         	<div id="footer">

            Footer 들러갈 곳

            </div>  -->
            
    </div><!--/ .container -->

	<br>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>광운 웹 사이트 소개</h1>
				<p>이 웹사이트는 JSP 웹 사이트 입니다. U-campus 로직을 일부를 이용해서 개발했습니다. 디자인 탬플릿으로는 부트스트랩을 이용했습니다.</p>		
				<p><a class="btn btn-primary btn-pull" href="bbs.jsp" role="button">자세히 알아보기</a></p>	
			</div>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>