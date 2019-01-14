<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	int movieID = Integer.parseInt(request.getParameter("myselect"));
	int screenID = Integer.parseInt(request.getParameter("screenID"));
	String date = request.getParameter("date");
	String time = request.getParameter("time");
	int timetableID = Integer.parseInt(request.getParameter("timetableID"));
	   
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		 String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
	     String dbId = "root";
	     String dbPass = "awef1322";
	      
	     Class.forName("com.mysql.jdbc.Driver");
	      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	      String sql = "select timetableID from timetable_table where timetableID = ? ";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setInt(1,timetableID);
	      rs = pstmt.executeQuery();
    	  
	      if(rs.next()){
	    	  int rID = rs.getInt("timetableID");
	    	 
	    	  if(timetableID == rID){
	    		  sql = "update timetable_table set date=?, endDate= addtime(date, (select runningTime from movie_table where movieID = ?)), movieID = ? where timetableID = ?";
	    		  String dateTime = date+ " " + time + ":00:00";
	    		  
	    		  pstmt = conn.prepareStatement(sql);
	    		  
	    	      pstmt.setString(1, dateTime);
	    	      pstmt.setInt(2, movieID);
	    	      pstmt.setInt(3, movieID);
	    	      pstmt.setInt(4, timetableID);
	    	     
	    	      pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>영화 예약 시스템</title>
</head>
<script>
	alert("상영관 수정 완료!");
	window.close();
</script>
</html>

<%
    	  }
	    }
	      else{
	    	out.println("영화관 이름 또는 영화 ID가 틀렸습니다");
	      }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
	    if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>    		  
