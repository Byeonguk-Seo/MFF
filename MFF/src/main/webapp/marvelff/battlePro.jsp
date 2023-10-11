<%@page import="java.util.ArrayList"%>
<%@page import="information.InformationDTO"%>
<%@page import="information.InformationDAO"%>
<%@page import="boss.BossDTO"%>
<%@page import="boss.BossDAO"%>
<%@page import="myhero.MyheroDTO"%>
<%@page import="java.util.List"%>
<%@page import="myhero.MyheroDAO"%>
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
String hero = request.getParameter("hero");
String boss = request.getParameter("boss");

BossDAO bossDAO = new BossDAO();
MyheroDAO myheroDAO = new MyheroDAO();
InformationDAO informationDAO = new InformationDAO();

List list = new ArrayList();
list.add(id);
list.add(hero);

BossDTO bossDTO = bossDAO.getBoss(boss);
MyheroDTO myheroDTO = myheroDAO.getMyhero(list);
InformationDTO bossInformationDTO = informationDAO.getInformation(boss);
InformationDTO myheroInformationDTO = informationDAO.getInformation(hero);

int count = 0;
int bossLife = Integer.parseInt(bossDTO.getLife());
int bossAttack = Integer.parseInt(bossDTO.getAttack());
int myheroLife = myheroDTO.getLife();
int myheroAttack = myheroDTO.getAttack();
%>
<table>
	<tr><td><img alt="<%=myheroDTO.getHero()%>" src="../img/hero/<%=myheroInformationDTO.getPicture()%>"></td><td align="center">VS</td><td><img alt="<%=bossDTO.getHero()%>" src="../img/hero/<%=bossInformationDTO.getPicture()%>"></td></tr>
</table>
<%

while(bossLife > 0){
	count++;
	bossLife -= myheroAttack;
	myheroLife -= bossAttack;
	
	if(bossLife < 0){	bossLife = 0;	}
	if(myheroLife < 0){	myheroLife = 0;	}
	
	%>
	<h2>제<%=count %>턴</h2>
	<p><%=myheroDTO.getHero()%>의 공격 <%=bossDTO.getHero()%>의  남은 HP : <%=bossLife%>(-<%=myheroDTO.getAttack() %>)</p>
	<p><%=bossDTO.getHero()%>의 공격 <%=myheroDTO.getHero()%>의  남은 HP : <%=myheroLife %>(-<%=bossDTO.getAttack()%>)</p>
	<hr>
	<%
	if(bossLife == 0){	break;	}
	if(myheroLife == 0){	break;	}
}
%>
<p><%=myheroDTO.getHero()%>의 승리</p>
<p>획득 경험치 : <%=bossDTO.getExp() %></p>
<%
int exp = myheroDTO.getExp() + Integer.parseInt(bossDTO.getExp());
myheroDAO.updateMyhero(myheroDTO, exp);
%>
<input type="button" value="돌아가기" class="btn" onclick="location.href='battle.jsp'">
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>



