<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery1/test2.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 대상에 내용을 변경하는 함수 
		$('div').html('아이디 중복');
		$('div').html('아이디 사용가능');
		// 대상에 내용을 뒤부분에 추가하는 함수
		$('p').append('글추가1');
		$('p').append('글추가2');
	});
</script>
</head>
<body>
<div>내용</div>
<p>내용추가</p>
</body>
</html>