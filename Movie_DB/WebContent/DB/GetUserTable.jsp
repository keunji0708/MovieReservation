<%@ page import="java.io.FileReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.BufferedReader, java.io.BufferedWriter, java.io.File, java.io.FileWriter " %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="org.json.simple.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DateFormat" %>
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
		
		sql = "select * from user_table";
		System.out.println("--- select * from user_table ---");
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(); 

		 
		if(!rs.next()){
            out.print("--- 0 : !rs.next() ---");
        }else{
        	JSONArray arr=new JSONArray();
            
            do{
                JSONObject obj = new JSONObject();
                obj.put("userID",rs.getString("userID"));
                obj.put("name",rs.getString("name"));
                obj.put("password",rs.getString("password"));
                obj.put("birthdate",rs.getString("birthdate"));
                obj.put("address",rs.getString("address"));
                obj.put("phone",rs.getString("phone"));
                obj.put("point",rs.getInt("point"));
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
        System.out.println("--- Get User Table ---");
    }

%>
