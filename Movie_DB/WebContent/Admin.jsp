<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MovieReservation_DB</title>

<!--  <script src="js/jquery-3.3.1.js"></script>-->
<script 
src="https://code.jquery.com/jquery-3.2.1.min.js">
</script>

</head>
<body>

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
			<tbody id="content_movie"></tbody>
</table>

<br>


</script>
<script type="text/javascript"> 

function insertMovie()
{
	window.open( "./popup/popup_movie_insert.jsp", "insert", "width=400,height=400" );
}

function updateMovie(i)
{
 var tw = window.open( "", "update", "width=400,height=400" );
 //새창으로 post방식으로 값 넘길때 사용

 $('#form_movie_'+i).attr('action', './popup/popup_movie_update.jsp');
 $('#form_movie_'+i).attr('target', 'update');
 $('#form_movie_'+i).submit();
}

function deleteMovie(i) {
	 $('#form_movie_'+i).attr('action'
			 , './DB/Movie/DeleteMovie.jsp');
	$('#form_movie_'+i).submit();
}

</script>


</body>
</html>