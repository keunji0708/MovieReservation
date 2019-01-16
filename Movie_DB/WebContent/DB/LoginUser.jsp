<%@page import="java.io.FileReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.BufferedReader, java.io.BufferedWriter, java.io.File, java.io.FileWriter "  %>
<% request.setCharacterEncoding("UTF-8"); %>
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
	
	String sql = "";
	
	String id = request.getParameter("userID2");
	String pwd = request.getParameter("userPwd2");
    
	String login_id = "";
	String login_name = "";
	String login_password = "";
	String login_birthdate = "";
	String login_address = "";
	String login_phone = "";
	int login_point = 0;
	
    try{
    	Class.forName("com.mysql.jdbc.Driver");
		System.out.println("--- Driver Loading Complete ---");
		
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		System.out.println("--- DB Connect Complete ---");
		
		sql = "select * from user_table " +
				"where userID= ? and password = ?";
        
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pwd);
		rs = pstmt.executeQuery(); 

		while(rs.next()) {
				
				String userID = rs.getString("userID");
				String name = rs.getString("name");
				String password = rs.getString("password");
				String birthdate = rs.getString("birthdate");
				String address = rs.getString("address");
				String phone = rs.getString("phone");
				int point = rs.getInt("point");
				
				login_id = userID;
				login_name = name;
				login_password = password;
				login_birthdate = birthdate;
				login_address = address;
				login_phone = phone;
				login_point = point;

		}
		
		
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<script type="text/javascript">
  function mySubmit(index) {
    if (index == 1) {	// 정보수정
      document.infoForm.action='/Movie_DB/DB/UpdateUser.jsp';
    }
    if (index == 2) {	// 회원탈퇴
      document.infoForm.action='/Movie_DB/DB/DeleteUser.jsp';
    } 
    
    document.infoForm.submit();
  }
</script>

<form name="infoForm" method="POST">
<input type="hidden" name="originID" value="<%= login_id %>" />
<input type="hidden" name="originPwd" value="<%= login_password %>" />
당신의 id : <input type="text" name="userID" value="<%= login_id %>" /><br>
당신의 name : <input type="text" name="userName" value="<%= login_name %>" /><br>
당신의 password :  <input type="text" name="userPwd" value="<%= login_password %>" /><br>
당신의 birthdate :  <input type="text" name="userDate" value="<%= login_birthdate %>" /><br>
당신의 address :  <input type="text" name="userAddress" value="<%= login_address %>" /><br>
당신의 phone :  <input type="text" name="userPhone" value="<%= login_phone %>" /><br>
당신의 point : <%= login_point %><br>
</form><br>

<button type="button" onclick="mySubmit(1)">정보수정</button> <br>
<button type="button" onclick="mySubmit(2)">회원탈퇴</button> <br>
