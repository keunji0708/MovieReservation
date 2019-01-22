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


	String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp"; // MySQL 계정
	String dbId = "root"; // MySQL 계정
	String dbPw = "awef1322"; // 비밀번호
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "";
	int id = Integer.parseInt(request.getParameter("theaterID"));
	
    try{
    	Class.forName("com.mysql.jdbc.Driver");
		System.out.println("--- Driver Loading Complete ---");
		
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		System.out.println("--- DB Connect Complete ---");
		
		sql = "select * from screen_table where theaterID = ?";
		System.out.println("--- select * from screen_table where theaterID = ?---");
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,id);
		rs = pstmt.executeQuery(); 
		 
		if(!rs.next()){
            out.print("--- 0 : !rs.next() ---");
        }else{
        	JSONArray arr=new JSONArray();
            
            do{
                JSONObject obj = new JSONObject();
                obj.put("screenID",rs.getString("screenID"));
                obj.put("screen",rs.getString("screen"));
                obj.put("seat",rs.getString("seat"));
                obj.put("cost",rs.getString("cost"));
                obj.put("theaterID",rs.getString("theaterID"));
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
        System.out.println("--- Get Screen Table ---");
    }

%>
