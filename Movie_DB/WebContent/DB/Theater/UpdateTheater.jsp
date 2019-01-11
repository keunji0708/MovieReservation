<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
   request.setCharacterEncoding("euc-kr");
%>

<%
   String theaterID = request.getParameter("theaterID");
   String theaterName = request.getParameter("theaterName");
   String address = request.getParameter("address");
   String telephone = request.getParameter("telephone");

   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;

   try {
      String jdbcUrl = "jdbc:mysql://localhost:3306/dbTermp";
      String dbId = "root";
      String dbPass = "awef1322";

      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      String sql = "select t.theaterID, t.theaterName, t.address, t.telephone from theater_table t where theaterID=? ";

      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, theaterID);

      rs = pstmt.executeQuery();

      if (rs.next()) {
         String rID = rs.getString("theaterID");
         String rtheaterName = rs.getString("theaterName");
         String raddress = rs.getString("address");
         String rtelephone = rs.getString("telephone");      

         if (theaterID.equals(rID)) {
            sql = "update theater_table set theaterName = ?, address= ?,telephone= ? where theaterID = ?";
            pstmt = conn.prepareStatement(sql);
            
            if(theaterName.equals(""))
               theaterName = rtheaterName;
            pstmt.setString(1, theaterName);
            
            if(address.equals(""))
               address = raddress;
            pstmt.setString(2, address);
            
            if(telephone.equals(""))
               telephone = rtelephone;
            pstmt.setString(3, telephone);
            
            pstmt.setString(4, theaterID);

            pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>영화 예약 시스템</title>
</head>
<script>
   alert("수정 완료!");
   window.close();
</script>
</html>

<%
   }
      } else {
         out.println("영화관 이름 또는 영화 ID가 틀렸습니다");
      }
   } catch (Exception e) {
      e.printStackTrace();
   } finally {
      if (rs != null)
         try {
            rs.close();
         } catch (SQLException sqle) {
         }
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
