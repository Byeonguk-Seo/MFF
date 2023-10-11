<%@page import="exp.ExpDTO"%>
<%@page import="exp.ExpDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
String id=(String)session.getAttribute("id");
String hero = request.getParameter("hero");
List list = new ArrayList();

list.add(id);
list.add(hero);

MyheroDAO myheroDAO = new MyheroDAO();
ExpDAO expDAO = new ExpDAO();

MyheroDTO myheroDTO = myheroDAO.getMyhero(list);
ExpDTO expDTO = expDAO.getExp(myheroDTO.getHlevel());


myheroDAO.levelUpMyhero(myheroDTO, myheroDTO.getExp()-expDTO.getExp(), myheroDTO.getHlevel()+1);

response.sendRedirect("mypage.jsp");
%>
</body>
</html>