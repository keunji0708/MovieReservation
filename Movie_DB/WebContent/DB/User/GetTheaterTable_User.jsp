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

int movieID = Integer.parseInt(request.getParameter("movieID"));
String date = request.getParameter("date");


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
		
		sql = "select theaterID, theaterName, address, telephone, screenID from theater_table as t1, "
				+"(select theaterID as 'theaterID2', screenID from screen_table as t1, (select screenID as 'screenID2' from timetable_table where movieID = ? and date like ?) as t2 "
				+"where t1.screenID = t2.screenID2) as t2 "
				+"where t1.theaterID = t2.theaterID2 "
				+"group by theaterID;";
		System.out.println("--- "+ sql +" ---");
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,movieID);
		pstmt.setString(2,date+"%");
		rs = pstmt.executeQuery(); 

		 
		if(!rs.next()){
            out.print("--- 0 : !rs.next() ---");
        }else{
        	JSONArray arr=new JSONArray();
            
            do{
                JSONObject obj = new JSONObject();
                obj.put("theaterID",rs.getString("theaterID"));
                obj.put("theaterName",rs.getString("theaterName"));
                obj.put("address",rs.getString("address"));
                obj.put("telephone",rs.getString("telephone"));
                obj.put("screenID",rs.getString("screenID"));
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
        System.out.println("--- Get Movie Table ---");
    }

%>
