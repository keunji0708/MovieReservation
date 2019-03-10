<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>영화 정보 등록</title>
</head>
<body>
	<h2>영화 등록 폼</h2>
	
	<form method= "post" action="/DatabaseTermp/db/movie/insertMovie.jsp">
		영화제목 : <input type="text" name="movieName" maxlength="20"><br/>
		감독 : <input type="text" name="director" maxlength="20"><br/>
		출연 : <input type="text" name="actor" maxlength="20"><br/>
		등급 : <input type="text" name="grade" maxlength="20"><br/>
		주요 정보 : <input type="text" name="inform" maxlength="20"><br/>
		상영 시간 : <input type="text" name="runningtime" maxlength="20"><br/>
		<input type="submit" value="영화 등록">	
		<input type="reset" value="다시입력">	
	</form>

</body>
</html>
