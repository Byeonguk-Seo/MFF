
<%@page import="information.InformationDTO"%>
<%@page import="information.InformationDAO"%>
<%@page import="boss.BossDTO"%>
<%@page import="java.util.List"%>
<%@page import="boss.BossDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../marvelff/herolist.jsp">Hero List</a></li>
<li><a href="../marvelff/battle.jsp">battle</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>Battle</h1>
<!-- <figure class="ceo"><img src="../images/company/CEO.jpg" width="196" height="226"  -->
<!-- alt="CEO"><figcaption>Fun Web CEO Michael</figcaption> -->
<!-- </figure> -->

<%
String id=(String)session.getAttribute("id");
//세션값이 없으면 login.jsp 이동
if(id==null){
	response.sendRedirect("../member/login.jsp");
}

BossDAO bossDAO = new BossDAO();
InformationDAO informationDAO = new InformationDAO();

List bossList = bossDAO.getBossList();
%>


<!-- 내용 -->
<table id="notice">
<tr><th class="tno"></th><th class="ttitle">Boss</th><th class="twrite">Level</th><th class="tread"></th></tr>

<%
for(int i = 0; i < bossList.size(); i++){
	   BossDTO bossDTO = (BossDTO)bossList.get(i);
%>
<tr><td><img alt="<%=bossDTO.getHero()%>" src="../img/hero/<%=bossDTO.getPicture() %>"></td><td><%=bossDTO.getHero()%></td><td><%=bossDTO.getLevel()%></td>
	<td><input type="button" name="battle" value="배틀" onclick="location.href='battlechoice.jsp?hero=<%=bossDTO.getHero()%>'"></td></tr>
<%
	}

%>
</table>

<!-- 본문 들어가는 곳 -->

</article>
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>



