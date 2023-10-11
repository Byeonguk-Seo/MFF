<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/dupCheck.jsp</title>
<script type="text/javascript">
	function ok() {
// 		join.jsp 아이디상자 = dupCheck.jsp 찾은아이디
//       window.창을열게해준페이지 window.opener 
        window.opener.document.fr.id.value = document.wfr.id.value;
//      창닫기
		window.close();
	}
</script>
</head>
<body>
<h1>member/dupCheck.jsp</h1>
<%
// dupCheck.jsp?id="+id
String id=request.getParameter("id");
// MemberDAO 객체생성
MemberDAO memberDAO=new MemberDAO();
// MembmerDTO memberDTO = getMember(id) 메서드 호출
MemberDTO memberDTO=memberDAO.getMember(id);

// memberDTO null => 아이디 없음 => 아이디 사용가능
// memberDTO null 아니면 => 아이디 있다=> 아이디 중복
if(memberDTO==null){
	%>아이디 사용가능 <input type="button" value="아이디사용" onclick="ok()"><%
}else{
	%>아이디 중복<%
}
%>
<form action="dupCheck.jsp" method="get" name="wfr">
아이디 : <input type="text" name="id" value="<%=id%>">
<input type="submit" value="아이디중복체크">
</form>
</body>
</html>




