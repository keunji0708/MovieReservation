<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String timetableID = request.getParameter("timetableID");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		 String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
	      String dbId = "root";
	      String dbPass = "awef1322";
	      
	      Class.forName("com.mysql.jdbc.Driver");
	      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	      String sql = "select timetableID from timetable_table where timetableID = ?";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1,timetableID);
	      rs = pstmt.executeQuery();
	      
	      if(rs.next()){
	    	  String rId = rs.getString("timetableID");
	    	  
	    	  if(timetableID.equals(rId)){
	    		  sql = "delete from timetable_table where timetableID = ? ";
	    		  pstmt = conn.prepareStatement(sql);
	    		  pstmt.setString(1, timetableID);
	    		  pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>영화 예약 시스템</title>
</head>

<script>
	alert("삭제 완료!");
	location.href="/Movie_DB/Admin.jsp";
</script>

<%
	    	  }else{
	    		  out.println("err1");
	    	  }
	      }else{
	    	  out.println("err2");
	      }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
	     if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>    		  

</html>