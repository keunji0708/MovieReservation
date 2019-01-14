<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String theaterID = request.getParameter("theaterID");
	String screenID = request.getParameter("screenID");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		 String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
	      String dbId = "root";
	      String dbPass = "awef1322";
	      
	      Class.forName("com.mysql.jdbc.Driver");
	      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	      String sql = "select screenID from screen_table where theaterID = ? and screenID = ?";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1,theaterID);
	      pstmt.setString(2,screenID);
	      rs = pstmt.executeQuery();
	      
	      if(rs.next()){
	    	  String rId = rs.getString("screenID");
	    	  
	    	  if(screenID.equals(rId)){
	    		  sql = "delete from screen_table where screenID = ? ";
	    		  pstmt = conn.prepareStatement(sql);
	    		  pstmt.setString(1, screenID);
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
