<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String movieID = request.getParameter("movieID");
	String movieName = request.getParameter("movieName");
	String director = request.getParameter("director");
	String actor = request.getParameter("actor");
	String grade = request.getParameter("grade");
	String inform = request.getParameter("inform");
	String runningtime = request.getParameter("runningtime");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
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

			if (movieID.equals(rId)) {
				sql = "update movie_table set movieName= ?,director= ?,actor= ?,grade= ?,inform= ?,runningtime= ? where movieID = ? ";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, movieName);
				pstmt.setString(2, director);
				pstmt.setString(3, actor);
				pstmt.setString(4, grade);
				pstmt.setString(5, inform);
				pstmt.setString(6, runningtime);
				pstmt.setString(7, movieID);
				pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Update Movie</title>
</head>
<script>
	alert("영화 수정 완료!");
	window.close();
</script>
</html>
<%
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


