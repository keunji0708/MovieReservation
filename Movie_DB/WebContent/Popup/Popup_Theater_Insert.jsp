<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ȭ ���� �ý���</title>
</head>
<body>
	<h2>��ȭ�� ���</h2>
	
	<form method= "post" action="/DatabaseTermp/db/theater/insertTheater.jsp">
		��ȭ�� �̸� : <input type="text" name="theaterName" maxlength="20"><br/>
		��ȭ�� �ּ� : <input type="text" name="address" maxlength="50"><br/>
		��ȭ�� ��ȭ��ȣ : <input type="text" name="telephone" maxlength="20"><br/>
		
		<input type="submit" value="��ȭ�� ���">	
		<input type="reset" value="�ٽ��Է�">	
	</form>

</body>
</html>

