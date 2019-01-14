<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("euc-kr");%>

<%
	int movieID = Integer.parseInt(request.getParameter("myselect"));
	int screenID = Integer.parseInt(request.getParameter("screenID"));
	String date = request.getParameter("date");
	String time = request.getParameter("time");

	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";
	ResultSet rs = null;

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
		String dbId = "root";
		String dbPass = "awef1322";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "insert into timetable_table value(?, ?, addtime(date, (select runningTime from movie_table where movieID = ?)), ?, ?);";
		String dateTime = date + " " + time + ":00:00";

		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, 0);
		pstmt.setString(2, dateTime);
		pstmt.setInt(3, movieID);
		pstmt.setInt(4, screenID);
		pstmt.setInt(5, movieID);
		pstmt.executeUpdate();

		int timetableID = 0;
		
		sql = "select timetableID from timetable_table order by timetableID desc;";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			timetableID = rs.getInt("timetableID");
		}
		
		sql = "select seat from screen_table where screenID = ?;";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, screenID);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			for (int i = 1; i <= rs.getInt("seat"); i++) {
				sql = "insert into seat_table values(0, ?, ?, false);";

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, timetableID);
				pstmt.setInt(2, i);

				pstmt.executeUpdate();
			}
		}
		str = "타임테이블에 새로운 시간표를 추가했습니다.";
	} catch (Exception e) {
		e.printStackTrace();
		str = "타임테이블에 새로운 시간표를 추가에 실패했습니다.";
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
	alert("타임테이블에 새로운 시간표를 삽입 완료");
	window.close();
</script>
</html>