<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb/loginPro.jsp</title>
</head>
<body>
<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDAO memberDAO=new MemberDAO();
MemberDTO memberDTO=memberDAO.userCheck(id, pass);

if(memberDTO!=null){
	//데이터 있으면 true => 아이디 비밀번호 일치
	// 페이지 상관없이 id값을 유지=> 세션값 저장 "id",id
	session.setAttribute("id", id);
	// 메인페이지 이동
	response.sendRedirect("../main/main.jsp");
}else{
	//데이터 없으면 false => 아이디 비밀번호 틀림
	// 아이디 비밀번호 틀림메시지 출력 , 뒤로이동
	%>
	<script type="text/javascript">
		alert("아이디 비밀번호 틀림");
		history.back();
	</script>
	<%
}
%>
</body>
</html>