package jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JdbcUtil {
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if (conn != null) {
			try {
				conn.close();
		
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (rs != null) {
			try {
				rs.close();
		
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (pstmt != null) {
			try {
				pstmt.close();
		
			}catch (Exception e) {
				e.printStackTrace();
			}
		}	
	}
}
