<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb/memberCheck.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");

MemberDAO memberDAO=new MemberDAO();
int result = memberDAO.idCheck(id);

if(result == 1){
	out.print("사용가능한 아이디입니다");
	%>
	<form action="join.jsp">
	 <input type="button" value="아이디 사용하기" onclick=window.close()>
	</form>
	<%
}else if(result == 0){
	out.print("중복된 아이디입니다");
}else {
	out.print("에러 발생!!!"); 
}
%>
</body>
</html>