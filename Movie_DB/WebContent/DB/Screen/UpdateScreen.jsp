<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	int screenID = Integer.parseInt(request.getParameter("screenID"));
	String screen = request.getParameter("screen");
	String seatStr = request.getParameter("seat");
	int seat = Integer.parseInt(seatStr);
	String costStr = request.getParameter("cost");
	int cost =  Integer.parseInt(costStr);
	   
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		 String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
	     String dbId = "root";
	     String dbPass = "awef1322";
	      
	     Class.forName("com.mysql.jdbc.Driver");
	      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	      String sql = "select screenID from screen_table where screenID = ? ";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setInt(1,screenID);
	      rs = pstmt.executeQuery();
    	  
	      if(rs.next()){
	    	  int rID = rs.getInt("screenID");
	    	 
	    	  if(screenID == rID){
	    		  sql = "update screen_table set screen=?, seat= ?, cost= ? where screenID=?";
	    		  pstmt = conn.prepareStatement(sql);
	    		  
	    	      pstmt.setString(1,screen);
	    	      pstmt.setInt(2, seat);
	    	      pstmt.setInt(3, cost);
	    	      pstmt.setInt(4, screenID);
	    	     
	    	      pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>영화 예약 시스템</title>
</head>
<script>
	alert("상영관 수정 완료");
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
