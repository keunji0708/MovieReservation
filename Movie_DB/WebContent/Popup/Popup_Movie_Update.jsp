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
	String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp"; // MySQL 계정
	String dbId = "root"; // MySQL 계정
	String dbPw = "awef1322"; // 비밀번호
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "";
	
	String id = request.getParameter("movieID");
    
	System.out.println(id);
	
	
	String login_movieID = "";
	String login_movieName = "";
	String login_director = "";
	String login_actor = "";
	String login_grade = "";
	String login_inform = "";
	String login_runningTime = "";
	
    try{
    	Class.forName("com.mysql.jdbc.Driver");
		System.out.println("--- Driver Loading Complete ---");
		
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		System.out.println("--- DB Connect Complete ---");
		
		sql = "select * from movie_table " +
				"where movieID= ?";
        
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery(); 

		while(rs.next()) {
				
				String movieID = rs.getString("movieID");
				String movieName = rs.getString("movieName");
				String director = rs.getString("director");
				String actor = rs.getString("actor");
				String grade = rs.getString("grade");
				String inform = rs.getString("inform");
				String runningTime = rs.getString("runningTime");
				
				login_movieID = movieID;
				login_movieName = movieName;
				login_director = director;
				login_actor = actor;
				login_grade = grade;
				login_inform = inform;
				login_runningTime = runningTime;

		}
		
		
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<Form method="POST" action='/DatabaseTermp/db/movie/updateMovie.jsp'>
<input type="hidden" name="movieID" value="<%= login_movieID %>" />
movieID : <%= login_movieID %> <br>
movieName : <input type="text" name="movieName" value="<%= login_movieName %>" /><br>
director :  <input type="text" name="director" value="<%= login_director %>" /><br>
actor :  <input type="text" name="actor" value="<%= login_actor %>" /><br>
grade :  <input type="text" name="grade" value="<%= login_grade %>" /><br>
inform :  <input type="text" name="inform" value="<%= login_inform %>" /><br>
runningTime : <input type="text" name="runningTime" value="<%= login_runningTime %>" /><br>
<input type="submit" />
</form><br>