<%@page import="uniform.UniformDTO"%>
<%@page import="uniform.UniformDAO"%>
<%@page import="information.InformationDTO"%>
<%@page import="information.InformationDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/content.jsp</title>
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
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../marvelff/herolist.jsp">Hero List</a></li>
<li><a href="../marvelff/battle.jsp">battle</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
// int num 파라미터 가져오기
String hero = request.getParameter("hero");
// BoardDAO 객체생성
InformationDAO informationDAO = new InformationDAO();
UniformDAO uniformDAO = new UniformDAO();

// BoardDTO boardDTO = boardDAO.getBoard(num) 메서드 호출
InformationDTO infromationDTO = informationDAO.getInformation(hero);

List uniformList = uniformDAO.getUniformList(hero);

%>
<article>
<h1>Hero Information</h1>
<table id="notice">
<tr><td>이름</td><td><%=infromationDTO.getHero() %></td><td colspan="2" rowspan="4"><img alt="<%=infromationDTO.getEname() %>" src="../img/hero/<%=infromationDTO.getPicture() %>" height="100" width="100"></td></tr>
<tr><td>본명</td><td><%=infromationDTO.getHname() %></td></tr>
<tr><td>종족</td><td><%=infromationDTO.getTribe() %></td></tr>
<tr><td>성별</td><td><%=infromationDTO.getGender() %></td></tr>
<tr><td>진영</td><td><%=infromationDTO.getCamp() %></td><td>천성</td><td><%=infromationDTO.getNature() %></td></tr>
<tr><td>키</td><td><%=infromationDTO.getHeight() %></td><td>몸무게</td><td><%=infromationDTO.getWeight() %></td></tr>
<tr><td>능력</td><td><%=infromationDTO.getAbility1() %></td><td><%=infromationDTO.getAbility2() %></td><td><%=infromationDTO.getAbility3() %></td></tr>
<tr><td colspan="4">배경</td></tr>
<tr><td colspan="4" class="background"><%=infromationDTO.getBackground() %></td></tr>
</table>

<table id="notice">
<tr><td colspan="4">유니폼</td></tr>
<tr><td colspan="3">이름</td><td>업데이트</td></tr>
<%
   //날짜 => 문자열 모양변경
   for(int i=0;i<uniformList.size();i++){
	   UniformDTO uniformDTO=(UniformDTO)uniformList.get(i);
	   %>
<tr onclick="location.href='herouniform.jsp?hero=<%=uniformDTO.getHero()%>&uniform=<%=uniformDTO.getUniform()%>'">
   <td colspan="3"><%=uniformDTO.getUniform() %></td><td><%=uniformDTO.getUpday() %></td></tr>	   
	   <%
   }
   %> 
</table>

<div id="table_search">

<input type="button" value="글목록" class="btn" onclick="location.href='herolist.jsp'">
</div>
<div class="clear"></div>
<div id="page_control">
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>