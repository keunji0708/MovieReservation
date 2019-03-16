<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <% String theaterID = request.getParameter("theaterID"); %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>영화 예약 시스템</title>
</head>
<body>
	<h2>상영관 등록</h2>
	
	<form method= "post" action="/Movie_DB/DB/Screen/InsertScreen.jsp">
		상영관 : <input type="text" name="screen" maxlength="20"><br/>
		좌석수 : <input type="text" name="seat" maxlength="10"><br/>
		비용 : <input type="text" name="cost" maxlength="10"><br/>
		영화관ID : <input type="hidden" name="theaterID" maxlength="10" value='<%= theaterID %>' ><%= theaterID %><br/>
		
		<input type="submit" value="상영관 등록">	
		<input type="reset" value="다시입력">		
	</form>

</body>
</html>
