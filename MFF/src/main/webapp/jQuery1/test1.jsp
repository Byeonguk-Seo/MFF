<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery1/test1.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
// 		alert("준비완료");
		// 대상지정  전체 *, 태그, id=이름 #이름, class=이름 .이름
		$('*').css('color','blue');
		$('h1').css('color','red');
		$('#aa1').css('color','green');
		$('.aa2').css('color','pink');
		// 태그[속성=값],  태그[속성~=값] 포함,  태그[속성^=값] 시작값,  태그[속성$=값] 끝값
		$('input[type=text]').css('color','skyblue');
		$('input[type=password]').css('color','purple');
	});
</script>
</head>
<body>
<input type="text" name="id" value="kim">
<input type="password" name="pass">
<h1>제목1</h1>
<h1 id="aa1">제목2</h1>
<h1 class="aa2">제목3</h1>
본문내용
</body>
</html>