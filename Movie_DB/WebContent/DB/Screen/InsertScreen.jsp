<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
    
<%
   String screenID = request.getParameter("screenID");
   String screen = request.getParameter("screen");
   String seatStr = request.getParameter("seat");
   int seat = Integer.parseInt(seatStr);
   String costStr = request.getParameter("cost");
   int cost =  Integer.parseInt(costStr);
   String theaterID = request.getParameter("theaterID");

   Connection conn = null;
   PreparedStatement pstmt = null;
   String str = "";

   try{
      String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
      String dbId = "root";
      String dbPass = "awef1322";
      
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
          	      
      String sql = "insert into screen_table values(?,?,?,?,?)";
      pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, 0);
      pstmt.setString(2,screen); //�󿵰�
      pstmt.setInt(3,seat);
      pstmt.setInt(4,cost);
      pstmt.setString(5, theaterID);
      
      pstmt.executeUpdate();
           
      str = "screen ���̺� ���ο� �󿵰��� �߰��߽��ϴ�.";
   }catch(Exception e) {
      e.printStackTrace();
      str = "screen ���̺� ���ο� �󿵰� �߰��� �����߽��ϴ�.";
   }finally {
      if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
      if(conn != null) try{conn.close();}catch(SQLException sqle){}
   }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="EUC-KR">
	<title>��ȭ ���� �ý���</title>
</head>

<script>
	alert("�󿵰� ���� �Ϸ�!");
	window.close();
</script>
</html>