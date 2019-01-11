<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.io.*, java.util.*,
				java.text.SimpleDateFormat, java.text.ParseException"%>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String movieID = request.getParameter("movieID");
	String movieName = request.getParameter("movieName");
	String director = request.getParameter("director");
	String actor = request.getParameter("actor");
	String grade = request.getParameter("grade");
	String inform = request.getParameter("inform");
	String runningtime = request.getParameter("runningtime");

	SimpleDateFormat formater = new SimpleDateFormat("hh:mm:ss");
	java.util.Date util_runningtime = formater.parse(runningtime);
	java.sql.Time sql_runningtime = new java.sql.Time(util_runningtime.getTime());

	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
		String dbId = "root";
		String dbPass = "awef1322";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "insert into movie_table values(?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, 0);
		//pstmt.setString(1,movieID);
		pstmt.setString(2, movieName);
		pstmt.setString(3, director);
		pstmt.setString(4, actor);
		pstmt.setString(5, grade);
		pstmt.setString(6, inform);
		pstmt.setTime(7, sql_runningtime);
		pstmt.executeUpdate();

		str = "movie 테이블에 새로운 영화 레코드를 추가했습니다.";
	} catch (Exception e) {
		e.printStackTrace();
		str = "movie 테이블에 새로운 영화 레코드 추가에 실패했습니다.";
	} finally {
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException sqle) {
			}
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>영화 예약 시스템</title>
</head>

<script>
	alert("영화 삽입 완료!");
	window.close();
</script>
</html>