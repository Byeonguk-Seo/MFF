<%@page import="store.StoreDTO"%>
<%@page import="store.StoreDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="ability.AbilityDTO"%>
<%@page import="ability.AbilityDAO"%>
<%@page import="myhero.MyheroDTO"%>
<%@page import="myhero.MyheroDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String id=(String)session.getAttribute("id");
String hero = request.getParameter("hero");

MemberDAO memberDAO = new MemberDAO();
MyheroDAO myheroDAO = new MyheroDAO();
AbilityDAO abilityDAO = new AbilityDAO();
StoreDAO storeDAO = new StoreDAO();

AbilityDTO abilityDTO = abilityDAO.getAbility(hero);

MemberDTO memberDTO = memberDAO.getMember(id);
MyheroDTO myheroDTO = new MyheroDTO();

myheroDTO.setUid(id);
myheroDTO.setHero(hero);
myheroDTO.setAttack(abilityDTO.getAttack());
myheroDTO.setPdefense(abilityDTO.getPdefense());
myheroDTO.setEdefense(abilityDTO.getEdefense());
myheroDTO.setLife(abilityDTO.getLife());


StoreDTO storeDTO = storeDAO.getStore(hero);

int price = 0;
if(memberDTO.getMoney() - storeDTO.getPrice() > 0){
	price = memberDTO.getMoney() - storeDTO.getPrice();
	myheroDAO.insertMyhero(myheroDTO);
	memberDTO.setMoney(price);
	memberDAO.updateMember(memberDTO);
	
} else {
	out.println("포인트가 부족합니다.");
}


response.sendRedirect("../marvelff/store.jsp");
%>
</body>
</html>