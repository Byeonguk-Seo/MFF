<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<header>
<%
String id = (String)session.getAttribute("id");
MemberDAO memberDAO = new MemberDAO();
MemberDTO memberDTO = memberDAO.getMember(id);
// 세션값이 없으면 loginForm.jsp 이동
if(id==null){
	%>
	<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
	<%
}

if(id!=null){
	%>
	<div id="login"><%=id %>님이 로그인 하셨습니다. 포인트 : <%=memberDTO.getMoney() %>
	<a href="../member/update.jsp">update</a>
	<a href="../member/logout.jsp">logout</a>
<%-- 	<% --%>
<!-- // 	if(id.equals("admin")){ -->
<%-- 		%> --%>
<!-- 		<a href="list.jsp">list</a> -->
<%-- 		<% --%>
<!-- // 	} -->
<%-- 	%> --%>
	</div>
	<%
}
%>

<!-- <div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div> -->
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../img/mainimage/logo.jpg" width="265" height="62" alt="Fun Web"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../marvelff/mypage.jsp">My Page</a></li>
	<li><a href="../center/notice.jsp">Notice</a></li>
	<li><a href="../marvelff/herolist.jsp">Hero List</a></li>
	<li><a href="../marvelff/battle.jsp">battle</a></li>
</ul>
</nav>
</header>