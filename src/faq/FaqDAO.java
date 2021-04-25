package faq;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FaqDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public FaqDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@klea-home.iptime.org:1521:xe";
			String dbID = "c##mini";
			String dbPassword = "1234";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS')  FROM DUAL";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	//글쓰기 메소드
	public int write(String faqTitle, String userID, String faqContent) {
		String sql = "insert into FAQ values (?, ?, ?, TO_DATE(?, 'MM-DD-YYYY HH24:MI:SS'), ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, faqTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, faqContent);
			pstmt.setInt(6, 1); //글의 유효번호
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	//게시글 번호 부여 메소드
	public int getNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select faqID from FAQ order by faqID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 전체 게시글 리스트 획득
	public ArrayList<Faq> getList(int pageNumber) {
		String SQL = "SELECT * from (SELECT * FROM FAQ WHERE faqID < ? AND faqAvailable = 1 ORDER BY faqID DESC) WHERE ROWNUM <= 10";
		ArrayList<Faq> list = new ArrayList<Faq>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // todo. pageNumber 확인
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Faq faq = new Faq();
				faq.setFaqID(rs.getInt(1));
				faq.setFaqTitle(rs.getString(2));
				faq.setUserID(rs.getString(3));
				faq.setFaqDate(rs.getString(4));
				faq.setFaqContent(rs.getString(5));
				faq.setFaqAvailable(rs.getInt(6));
				list.add(faq);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 전체 게시물 반환
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * from FAQ WHERE faqID < ? AND faqAvailable = 1";
		ArrayList<Faq> list = new ArrayList<Faq>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // todo. pageNumber 확인
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//하나의 게시글을 보는 메소드
	public Faq getFaq(int faqID) {
		String sql = "select * from FAQ where faqID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, faqID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Faq faq = new Faq();
				faq.setFaqID(rs.getInt(1));
				faq.setFaqTitle(rs.getString(2));
				faq.setUserID(rs.getString(3));
				faq.setFaqDate(rs.getString(4));
				faq.setFaqContent(rs.getString(5));
				faq.setFaqAvailable(rs.getInt(6));
				return faq;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//게시글 수정 메소드
	public int update(int faqID, String faqTitle, String faqContent) {
		String sql = "update faq set faqTitle = ?, faqContent = ? where faqID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, faqTitle);
			pstmt.setString(2, faqContent);
			pstmt.setInt(3, faqID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	//게시글 삭제 메소드
	public int delete(int faqID) {
		//실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으로 수정한다
		String sql = "update faq set faqAvailable = 0 where faqID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, faqID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
}
