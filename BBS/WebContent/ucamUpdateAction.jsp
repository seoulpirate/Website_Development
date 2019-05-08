<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="userbbs.UserBbs" %>
<%@ page import="userbbs.UserBbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
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
		// 파일이 저장될 서버의 경로. 되도록이면 getRealPath를 이용하자.
		//String savePath = "C:/JSP";	// case(1)
		String savePath = request.getRealPath("/folderName"); // case(2)
		System.out.println("savePath : " + savePath);

		// 파일 크기 5MB로 제한
		int sizeLimit = 1024 * 1024 * 5;

		try {
			//  ↓ request 객체,               ↓ 저장될 서버 경로,       ↓ 파일 최대 크기,    ↓ 인코딩 방식,       ↓ 같은 이름의 파일명 방지 처리
			// (HttpServletRequest request, String saveDirectory, int maxPostSize, String encoding, FileRenamePolicy policy)
			// 아래와 같이 MultipartRequest를 생성만 해주면 파일이 업로드 된다.(파일 자체의 업로드 완료)
			MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8",
					new DefaultFileRenamePolicy());

			// MultipartRequest로 전송받은 데이터를 불러온다.
			// enctype을 "multipart/form-data"로 선언하고 submit한 데이터들은 request객체가 아닌 MultipartRequest객체로 불러와야 한다.
			String uBbsTitle = multi.getParameter("bbsTitle");
			String uBbsContent = multi.getParameter("bbsContent");
			String ubbsID = multi.getParameter("bbsID");
			int bbsID = Integer.parseInt(ubbsID);
			System.out.println("bbsID: " + bbsID);

			// 업로드한 파일의 전체 경로를 DB에 저장하기 위함
			//String m_fileFullPath = savePath + "/" + fileName;

			// 전송받은 데이터가 파일일 경우 getFilesystemName()으로 파일 이름을 받아올 수 있다.
			String fileName = multi.getFilesystemName("fname");

			if (uBbsTitle == null || uBbsContent == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {

				// input file name에 해당하는 실재 파일을 가져옴
				File file = multi.getFile(fileName);

				UserBbsDAO bbsDAO = new UserBbsDAO();
				System.out.println("bbsID: " + bbsID + " bbsTitle: " + uBbsTitle + " bbsContent: " + uBbsContent
						+ " fileName: " + fileName);
				int result = bbsDAO.update(bbsID, uBbsTitle, uBbsContent, fileName);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='ucamBbs.jsp'");
					script.println("</script>");			}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>