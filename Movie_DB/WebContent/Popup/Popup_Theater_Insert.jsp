<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>영화 예약 시스템</title>
</head>
<body>
	<h2>영화관 등록</h2>
	
	<form method= "post" action="/DatabaseTermp/db/theater/insertTheater.jsp">
		영화관 이름 : <input type="text" name="theaterName" maxlength="20"><br/>
		영화관 주소 : <input type="text" name="address" maxlength="50"><br/>
		영화관 전화번호 : <input type="text" name="telephone" maxlength="20"><br/>
		
		<input type="submit" value="영화관 등록">	
		<input type="reset" value="다시입력">	
	</form>

</body>
</html>

