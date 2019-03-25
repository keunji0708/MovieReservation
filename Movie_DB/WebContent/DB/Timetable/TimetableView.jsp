<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");
	String theaterID = request.getParameter("theaterID");
	String theaterName = request.getParameter("theaterName");
	String screenID = request.getParameter("screenID");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>영화 예약 시스템</title>

<!--  <script src="js/jquery-3.3.1.js"></script>-->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

</head>
<body>

<br/>
<h id="theater" > screenId : <%= screenID %> 상영관의 Timetable</h>
<button onclick='insertTimetable()'>Timetable 추가</button>
<br>

<form id='form_screen_info' method='post'> 
<input id='screenID' type='hidden' name='screenID' value=<%= screenID %> />    
</form>

<table border="1px" width="500px;">
			<thead>
				<tr>
					<th>timetableID</th>
					<th>date</th>
					<th>endDate</th>
					<th>screenID</th>
					<th>movieID</th>
				</tr>
			</thead>
			<tbody id="content_timetable"></tbody>
</table>



<script>
$(document).ready(function() {
	$.ajax({
       	type:"POST",
              url:"/Movie_DB/DB/Timetable/GetTimetable.jsp",
              dataType:"JSON",
              data:{ screenID : <%= screenID %>},
              success:function(res){
                 var data="";
                 for(i=0;i<res.length;i++){
               	  
                     //var p = jQuery.parseJSON(JSON.stringify(res));
                     var p = res;
                     data+="<tr><td>"
                     +p[i].timetableID+"</td><td>"
                     +p[i].date+"</td><td>"
                     +p[i].endDate+"</td><td>"
                     +p[i].screenID+"</td><td>"
                     +p[i].movieID+"</td><td>"
                     +"<button onclick='updateTimetable("+i+")'>수정</button></td><td>"
                     +"<button onclick='deleteTimetable("+i+")'>삭제</button></td><td>"
                     +"<button onclick='goToSeatTable("+i+")'>좌석정보</button></td><td>"
                     +"<form id='form_timetable_"+i+"'method='post'>"
                     +"<input id='timetableID"+i+"' type='hidden' name='timetableID' value="+p[i].timetableID+" />"                     
                     +"<input id='date"+i+"' type='hidden' name='date' value="+p[i].date+" />"
                     +"<input id='endDate"+i+"' type='hidden' name='endDate' value="+p[i].endDate+" />"
                     +"<input id='screenID"+i+"' type='hidden' name='screenID' value="+p[i].screenID+" />"
                     +"<input id='movieID"+i+"' type='hidden' name='movieID' value="+p[i].movieID+" />"
                     +"</form></td></tr>";
                 }
                 $('#content_timetable').html(data);
              },
              error:function() {
                  alert("상영 시간표 목록 없음.");
              }
          })
});


</script>


</body>
</html>