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
	
	int id = Integer.parseInt(request.getParameter("screenID"));
    
	System.out.println(id);
	
	
	String login_screenID = "";
	String login_screen = "";
	String login_seat = "";
	String login_cost = "";
	String login_theaterID = "";
	
    try{
    	Class.forName("com.mysql.jdbc.Driver");
		System.out.println("--- Driver Loading Complete ---");
		
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		System.out.println("--- DB Connect Complete ---");
		
		sql = "select * from screen_table " +
				"where screenID= ?";
        
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		rs = pstmt.executeQuery(); 

		while(rs.next()) {
				
				String screenID = rs.getString("screenID");
				String screen = rs.getString("screen");
				String seat = rs.getString("seat");
				String cost = rs.getString("cost");
				String theaterID = rs.getString("theaterID");
				
				login_screenID = screenID;
				login_screen = screen;
				login_seat = seat;
				login_cost = cost;
				login_theaterID = theaterID;

		}
		
		
    }catch(Exception e){
        e.printStackTrace();
    }
%>


<title>영화 예약 시스템</title>
</head>
<body>
		<h2>상영관 수정</h2>
	
	<form method= "post" action="/Movie_DB/DB/Screen/UpdateScreen.jsp">
	<input type="hidden" name="screenID" value="<%= login_screenID %>" />
	<input type="hidden" name="theaterID" value="<%= login_theaterID %>" />
		영화관ID : <%= login_theaterID %><br/>
		상영관ID : <%= login_screenID %><br/>
		screenName : <input type="text" name="screen" maxlength="20" value="<%= login_screen %>" /><br/>  
		seat : <%= login_seat %><input type="hidden" name="seat" maxlength="10" value="<%= login_seat %>" /><br/> 
		cost : <input type="text" name="cost" maxlength="10" value="<%= login_cost %>" /><br/>
		<input type="submit" value="수정 완료">	
		<input type="reset" value="다시입력">	
	</form>	
</body>