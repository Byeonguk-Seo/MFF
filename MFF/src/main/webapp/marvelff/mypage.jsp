<%@page import="exp.ExpDTO"%>
<%@page import="exp.ExpDAO"%>
<%@page import="myhero.MyheroDTO"%>
<%@page import="myhero.MyheroDAO"%>
<%@page import="java.util.List"%>
<%@page import="myhero.MyheroDTO"%>
<%@page import="myhero.MyheroDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="information.InformationDTO"%>
<%@page import="information.InformationDAO"%>
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
<li><a href="../marvelff/mypage.jsp">My Page</a></li>
<li><a href="../marvelff/store.jsp">Store</a></li>
<li><a href="../member/update.jsp">Update</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>My Page</h1>
<!-- <figure class="ceo"><img src="../images/company/CEO.jpg" width="196" height="226"  -->
<!-- alt="CEO"><figcaption>Fun Web CEO Michael</figcaption> -->
<!-- </figure> -->

<%
String id=(String)session.getAttribute("id");
//세션값이 없으면 login.jsp 이동
if(id==null){
	response.sendRedirect("../member/login.jsp");
}

int pageSize = 10;
String pageNum = request.getParameter("pageNum");

if(pageNum == null){
	pageNum = "1";	
}

int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow = startRow+pageSize-1;

MemberDAO memberDAO = new MemberDAO();
MyheroDAO myHeroDAO = new MyheroDAO();
ExpDAO expDAO = new ExpDAO();

MemberDTO memberDTO = memberDAO.getMember(id);
List myHeroList = myHeroDAO.getMyheroList(startRow, pageSize, id);

%>


<!-- 내용 -->
<table id="notice">
<tr><td>아이디</td><td><%=memberDTO.getId()%></td><td>포인트</td><td><%=memberDTO.getMoney()%></td></tr>
<tr><td colspan="4">보유 히어로</td></tr>
<tr><td>이름</td><td>레벨</td><td>경험치</td><td>레벨업</td></tr>

<%
for(int i = 0; i < myHeroList.size(); i++){
	MyheroDTO myHeroDTO = (MyheroDTO)myHeroList.get(i);
	ExpDTO expDTO = expDAO.getExp(myHeroDTO.getHlevel());
%>	
	<tr><td><%=myHeroDTO.getHero()%></td><td><%=myHeroDTO.getHlevel()%></td><td><%=myHeroDTO.getExp()%></td>
<%
	if(expDTO.getExp() <= myHeroDTO.getExp()){
		if(myHeroDTO.getHlevel() < 99){
%>
	<td><input type="button" value="레벨업" onclick="location.href='levelup.jsp?id=<%=id%>&hero=<%=myHeroDTO.getHero()%>'"></td></tr>
<%
		}
		} else {
		%>
		<td></td></tr>
		<%
	}
	
}
%>
</table>

<!-- 본문 들어가는 곳 -->
<%
int pageBlock = 10;
int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
int endPage = startPage + pageBlock - 1;
int count = myHeroDAO.getMyheroCount();
int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
if(endPage > pageCount){
	endPage = pageCount;
}
%>
<div id="page_control">

<%
if(startPage > pageBlock){
	%>
	<a href="mypage.jsp?pageNum=<%=startPage - pageBlock %>">Prev</a>
	<%
}

for(int i = startPage; i < endPage + 1; i++){
	%>
	<a href="mypage.jsp?pageNum=<%=i %>"><%=i %></a>
	<%
}	

if(endPage < pageCount){
	%>
	<a href="mypage.jsp?pageNum=<%=startPage + pageBlock %>">Next</a>
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



