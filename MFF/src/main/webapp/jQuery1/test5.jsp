<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery1/test5.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// id="btn" 클릭했을때   =>  id="dupdiv" 내용변경 "아이디 사용가능"
		$('#btn').click(function(){
			// AJAX는 Asynchronous JavaScript and XML의 약자
			// JavaScript와 XML을 이용한 비동기적 정보 교환 기법
			$.ajax({
				url:'dupCheck2.jsp',
				data:{'id':$('#id').val()},
				success:function(rdata){
					$('#dupdiv').html(rdata).css('color','blue');
				}
				
			});
			
		});
		
	});
</script>
</head>
<body>
아이디<input type="text" name="id" id="id">
<input type="button" value="아이디중복체크" id="btn"><br>
<div id="dupdiv"></div>
</body>
</html>