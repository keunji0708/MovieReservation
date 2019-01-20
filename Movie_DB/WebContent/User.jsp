<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화 예약 시스템</title>
</head>

<!-- jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<!-- jQuery 기본 js파일  --> 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<!-- jQuery UI 라이브러리 js파일  --> 
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  


<body> 회원가입
	<form action="/DatabaseTermp/db/insertUser.jsp" method="POST">
		I     D  : <input type="text" name="userID" /><br>
		PASSWORD : <input type="password" name="userPwd"/><br>
		NAME  : <input type="text" name="userName" /><br>
		BIRTHDATE : <input type="text" id="userDate" name="userDate"/><br>
		ADDRESS : <input type="text" name="userAddress"/><br>
		PHONE : <input type="text" name="userPhone" /><br>
	<input type="submit" value="전송" /><br>
	</form>
	<br>
-------------------------------------------------
<br>
<br> 로그인
<form action="/DatabaseTermp/db/loginUser.jsp">
I     D  : <input type="text" name="userID2" /><br>
PASSWORD : <input type="password" name="userPwd2"/><br>
<input type="submit" value="로그인" />
</form>

</body>
</html>