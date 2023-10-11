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
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
//                 document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

	var checkIdResult = false;			// 아이디 중복확인 여부
	var checkPassResult = false;		// 패스워드 검사
	var checkRetypePassResult = false;	// 패스워드 확인 결과

	// 패스워드 보안강도 검사
	function checkPass(pass){
		// 패스워드 검사를 위한 정규표현식 패턴 작성 및 검사 결과에 따른 변수값 변경
		var spanElem = document.getElementById("checkPassResult");
		
		// 정규표현식 패턴 정의
		var lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/; // 길이 및 사용 가능 문자 규칙
		var engUpperRegex = /[A-Z]/;	// 대문자
		var engLowerRegex = /[a-z]/;	// 소문자
		var numRegex = /[0-9]/;		// 숫자 규칙
		var specRegex = /[!@#$%]/;	// 특수문자 규칙
		
		var count = 0;	// 각 규칙별 검사 결과를 카운팅 할 변수
		
		if(lengthRegex.exec(pass)){	// 패스워드 길이 및 사용 가능 문자 규칙 통과 시
			spanElem.innerHTML = "사용 가능한 패스워드";
			spanElem.style.color = "GREEN";
			
			// 각 규칙별 검사 후 해당 항목이 포함되어 있을 경우 카운트 증가
			if(engUpperRegex.exec(pass)) count++;
			if(engLowerRegex.exec(pass)) count++;
			if(numRegex.exec(pass)) count++;
			if(specRegex.exec(pass)) count++;
			
			switch(count){
			case 4:	// 특수문자, 대문자, 소문자, 숫자 중 4개를 만족
				spanElem.innerHTML = "사용 가능한 패스워드(안전)";
				spanElem.style.color = "GREEN";
				checkPassResult = true;
				break;
			case 3: // 특수문자, 대문자, 소문자, 숫자 중 3개를 만족
				spanElem.innerHTML = "사용 가능한 패스워드(보통)";
				spanElem.style.color = "YELLOW";
				checkPassResult = true;
				break;
			case 2: // 특수문자, 대문자, 소문자, 숫자 중 2개를 만족
				spanElem.innerHTML = "사용 가능한 패스워드(위험)";
				spanElem.style.color = "ORANGE";
				checkPassResult = true;
				break;
			default: 
				spanElem.innerHTML = "영문자, 숫자, 특수문자 중 2가지 이상 조합 필수!";
				spanElem.style.color = "RED";
				checkPassResult = false;
			}			
		} else {
			//spanElem.innerHTML = "사용 불가능한 패스워드";
			spanElem.innerHTML = "영문자, 숫자, 특수문자 조합 8 ~ 16자리 필수";
			spanElem.style.color = "RED";
			checkPassResult = false;
		}
		
	}
	
	// 패스워드 일치 여부 검사
	function checkRetypePass(pass2){
		var pass = document.fr.pass.value;
		var spanElem = document.getElementById("checkRetypePassResult");
		if(pass == pass2){	// 패스워드 일치
			spanElem.innerHTML = "패스워드 일치";
			spanElem.style.color = "GREEN";
			checkRetypePassResult = true;
		} else {	// 패스워드 불일치
			spanElem.innerHTML = "패스워드 불일치";
			spanElem.style.color = "RED"
			checkRetypePassResult = false;
		}
		
	}
	
	function checkSubmit(){
		
		if(!checkIdResult){
			alert("아이디 중복확인 필수!");
			document.fr.id.focus();
			return false;
		} else if(!checkPassResult){
			alert("올바른 패스워드 입력 필수!");
			document.fr.pass.focus();
			return false;
		} else if(!checkRetypePassResult){
			alert("패스워드 확인 필수!");
			document.fr.pass2.focus();
			return false;
		}
		
//		return true;
	}
	
	
// 	//아이디 중복체크
// 	function dupCheck() {
// 		//아이디 입력 체크
// 		var id = document.fr.id.value;
// 		if(id==""){
// 			alert("아이디 입력하세요");
// 			document.fr.id.focus();
// 			return;
// 		}
// 		//창을 열어서 아이디 중복체크
// 		window.open("dupCheck.jsp?id="+id,"win","width=400,height=300");
// 	} 
</script>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// class="dup" 클릭했을때 
		$('.dup').click(function(){
	//			alert("클릭");
	//      dupCheck.jsp 갈때   class="id" val()을 들고 가서 아이디 중복체크 하고 
	//       그결과를 가져와서 
			$.ajax({
				url:'dupCheck2.jsp',
				data:{'id':$('.id').val()},
				success:function(rdata){
					$(this).html(rdata).css('color','blue');
				}
				
			});
		});
	});
</script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<form action="joinPro.jsp" id="join" name="fr" method="post" > <!-- onsubmit="return checkSubmit()" -->
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id">
<!-- onclick="dupCheck()" -->
<input type="button" value="dup. check" class="dup" ><br>
<div id="dupdiv"></div>
<label>Password</label>
<input type="password" name="pass" onkeyup="checkPass(this.value)">
<span id="checkPassResult"><!-- 패스워드 규칙 판별 결과 표시 영역 --></span><br>
<label>Retype Password</label>
<input type="password" name="pass2" onblur="checkRetypePass(this.value)">
<span id="checkRetypePassResult"><!-- 패스워드 일치 여부 표시 영역 --></span><br>
<label>Name</label>
<input type="text" name="name"><br>
<label>E-Mail</label>
<input type="email" name="email"><br>
<label>Retype E-Mail</label>
<input type="email" name="email2"><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Post Number</label>
<input type="text" id="postcode" placeholder="우편번호" name="post">
<input type="button" class="dup" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
<label>Address</label>
<input type="text" id="address" placeholder="주소" name="address">
<input type="text" id="detailAddress" placeholder="상세주소" name="address2"><br>
<!-- <input type="text" id="sample6_extraAddress" placeholder="참고항목"><br> -->
<label>Address</label>
<input type="text" name="address"><br>
<label>Phone Number</label>
<input type="text" name="phone"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>