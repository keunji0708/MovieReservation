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
	<title>��ȭ ���� �ý���</title>
</head>
<script>
	alert("�󿵰� ���� �Ϸ�");
	window.close();
</script>
</html>

<%
    	  }
	    }
	      else{
	    	out.println("��ȭ�� �̸� �Ǵ� ��ȭ ID�� Ʋ�Ƚ��ϴ�");
	      }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
	    if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>    		  
