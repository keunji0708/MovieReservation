<%@page import="java.sql.Date"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>

<%@ page import = "java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
	String dbId = "root";
	String dbPw = "awef13222";
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "";
	
	String id = request.getParameter("originID");
	String pwd = request.getParameter("originPwd");
	
	System.out.println(id +" , "+pwd);

	try {
		Class.forName("com.mysql.jdbc.Driver");
		System.out.println("--- Driver Loading Complete ---");
		
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		System.out.println("--- DB Connect Complete ---");
		
		sql = "delete from user_table " +
			"where userID = ? and password = ?;";
				
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pwd);
		pstmt.executeUpdate();
		System.out.println("--- user delete Complete ---");

	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
	<script>
	alert("삭제 완료!");
	</script>
	