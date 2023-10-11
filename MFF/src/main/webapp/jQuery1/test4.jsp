<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery1/test4.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#fr').submit(function(){
// 			alert($('#id').val());
// 			alert($('#pass').val());
			if($('#id').val()==""){
				alert("입력하세요");
				$('#id').focus();
				return false;
			}
			
		});
	});
</script>
</head>
<body>
<form action="a.jsp" method="post" id="fr">
아이디 : <input type="text" name="id" id="id"><br>
비밀번호 : <input type="password" name="pass" id="pass"><br>
<input type="submit" value="전송">
</form>
</body>
</html>


