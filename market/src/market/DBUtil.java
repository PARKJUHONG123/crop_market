package market;

import java.sql.*;
public class DBUtil {
	public static Connection getMySQLConnection() {
		Connection conn = null;
		try {		
			String url = "jdbc:oracle:thin:@localhost:1521:oraknu";
			String user = "dbproj";
			String pass = "qwe123!@#";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url,user,pass);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버가 없습니다.<br/>");
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	public static void close(Connection conn) {
		try {if(conn != null) {conn.close();}}catch(Exception e) {e.printStackTrace();}
	}
	public static void close(Statement stmt) {
		try {if(stmt != null) {stmt.close();}}catch(Exception e) {e.printStackTrace();}
	}
	public static void close(PreparedStatement pstmt) {
		try {if(pstmt != null) {pstmt.close();}}catch(Exception e) {e.printStackTrace();}
	}
	public static void close(ResultSet rs) {
		try {if(rs != null) {rs.close();}}catch(Exception e) {e.printStackTrace();}
	}
}