<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery1/test3.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//이벤트 대상.bind()  대상.click()
	$('h1').bind('click',function(){
		// h1 내용 변경
// 		$('h1').html('내용변경');
		// 클릭한 h1 내용 변경
		$(this).html("클릭변경");
	});
	
	//p태그 클릭했을때 + 추가
	$('p').click(function(){
		// 클릭한 p태그 +추가
		$(this).append("+");
		// 이벤트를 한번만 수행하고 멈춤
		$(this).unbind();
	});
});
</script>
</head>
<body>
<p>내용1</p>
<p>내용2</p>
<p>내용3</p>
<h1>제목1</h1>
<h1>제목2</h1>
<h1>제목3</h1>
</body>
</html>