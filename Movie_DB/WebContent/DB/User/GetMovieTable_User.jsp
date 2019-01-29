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
		
		sql = "select * from movie_table as t1, (select movieID as 'mID', count(*) as 'reserve' from reservation_table group by movieID) as t2, "
				+"(select movieID as 'mID', date from timetable_table) as t3 "
				+"where t1.movieID = t2.mID "
				+"and t3.mID = t1.movieID "
				+"and t3.date > now() "
				+"group by t1.movieID "
				+"order by reserve desc;";	
				
				
		System.out.println("--- select * from movie_table as t1, (select movieID as 'mID', count(*) as 'reserve' from reservation_table group by movieID) as t2 where t1.movieID = t2.mID order by reserve desc; ---");
		
		pstmt = conn.prepareStatement(sql);

		rs = pstmt.executeQuery();
		
		if(rs.next() == false){
			System.out.println("--- 0 : !rs.next() ---");
         
			sql = "select * from movie_table as t1, (select movieID as 'mID', date from timetable_table group by movieID) as t2 where t1.movieID = t2.mID and t2.date > now();";
					
			System.out.println("--- select * from movie_table as t1, (select movieID as mID from timetable_table group by movieID) as t2 where t1.movieID = t2.mID; ---");
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				JSONArray arr = new JSONArray();
	            do{
	                JSONObject obj = new JSONObject();
	                obj.put("movieID",rs.getString("movieID"));
	                obj.put("movieName",rs.getString("movieName"));
	                obj.put("director",rs.getString("director"));
	                obj.put("actor",rs.getString("actor"));
	                obj.put("grade",rs.getString("grade"));
	                obj.put("inform",rs.getString("inform"));
	                obj.put("runningTime",rs.getString("runningTime"));
	                obj.put("reserve", 0);
	                arr.add(obj);
	                
	            }while(rs.next());
	            out.print(arr);
			}else {
				System.out.print("movie_user Error");
			}
	
        }else{
        	/*
        		정상. 영화에 대한 예약이 있을 때.
        		1. 오늘날짜+로 예약된 영화 예약수로 desc.
        		2. 스크린에서 상영중인 모든 영화를 1을 제외하고 select.
        	*/
        	
        	/* 1. 예약된 영화 예약수로 desc. */
			//rs.next()는 위에서 이미 했다.
			JSONArray arr = new JSONArray();
            do{
                JSONObject obj = new JSONObject();
                obj.put("movieID",rs.getString("movieID"));
                obj.put("movieName",rs.getString("movieName"));
                obj.put("director",rs.getString("director"));
                obj.put("actor",rs.getString("actor"));
                obj.put("grade",rs.getString("grade"));
                obj.put("inform",rs.getString("inform"));
                obj.put("runningTime",rs.getString("runningTime"));
                obj.put("reserve",rs.getInt("reserve"));
                arr.add(obj);
                
            }while(rs.next());
           	
			/* 2. 스크린에서 상영중인 모든 영화를 1을 제외하고 select. + 오늘보다 날짜가 커야함.*/
			sql = "select * from "
				+"(select * from movie_table as t1, "
				+"(select date, movieID as mID from timetable_table where date > now() group by movieID) as t2 "
				+"where t1.movieID = t2.mID) as tmain, "
				+"(select movieID from movie_table as t1, "
				+"(select movieID as 'mID', count(*) as 'reserve' from reservation_table group by movieID) as t2 "
				+"where t1.movieID = t2.mID "
				+"order by reserve desc) as tsub "
				+"where tmain.movieID != tsub.movieID;";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
	            do{
	            	JSONObject obj = new JSONObject();
	                obj.put("movieID",rs.getString("movieID"));
	                obj.put("movieName",rs.getString("movieName"));
	                obj.put("director",rs.getString("director"));
	                obj.put("actor",rs.getString("actor"));
	                obj.put("grade",rs.getString("grade"));
	                obj.put("inform",rs.getString("inform"));
	                obj.put("runningTime",rs.getString("runningTime"));
	                obj.put("reserve", 0);
	                arr.add(obj);
	                
	            }while(rs.next());
	           
			}else {
				System.out.print("movie_user Error 3");
			}
			
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
        System.out.println("--- User Get Movie Table ---");
    }

%>
