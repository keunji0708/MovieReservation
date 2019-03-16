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
	String jdbcUrl = "jdbc:mysql://localhost:3306/dpTermp";
	String dbId = "root";
	String dbPw = "awef1322"; 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String userID = request.getParameter("userID");
	String userName = request.getParameter("userName");
	String userPwd = request.getParameter("userPwd");
	String userDate = request.getParameter("userDate");
	String userAddress = request.getParameter("userAddress");
	String userPhone = request.getParameter("userPhone");
	
	String sql = "";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		System.out.println("--- Driver Loading Complete ---");
		
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		System.out.println("--- DB Connect Complete ---");
		
		sql = "insert into user_table " + 
				"values(?, ?, ?, ?, ?, ?, 0);";
				
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userID);
		pstmt.setString(2, userName);
		pstmt.setString(3, userPwd);
		pstmt.setString(4, userDate);
		pstmt.setString(5, userAddress);
		pstmt.setString(6, userPhone);
		pstmt.executeUpdate();
		System.out.println("--- user insert Complete ---");
%>
<script>
alert("가입 완료!");
history.go(-1);
</script>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>