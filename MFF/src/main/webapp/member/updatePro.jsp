<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/updatePro</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String post = request.getParameter("post");
String address = request.getParameter("address");
String address2 = request.getParameter("address2");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");

MemberDAO memberDAO = new MemberDAO();
MemberDTO memberDTO = memberDAO.userCheck(id, pass);

if(memberDTO != null){
	MemberDTO updateDTO = new MemberDTO();
	updateDTO.setId(id);
	updateDTO.setPass(pass);
	updateDTO.setName(name);
	updateDTO.setEmail(email);
	updateDTO.setPost(post);
	updateDTO.setAddress(address);
	updateDTO.setAddress2(address2);
	updateDTO.setPhone(phone);
	updateDTO.setMobile(mobile);
	
	memberDAO.updateMember(updateDTO);
	
	response.sendRedirect("../main/main.jsp");
} else {
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