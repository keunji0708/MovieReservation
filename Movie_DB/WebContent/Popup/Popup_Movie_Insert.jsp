<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ȭ ���� ���</title>
</head>
<body>
	<h2>��ȭ ��� ��</h2>
	
	<form method= "post" action="/DatabaseTermp/db/movie/insertMovie.jsp">
		��ȭ���� : <input type="text" name="movieName" maxlength="20"><br/>
		���� : <input type="text" name="director" maxlength="20"><br/>
		�⿬ : <input type="text" name="actor" maxlength="20"><br/>
		��� : <input type="text" name="grade" maxlength="20"><br/>
		�ֿ� ���� : <input type="text" name="inform" maxlength="20"><br/>
		�� �ð� : <input type="text" name="runningtime" maxlength="20"><br/>
		<input type="submit" value="��ȭ ���">	
		<input type="reset" value="�ٽ��Է�">	
	</form>

</body>
</html>
