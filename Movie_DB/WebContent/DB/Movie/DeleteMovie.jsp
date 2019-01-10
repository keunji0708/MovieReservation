<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String movieID = request.getParameter("movieID");
	String movieName = request.getParameter("movieName");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		 String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
	      String dbId = "root";
	      String dbPass = "awef1322";
	      
	      Class.forName("com.mysql.jdbc.Driver");
	      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	      String sql = "select movieID from movie_table where movieID=?";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1,movieID);
	      rs = pstmt.executeQuery();
	      
	      if(rs.next()){
	    	  String rId = rs.getString("movieID");
	    	  
	    	  if(movieID.equals(rId)){
	    		  sql = "delete from movie_table where movieID = ? ";
	    		  pstmt = conn.prepareStatement(sql);
	    		  pstmt.setString(1, movieID);
	    		  pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Delete Movie</title>
</head>

</html>
<script>
	alert("영화 삭제 완료!");
	location.href="/Movie_DB/admin.jsp";
</script>
<%
	    	  }else{
	    		  out.println("영화 이름이 틀렸습니다.");
	    	  }
	      }else{
	    	  out.println("영화 아이디가 틀렸습니다");
	      }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs != null) 
			try {
				rs.close();
			} catch(SQLException sqle) {
				
			}
		if(pstmt != null) 
			try {
				pstmt.close();
			} catch(SQLException sqle) {
			}
	     if(conn != null) 
	    	 try { 
	    		 conn.close();
	    	 }catch(SQLException sqle){	    		 
	    	 }
	}
%>    		  



