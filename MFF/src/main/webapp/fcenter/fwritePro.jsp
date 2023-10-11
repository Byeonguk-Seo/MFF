<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fwritePro.jsp</title>
</head>
<body>
<%
//파일 업로드
//프로그램 설치 cos.jar
//http://www.servlets.com
//COS File Upload Library
//cos-22.05.zip => 압축 풀기 => lib폴더 => cos.jar
// WEB-INF - lib - cos.jar 넣기

//파일업로드파일  MultipartRequest.class 객체생성
// MultipartRequest multi=
// new MultipartRequest(request,upload폴더물리적경로,업로드파일크기,한글처리,파일이름 동일 할 경우 이름변경 );
//upload폴더 만들기  webapp-폴더만들기 upload
String uploadPath=request.getRealPath("/upload");
out.println(uploadPath);
//파일 업로드 크기
int maxSize=10*1024*1024;
MultipartRequest multi=
new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

//multi 파라미터 가져오기 pass name subject content
String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
int readcount=0;
//업로드된 파일 이름 가져오기
String file=multi.getFilesystemName("file");

//BoardDTO 객체생성
BoardDTO boardDTO=new BoardDTO();
//set메서드 파라미터값 저장
//readcount 0 저장
boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
boardDTO.setReadcount(readcount);
// BoardDTO file멤버변수 만들기
// set메서드 호출
boardDTO.setFile(file);

//BoardDAO 객체생성
BoardDAO boardDAO=new BoardDAO();
//리턴값없음 insertBoard(BoardDTO boardDTO) 메서드 정의 
//insertBoard(boardDTO) 메서드호출
boardDAO.insertBoard(boardDTO);
//notice.jsp 이동
response.sendRedirect("fnotice.jsp");

%>
</body>
</html>



