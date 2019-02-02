<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>영화 예약 시스템</title>

	<!--  <script src="js/jquery-3.3.1.js"></script>-->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js">
	</script>
</head>

<body>
<br/>
	<h>회원 테이블</h>
	<button onclick='insertUser()'>회원 추가</button>
<br/>
	<table border="1px" width="500px;">
		<thead>
			<tr>
				<th>userID</th>
				<th>name</th>
				<th>password</th>
				<th>birthdate</th>
				<th>address</th>
				<th>phone</th>
				<th>point</th>
			</tr>
		</thead>
		<tbody id="content_user"></tbody>
	</table>
	
<br>
	<h>영화 테이블</h>
	<button onclick='InsertMovie()'>영화 추가</button>
<br/>
	<table border="1px" width="500px;">
		<thead>
			<tr>
				<th>movieID</th>
				<th>movieName</th>
				<th>director</th>
				<th>actor</th>
				<th>grade</th>
				<th>inform</th>
				<th>runningTime</th>
			</tr>
		</thead>
	<tbody id="content_movie"> </tbody>
	</table>
	
<br>
<h>영화관 테이블</h>
<button onclick='insertTheater()'>영화관 추가</button>
<br/>
<table border="1px" width="500px;">
			<thead>
				<tr>
					<th>theaterID</th>
					<th>theaterName</th>
					<th>address</th>
					<th>telephone</th>
				</tr>
			</thead>
			<tbody id="content_theater"></tbody>
</table>

<br>
<script type="text/javascript"> 

function deleteMovie(i) {
	 $('#form_movie_'+i).attr('action'
			 , './DB/Movie/DeleteMovie.jsp');
	$('#form_movie_'+i).submit();
}

</script>


</body>
</html>