<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/writePro.jsp</title>
</head>
<body>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//request 파라미터 가져오기 pass name subject content
String name=request.getParameter("name");
String pass=request.getParameter("pass");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
int readcount=0;
//BoardDTO 객체생성
BoardDTO boardDTO=new BoardDTO();
//set메서드 파라미터값 저장
//readcount 0 저장
boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
boardDTO.setReadcount(readcount);

//BoardDAO 객체생성
BoardDAO boardDAO=new BoardDAO();
//리턴값없음 insertBoard(BoardDTO boardDTO) 메서드 정의 
//insertBoard(boardDTO) 메서드호출
boardDAO.insertBoard(boardDTO);
// notice.jsp 이동
response.sendRedirect("notice.jsp");
%>
</body>
</html>