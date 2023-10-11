<%@page import="hero.HeroDTO"%>
<%@page import="hero.HeroDAO"%>
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
// 패키지 board 파일이름 BoardDTO   멤버변수정의 set() get()
// 패키지 board 파일이름 BoardDAO   getBoardList()메서드 정의
// BoardDAO 객체생성
HeroDAO heroDAO=new HeroDAO();

int pageSize=10;

String pageNum=request.getParameter("pageNum");
if(pageNum==null){
	pageNum="1";	
}

int currentPage=Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow=startRow+pageSize-1;

// List boardList = getBoardList()메서드 호출
List heroList=heroDAO.getHeroList(startRow, pageSize);
%>
<article>
<h1>Hero List</h1>
<table id="notice2">
<tr><th class="tno">No.</th>
    <th class="thero">Hero</th>
    <th class="tupdate">Update</th></tr>
   <%
   //날짜 => 문자열 모양변경
   SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy.MM.dd");
   for(int i=0;i<heroList.size();i++){
	   HeroDTO heroDTO=(HeroDTO)heroList.get(i);
	   %>
<tr onclick="location.href='heroinformantion.jsp?hero=<%=heroDTO.getHero()%>'">
   <td><%=heroDTO.getNum() %></td>
    <td><%=heroDTO.getHero() %></td>
    <td><%=heroDTO.getUpday() %></td></tr>	   
	   <%
   }
   %> 
</table>
<div id="table_search">
<input type="text" name="search" class="input_box">
<input type="button" value="search" class="btn">
</div>
<div class="clear"></div>
<%
int pageBlock = 10;
int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
int endPage = startPage + pageBlock - 1;
int count = heroDAO.getHeroCount();
int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
if(endPage > pageCount){
	endPage = pageCount;
}
%>

<div id="page_control">
<%
if(startPage > pageBlock){
	%>
	<a href="herolist.jsp?pageNum=<%=startPage - pageBlock %>">Prev</a>
	<%
}

for(int i = startPage; i < endPage + 1; i++){
	%>
	<a href="herolist.jsp?pageNum=<%=i %>"><%=i %></a>
	<%
}

if(endPage < pageCount) {
	%>
	<a href="herolist.jsp?pageNum=<%=startPage + pageBlock %>">Next</a>
	<%
}
%>
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