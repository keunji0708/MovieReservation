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
	String dbPw = "awef1322";
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String originID = request.getParameter("originID");
	String originPwd = request.getParameter("originPwd");
	
	String userID = request.getParameter("userID");
	String userName = request.getParameter("userName");
	String userPwd = request.getParameter("userPwd");
	String userAddress = request.getParameter("userAddress");
	String userPhone = request.getParameter("userPhone");
	
	String sql = "";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		System.out.println("--- Driver Loading Complete ---");
		
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		System.out.println("--- DB Connect Complete ---");
		
		sql = "update user_table set " +
				"userID = ?, " +
				"name = ?, " +
				"password = ?, " +
				"birthdate = ?, " +
				"address = ?, " +
				"phone = ? " +
				"where userID = ? and password = ?";
				
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userID);
		pstmt.setString(2, userName);
		pstmt.setString(3, userPwd);
		pstmt.setString(4, "19900909");
		pstmt.setString(5, userAddress);
		pstmt.setString(6, userPhone);
		pstmt.setString(7, originID);
		pstmt.setString(8, originPwd);
		pstmt.executeUpdate();
		System.out.println("--- user update Complete ---");
%>


<form name="infoForm" method="POST">
<input type="hidden" name=userID2 value="<%= userID %>" />
<input type="hidden" name="userPwd2" value="<%= userPwd %>" />
</form><br>
<script type="text/javascript">
alert("수정 완료!");
</script>

<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>