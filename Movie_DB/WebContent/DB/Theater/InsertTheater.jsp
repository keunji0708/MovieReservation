<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page
	import="java.sql.*, java.util.Date"%>
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String theaterID = request.getParameter("theaterID");
	String theaterName = request.getParameter("theaterName");
	String address = request.getParameter("address");
	String telephone = request.getParameter("telephone");

	Connection conn = null;
	PreparedStatement pstmt = null;
	String str = "";

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
		String dbId = "root";
		String dbPass = "awef1322";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "insert into theater_table values(?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, 0);
		pstmt.setString(2, theaterName); //영화관 이름
		pstmt.setString(3, address);
		pstmt.setString(4, telephone);
		
		if (theaterName.equals("")){
			%>
			<script>
			alert("등록 실패!");
			window.close();
		</script>
		<%
		}
		else
			pstmt.executeUpdate();

		str = "theater 테이블에 새로운 영화관 레코드를 추가했습니다.";
	} catch (Exception e) {
		e.printStackTrace();
		str = "theater 테이블에 새로운 영화관 레코드 추가에 실패했습니다.";
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
	alert("영화관 삽입 완료");
	window.close();
</script>
</html>