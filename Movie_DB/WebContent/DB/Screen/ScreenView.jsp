<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");
	String theaterID = request.getParameter("theaterID");
	String theaterName = request.getParameter("theaterName");
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
<h id="theater" ><%= theaterName %></h><h> 영화관의 상영관 정보</h>
<button onclick='insertScreen()'>상영관 추가</button>
<br>

<form id='form_theater_info' method='post'> 
<input id='theaterID' type='hidden' name='theaterID' value=<%= theaterID %> />    
</form>
<table border="1px" width="500px;">
			<thead>
				<tr>
					<th>screenID</th>
					<th>screen</th>
					<th>seat</th>
					<th>cost</th>
					<th>theaterID</th>
				</tr>
			</thead>
			<tbody id="content_screen"></tbody>
</table>


<script>
$(document).ready(function() {
	$.ajax({
       	type:"POST",
              url:"/Movie_DB/DB/Screen/GetScreenTable.jsp",
              dataType:"JSON",
              data:{ theaterID : <%= theaterID %>},
              success:function(res){
                 var data="";
                 for(i=0;i<res.length;i++){
               	  
                     //var p = jQuery.parseJSON(JSON.stringify(res));
                     var p = res;
                     data+="<tr><td>"
                     +p[i].screenID+"</td><td>"
                     +p[i].screen+"</td><td>"
                     +p[i].seat+"</td><td>"
                     +p[i].cost+"</td><td>"
                     +p[i].theaterID+"</td><td>"
                     +"<button onclick='updateScreen("+i+")'>수정</button></form></td><td>"
                     +"<button onclick='deleteScreen("+i+")'>삭제</button></td><td>"
                     +"<button onclick='goToTimetable("+i+")'>상영 시간표</button></td><td>"
                     +"<form id='form_screen_"+i+"'method='post'>"
                     +"<input id='screenID"+i+"' type='hidden' name='screenID' value="+p[i].screenID+" />"                     
                     +"<input id='screen"+i+"' type='hidden' name='screen' value="+p[i].screen+" />"
                     +"<input id='seat"+i+"' type='hidden' name='seat' value="+p[i].seat+" />"
                     +"<input id='cost"+i+"' type='hidden' name='cost' value="+p[i].cost+" />"
                     +"<input id='theaterID"+i+"' type='hidden' name='theaterID' value="+p[i].theaterID+" />"
                     +"</form></td></tr>";
                 }
                 $('#content_screen').html(data);
              },
              error:function() {
                  alert("상영관 목록 없음.");
              }
          })
});



function insertScreen()
{
	 var tw = window.open( "", "insert", "width=400,height=400" );

	 $('#form_theater_info').attr('action', '/Movie_DB/Popup/Popup_Screen_Insert.jsp');
	 $('#form_theater_info').attr('target', 'insert');
	 $('#form_theater_info').submit();
}

function updateScreen(i)
{
	 var tw = window.open( "", "update", "width=400,height=400" );

	 $('#form_screen_'+i).attr('action', '/Movie_DB/Popup/Popup_Screen_Update.jsp');
	 $('#form_screen_'+i).attr('target', 'update');
	 $('#form_screen_'+i).submit();
}

function deleteScreen(i)
{
	 $('#form_screen_'+i).attr('action'
			 , '/Movie_DB/DB/Screen/DeleteScreen.jsp');
	$('#form_screen_'+i).submit();
}

function goToTimetable(i)
{
	 $('#form_screen_'+i).attr('action'
			 , '/Movie_DB/DB/Timetable/TimetableView.jsp');
	$('#form_screen_'+i).submit();
}
</script>


</body>
</html>