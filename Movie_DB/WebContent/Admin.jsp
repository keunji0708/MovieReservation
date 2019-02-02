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

<script>
$(document).ready(function() {
	$.ajax({
       	type:"POST",
              url:"./db/getUserTable.jsp",
              dataType:"JSON",
              success:function(res){
                 var data="";
                 for(i=0;i<res.length;i++){
               	  
                   	 var p = res;
                     data+="<tr><td>"
                     +p[i].userID+"</td><td>"
                     +p[i].name+"</td><td>"
                     +p[i].password+"</td><td>"
                     +p[i].birthdate+"</td><td>"
                     +p[i].address+"</td><td>"
                     +p[i].phone+"</td><td>"
                     +p[i].point+"</td><td>"
                     +"<button onclick='updateUser("+i+")'>수정</button></form></td><td>"
                     +"<button onclick='deleteUser("+i+")'>삭제</button></td><td>"
                     +"<button onclick='reservation_update(\"" + p[i].userID + "\")'>예약확인</button></td><td>"
                     +"<button onclick='ticket_update(\"" + p[i].userID + "\")'>결제확인</button></td><td>"
                     +"<form id='form_user_"+i+"'method='post'>"
                     +"<input id='userID_"+i+"' type='hidden' name='originID' value="+p[i].userID+" />"                     
                     +"<input id='userPwd_"+i+"' type='hidden' name='originPwd' value="+p[i].password+" />"
                     +"<input id='name"+i+"' type='hidden' name='originName' value="+p[i].name+" />"
                     +"<input id='birthdate"+i+"' type='hidden' name='originBirthDate' value="+p[i].birthdate+" />"
                     +"<input id='address"+i+"' type='hidden' name='originAddress' value="+p[i].address+" />"
                     +"<input id='phone"+i+"' type='hidden' name='originPhone' value="+p[i].phone+" />"
                     +"<input id='point"+i+"' type='hidden' name='originPoint' value="+p[i].point+" />"
                     +"</form></td></tr>";
                 
                 }
                 $('#content_user').html(data);
              },
              error:function() {
                  alert("사용자 목록 없음.");
              }
          })
          
          $.ajax({
       	type:"POST",
              url:"./db/movie/getMovieTable.jsp",
              dataType:"JSON",
              success:function(res){
                 var data="";
                 for(i=0;i<res.length;i++){
               	  
                     var p = res;
                     data+="<tr><td>"
                     +p[i].movieID+"</td><td>"
                     +p[i].movieName+"</td><td>"
                     +p[i].director+"</td><td>"
                     +p[i].actor+"</td><td>"
                     +p[i].grade+"</td><td>"
                     +p[i].inform+"</td><td>"
                     +p[i].runningTime+"</td><td>"
                     +"<button onclick='updateMovie("+i+")'>수정</button></form></td><td>"
                     +"<button onclick='deleteMovie("+i+")'>삭제</button></td><td>"
                     +"<form id='form_movie_"+i+"'method='post'>"
                     +"<input id='movieID"+i+"' type='hidden' name='movieID' value="+p[i].movieID+" />"                     
                     +"<input id='movieName"+i+"' type='hidden' name='movieName' value="+p[i].movieName+" />"
                     +"<input id='director"+i+"' type='hidden' name='director' value="+p[i].director+" />"
                     +"<input id='actor"+i+"' type='hidden' name='actor' value="+p[i].actor+" />"
                     +"<input id='grade"+i+"' type='hidden' name='grade' value="+p[i].grade+" />"
                     +"<input id='inform"+i+"' type='hidden' name='inform' value="+p[i].inform+" />"
                     +"<input id='runningTime"+i+"' type='hidden' name='runningTime' value="+p[i].runningTime+" />"
                     +"</form></td></tr>";
                 
                 }
                 $('#content_movie').html(data);
              },
              error:function() {
                  alert("영화 목록 없음.");
              }
          })
          
            
          $.ajax({
       	type:"POST",
              url:"./db/theater/getTheaterTable.jsp",
              dataType:"JSON",
              success:function(res){
                 var data="";
                 for(i=0;i<res.length;i++){
               	  
                     var p = res;
                     data+="<tr><td>"
                     +p[i].theaterID+"</td><td>"
                     +p[i].theaterName+"</td><td>"
                     +p[i].address+"</td><td>"
                     +p[i].telephone+"</td><td>"
                     +"<button onclick='updateTheater("+i+")'>수정</button></form></td><td>"
                     +"<button onclick='deleteTheater("+i+")'>삭제</button></td><td>"
                     +"<button onclick='goToScreen("+i+")'>상영관 정보</button></td><td>"
                     +"<form id='form_theater_"+i+"'method='post'>"
                     +"<input id='theaterID"+i+"' type='hidden' name='theaterID' value="+p[i].theaterID+" />"                     
                     +"<input id='theaterName"+i+"' type='hidden' name='theaterName' value="+p[i].theaterName+" />"
                     +"<input id='address"+i+"' type='hidden' name='address' value="+p[i].address+" />"
                     +"<input id='telephone"+i+"' type='hidden' name='telephone' value="+p[i].telephone+" />"
                     +"</form></td></tr>";
                 
                 }
                 $('#content_theater').html(data);
              },
              error:function() {
                  alert("영화관 목록 없음.");
              }
          })
    
});
</script>

<script type="text/javascript"> 

function deleteMovie(i) {
	 $('#form_movie_'+i).attr('action'
			 , './DB/Movie/DeleteMovie.jsp');
	$('#form_movie_'+i).submit();
}

</script>


</body>
</html>