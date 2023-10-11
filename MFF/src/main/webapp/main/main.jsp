<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="hero.HeroDTO"%>
<%@page import="java.util.List"%>
<%@page import="hero.HeroDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/ht
ml5.js" type="text/javascript"></script>
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
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../img/mainimage/main.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->

<%
HeroDAO heroDAO = new HeroDAO();

int pageSize = 5;
String pageNum = request.getParameter("pageNum");

if(pageNum == null){
	pageNum = "1";	
}

int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow = startRow+pageSize-1;

List heroList = heroDAO.getHeroList(startRow, pageSize);
%>
<div class="clear"></div>
<div id="news_notice">
<h3 class="orange"><span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Hero</span></h3>
<table>
<%
for(int i = 0; i < heroList.size(); i++){
	   HeroDTO heroDTO = (HeroDTO)heroList.get(i);
%>
<tr onclick="location.href='../marvelff/heroinformantion.jsp?hero=<%=heroDTO.getHero()%>'">
    <td><%=heroDTO.getHero() %></td>
    <td><%=heroDTO.getUpday() %></td></tr>	   
	   <%
   }
   %> 
</table>
</div>
<%
BoardDAO boardDAO = new BoardDAO();

List boardList = boardDAO.getBoardList(startRow,pageSize);
%>

<div id="news_notice">
<h3 class="brown">News &amp; Notice</h3>
<table>

<%
for(int i = 0; i < boardList.size(); i++){
	   BoardDTO boardDTO = (BoardDTO)boardList.get(i);
	   %>
<tr onclick="location.href='../center/content.jsp?num=<%=boardDTO.getNum()%>'">
    <td><%=boardDTO.getSubject() %></td>
    <td><%=boardDTO.getDate() %></td></tr>	   
	   <%
   }
   %> 
</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>