<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
    
<%

String str = "";
if(request.getParameterValues("checked") == null ) {
	System.out.println("Didn't check.");
	str = "체크하세요!";
	
}else {
   String[] userID_list = request.getParameterValues("userID"); 
   String[] seatID_list = request.getParameterValues("seatID"); 
   String[] movieID_list = request.getParameterValues("movieID"); 
   String[] checked = request.getParameterValues("checked"); 
   
   for(int i=0; i<checked.length; i++) {
	   System.out.print("checked["+i+"] : " + checked[i]); 
	   System.out.print("  userID["+checked[i]+"] : " + userID_list[Integer.parseInt(checked[i])]); 
	   System.out.print("  seatID["+checked[i]+"] : " + seatID_list[Integer.parseInt(checked[i])]); 
	   System.out.println("  movieID["+checked[i]+"] : " + movieID_list[Integer.parseInt(checked[i])]); 
	   
	   
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   

	   try{
	      String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
	      String dbId = "root";
	      String dbPass = "awef1322";
	      
	      Class.forName("com.mysql.jdbc.Driver");
	      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
	          	      
	      String sql = "insert into reservation_table values(0, ?, ?, ?, 0, 0);";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1, userID_list[Integer.parseInt(checked[i])]);
	      pstmt.setInt(2, Integer.parseInt(seatID_list[Integer.parseInt(checked[i])]));
	      pstmt.setInt(3, Integer.parseInt(movieID_list[Integer.parseInt(checked[i])]));
	      
	      pstmt.executeUpdate();
	      
	      /* seat update. */
	      sql = "update seat_table set reserved = 1 where seatID = ?";
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setInt(1, Integer.parseInt(seatID_list[Integer.parseInt(checked[i])]));
	      
	      pstmt.executeUpdate();
	      
	      int j = i+1;
	      str = "예약했습니다. : " + j;
	   }catch(Exception e) {
	      e.printStackTrace();
	      str = "예약 실패했습니다.";
	   }finally {
	      if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
	      if(conn != null) try{conn.close();}catch(SQLException sqle){}
	   }
   }
}
   
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>영화 예약 시스템</title>
</head>

<script>
	alert("<%=str%>");
	window.close();
</script>
</html>