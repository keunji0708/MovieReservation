<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");
	String timetableID = request.getParameter("timetableID");
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
<h id="theater" >Timetable 좌석표</h> <button onclick="location.href='/Movie_DB/index.jsp'">Return</button>

<br>
<form id='form_screen_info' method='post'> 
</form>

<table border="1px" width="500px;">
			<thead>
				<tr>
					<th>timetableID</th>
					<th>seatNumber</th>
					<th>reserved</th>
				</tr>
			</thead>
			<tbody id="content_seat"></tbody>
</table>



<script>
$(document).ready(function() {
	$.ajax({
       	type:"POST",
              url:"/Movie_DB/DB/Seat/GetSeatTable.jsp",
              dataType:"JSON",
              data:{ timetableID : <%= timetableID %>},
              success:function(res){
                 var data="";
                 for(i=0;i<res.length;i++){
                	 var dummy = "□";
                	 var p = res;
                	 
               	  if(p[i].reserved == "1"){
               		dummy = "■";
               	  }
                     data+="<tr><td>"
                     +p[i].timetableID+"</td><td>"
                     +p[i].seatNumber+"</td><td>"
                     +dummy+"</td>";
                 }
                 $('#content_seat').html(data);
              },
              error:function() {
                  alert("error occured");
              }
          })
});

</script>
</body>
</html>