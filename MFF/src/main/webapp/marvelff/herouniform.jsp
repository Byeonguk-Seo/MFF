<%@page import="skill.SkillDTO"%>
<%@page import="skill.SkillDAO"%>
<%@page import="equipment.EquipmentDTO"%>
<%@page import="equipment.EquipmentDAO"%>
<%@page import="ability.AbilityDTO"%>
<%@page import="ability.AbilityDAO"%>
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
String uniform = request.getParameter("uniform");
// BoardDAO 객체생성
UniformDAO uniformDAO = new UniformDAO();
AbilityDAO abilityDAO = new AbilityDAO();
EquipmentDAO equipmentDAO = new EquipmentDAO();
SkillDAO skillDAO = new SkillDAO();

// BoardDTO boardDTO = boardDAO.getBoard(num) 메서드 호출
UniformDTO uniformDTO = uniformDAO.getUniform(hero, uniform);
AbilityDTO abilityDTO = abilityDAO.getAbility(hero);
EquipmentDTO equipmentDTO = equipmentDAO.getEquipment(hero);
SkillDTO skillDTO = skillDAO.getSkill(hero);
%>
<article>
<h1>Hero Information</h1>
<table id="notice">
<tr><td>이름</td><td><%=uniformDTO.getHero() %></td><td colspan="2" rowspan="4"><img alt="<%=uniformDTO.getUniform() %>" src="../img/uniform/<%=uniformDTO.getPicture() %>" height="100" width="100"></td></tr>
<tr><td>유니폼</td><td><%=uniformDTO.getUniform() %></td></tr>
<tr><td>업데이트</td><td><%=uniformDTO.getUpday() %></td></tr>
<tr><td>타입</td><td><%=abilityDTO.getProperty() %></td></tr>
<tr><td colspan="4">능력치</td></tr>
<tr><td>공격력</td><td>물리 방어력</td><td>에너지 방어력</td><td>체력</td></tr>
<tr><td><%=abilityDTO.getAttack() %></td><td><%=abilityDTO.getPdefense() %></td><td><%=abilityDTO.getEdefense() %></td><td><%=abilityDTO.getLife() %></td></tr>
<tr><td colspan="4">장비</td></tr>
<tr><td><%=equipmentDTO.getEquipment1() %></td><td><%=equipmentDTO.getEquipment2() %></td><td><%=equipmentDTO.getEquipment3() %></td><td><%=equipmentDTO.getEquipment4() %></td></tr>
<tr><td colspan="4">스킬</td></tr>
<tr><td>스크라이커 스킬</td><td>궁극 스킬</td><td>각성 스킬</td><td>리더 스킬</td></tr>
<tr><td><%=skillDTO.getStriker()%></td><td><%=skillDTO.getUltimate()%></td><td><%=skillDTO.getAwakened()%></td><td><%=skillDTO.getLeader()%></td></tr>
<tr><td colspan="2">패시브 스킬</td><td colspan="2">액티브 스킬</td></tr>
<tr><td rowspan="2" colspan="2"><%=skillDTO.getPassive1()%></td><td colspan="2"><%=skillDTO.getActive1()%></td></tr>
<tr><td colspan="2"><%=skillDTO.getActive2()%></td></tr>
<tr><td rowspan="3" colspan="2"><%=skillDTO.getPassive2()%></td><td colspan="2"><%=skillDTO.getActive3()%></td></tr>
<tr><td colspan="2"><%=skillDTO.getActive4()%></td></tr>
<tr><td colspan="2"><%=skillDTO.getActive5()%></td></tr>
</table>

<div id="table_search">

<input type="button" value="글목록" class="btn" onclick="location.href='heroinformantion.jsp?hero=<%=uniformDTO.getHero() %>'">
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