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
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

String userID = request.getParameter("userID");

	String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
	String dbId = "root";
	String dbPw = "awef1322";
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "";
	
    try{
    	Class.forName("com.mysql.jdbc.Driver");
		System.out.println("--- Driver Loading Complete ---");
		
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		System.out.println("--- DB Connect Complete ---");
		
		sql = "select movieName, theaterName, screen, seatNumber, date, endDate, ticket, payment, reservationID, seatID, cost, userID "
				+"from (select userID, seatID, movieID, ticket, payment, reservationID from reservation_table) as t1, "
				+"(select movieName, movieID as 'mid' from movie_table) as t2, "
				+"(select timetableID, seatNumber, seatID as 'sid' from seat_table) as t3, "
				+"(select timetableID, date, endDate, screenID from timetable_table) as t4, "
				+"(select screen, screenID, theaterID, cost from screen_table) as t5, "
				+"(select theaterID, theaterName from theater_table) as t6 "
				+"where t1.userID = ? and t1.ticket = 0 "
				+"and t1.movieID = t2.mid "
				+"and t1.seatID = t3.sid "
				+"and t3.timetableID = t4.timetableID "
				+"and t4.screenID = t5.screenID "
				+"and t5.theaterID = t6.theaterID;";
		
		
		System.out.println("--- sql ---");
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userID);
		
		rs = pstmt.executeQuery(); 

		 
		if(!rs.next()){
            out.print("--- 0 : !rs.next() ---");
        }else{
        	JSONArray arr=new JSONArray();
            
            do{
                JSONObject obj = new JSONObject();
                obj.put("movieName",rs.getString("movieName"));
                obj.put("theaterName",rs.getString("theaterName"));
                obj.put("screen",rs.getString("screen"));
                obj.put("seatNumber",rs.getString("seatNumber"));
                obj.put("date",rs.getString("date"));
                obj.put("endDate",rs.getString("endDate"));
                obj.put("ticket",rs.getString("ticket"));
                obj.put("payment",rs.getString("payment"));
                obj.put("reservationID",rs.getString("reservationID"));
                obj.put("seatID",rs.getString("seatID"));
                obj.put("cost",rs.getString("cost"));
                obj.put("userID",rs.getString("userID"));
                arr.add(obj);
            }while(rs.next());
            out.print(arr);
        }
		
		
		
        
    }catch(SQLException e){
        out.print("Exception: "+e);
    }
    finally{
        if(pstmt != null){
            try{
                pstmt.close();
            }catch(SQLException e){}
        }
        if(conn != null){
            try{
                conn.close();
            }catch(SQLException e){}
        }
        System.out.println("--- Get reservation Table ---");
    }

%>
