<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <% String theaterID = request.getParameter("theaterID"); %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ȭ ���� �ý���</title>
</head>
<body>
	<h2>�󿵰� ���</h2>
	
	<form method= "post" action="/Movie_DB/DB/Screen/InsertScreen.jsp">
		�󿵰� : <input type="text" name="screen" maxlength="20"><br/>
		�¼��� : <input type="text" name="seat" maxlength="10"><br/>
		��� : <input type="text" name="cost" maxlength="10"><br/>
		��ȭ��ID : <input type="hidden" name="theaterID" maxlength="10" value='<%= theaterID %>' ><%= theaterID %><br/>
		
		<input type="submit" value="�󿵰� ���">	
		<input type="reset" value="�ٽ��Է�">		
	</form>

</body>
</html>
