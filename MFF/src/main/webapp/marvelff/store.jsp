<%@page import="store.StoreDTO"%>
<%@page import="store.StoreDAO"%>
<%@page import="java.util.List"%>

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
<%
String id=(String)session.getAttribute("id");
//세션값이 없으면 login.jsp 이동
if(id==null){
	response.sendRedirect("../member/login.jsp");
}
%>
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
<li><a href="../marvelff/mypage.jsp">My Page</a></li>
<li><a href="../marvelff/store.jsp">Store</a></li>
<li><a href="../member/update.jsp">Update</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>Store</h1>
<!-- <figure class="ceo"><img src="../images/company/CEO.jpg" width="196" height="226"  -->
<!-- alt="CEO"><figcaption>Fun Web CEO Michael</figcaption> -->
<!-- </figure> -->

<%
int pageSize = 10;
String pageNum = request.getParameter("pageNum");

if(pageNum == null){
	pageNum = "1";	
}

int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow = startRow+pageSize-1;

StoreDAO storeDAO = new StoreDAO();


List stoerList = storeDAO.getStoreList(startRow, pageSize, id);
%>


<!-- 내용 -->
<table id="notice">
<%
for(int i=0;i<stoerList.size();i+=5){
%>
	<tr>
<%
	for(int j = 0; j < 5; j++){
	   StoreDTO StoreDTO=(StoreDTO)stoerList.get(j+i);
%>
	<td colspan="2"><img alt="<%=StoreDTO.getHero() %>" src="../img/hero/<%=StoreDTO.getPicture() %>"></td>
<%
	}
%>
	</tr>
	<tr>
<%
	for(int j = 0; j < 5; j++){
		   StoreDTO StoreDTO=(StoreDTO)stoerList.get(j+i);
%>
	<td colspan="2"><%=StoreDTO.getHero() %></td>
<%
	}
%>
	</tr>
	<tr>
<%
	for(int j = 0; j < 5; j++){
		   StoreDTO StoreDTO=(StoreDTO)stoerList.get(j+i);   
%>
	<td>포인트 : <%=StoreDTO.getPrice() %></td>
	<td><input type="button" name="buy" value="구매" onclick="location.href='storePro.jsp?hero=<%=StoreDTO.getHero()%>'"></td>
<%
	}
%>
	</tr>
<%
}
%> 
</table>

<!-- 본문 들어가는 곳 -->
<%
int pageBlock = 10;
int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
int endPage = startPage + pageBlock - 1;
int count = storeDAO.getStoreCount(id);
int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
if(endPage > pageCount){
	endPage = pageCount;
}
%>
<div id="page_control">

<%
if(startPage > pageBlock){
	%>
	<a href="store.jsp?pageNum=<%=startPage - pageBlock %>">Prev</a>
	<%
}

for(int i = startPage; i < endPage + 1; i++){
	%>
	<a href="store.jsp?pageNum=<%=i %>"><%=i %></a>
	<%
}	

if(endPage < pageCount){
	%>
	<a href="store.jsp?pageNum=<%=startPage + pageBlock %>">Next</a>
	<%
}
%>
</div>
</article>
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>



