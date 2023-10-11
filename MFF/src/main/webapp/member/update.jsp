<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/update.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../marvelff/mypage.jsp">My Page</a></li>
<li><a href="../marvelff/store.jsp">Store</a></li>
<li><a href="../member/update.jsp">Update</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<%
// 세션값 가져오기
String id = (String)session.getAttribute("id");

// MemberDAO 객체생성
MemberDAO memberDAO = new MemberDAO();

// MmeberDTO memberDTO = getMember(id) 메서드 호출
MemberDTO memberDTO = memberDAO.getMember(id);

%>
<article>
<h1>Update Us</h1>
<form action="updatePro.jsp" id="join" method="post">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" value="<%=memberDTO.getId() %>"><br>
<label>Password</label>
<input type="password" name="pass"><br>
<label>Name</label>
<input type="text" name="name" value="<%=memberDTO.getName()%>"><br>
<label>E-Mail</label>
<input type="email" name="email" value="<%=memberDTO.getEmail() %>"><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Post Number</label>
<input type="text" name="post" value="<%=memberDTO.getPost() %>"><br>
<label>Address</label>
<input type="text" name="address" value="<%=memberDTO.getAddress() %>"><br>
<label>Address2</label>
<input type="text" name="address2" value="<%=memberDTO.getAddress2() %>"><br>
<label>Phone Number</label>
<input type="text" name="phone" value="<%=memberDTO.getPhone() %>"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile" value="<%=memberDTO.getMobile() %>"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>