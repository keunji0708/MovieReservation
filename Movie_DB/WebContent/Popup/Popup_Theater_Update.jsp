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
	
	String id = request.getParameter("theaterID");
    
	System.out.println(id);
	
	
	String login_theaterID = "";
	String login_theaterName = "";
	String login_address = "";
	String login_telephone = "";
	
    try{
    	Class.forName("com.mysql.jdbc.Driver");
		System.out.println("--- Driver Loading Complete ---");
		
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		System.out.println("--- DB Connect Complete ---");
		
		sql = "select * from theater_table " +
				"where theaterID= ?";
        
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery(); 

		while(rs.next()) {
				
				String theaterID = rs.getString("theaterID");
				String theaterName = rs.getString("theaterName");
				String address = rs.getString("address");
				String telephone = rs.getString("telephone");
				
				login_theaterID = theaterID;
				login_theaterName = theaterName;
				login_address = address;
				login_telephone = telephone;

		}
		
		
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<form method="POST" action='/Movie_DB/DB/Theater/UpdateTheater.jsp'>
<input type="hidden" name="theaterID" value="<%= login_theaterID %>" />
theaterID : <%= login_theaterID %> <br>
theaterName : <input type="text" name="theaterName" value="<%= login_theaterName %>" /><br>
address :  <input type="text" name="address" value="<%= login_address %>" /><br>
telephone :  <input type="text" name="telephone" value="<%= login_telephone %>" /><br>
<input type="submit" />
</form><br>
