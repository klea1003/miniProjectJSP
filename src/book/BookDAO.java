package book;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.Context;
import javax.sql.DataSource;

public class BookDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	static private int bookInPage = 12;

	public BookDAO() {
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:/comp/env/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//하나의 책을 보는 메소드
		public Book getBook(int bookID) {
			String sql = "SELECT * FROM BOOK WHERE BOOKID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bookID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					Book book = new Book();
					book.setBookID(rs.getInt(1));
					book.setBookTitle(rs.getString(2));
					book.setBookPrice(rs.getInt(3));
					book.setBookAuthor(rs.getString(4));
					book.setBookCategory(rs.getInt(5));
					book.setBookPublisher(rs.getString(6));
					book.setBookImagePath(rs.getString(7));
					return book;
				}
				return null;
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
	//책 번호 부여 메소드
	public int getNext() {
		//현재 책을 내림차순으로 조회하여 가장 마지막 책의 번호를 구한다
		String sql = "select bookID from BOOK order by bookID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 책일 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 책 리스트 획득
	public ArrayList<Book> getList(int category, int pageNumber) {
		String SQL = String.format("SELECT * from (SELECT * FROM BOOK WHERE BOOKCATEGORY = ? AND bookID < ? ORDER BY bookID DESC) WHERE ROWNUM <= %d", bookInPage);
		ArrayList<Book> list = new ArrayList<Book>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, category);
			pstmt.setInt(2, getNext() - (pageNumber - 1) * bookInPage);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Book book = new Book();
				book.setBookID(rs.getInt(1));
				book.setBookTitle(rs.getString(2));
				book.setBookPrice(rs.getInt(3));
				book.setBookAuthor(rs.getString(4));
				book.setBookCategory(rs.getInt(5));
				book.setBookPublisher(rs.getString(6));
				book.setBookImagePath(rs.getString(7));				
				
				list.add(book);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 전체 책 리스트 반환
	}
	
	public boolean nextPage(int category, int pageNumber) {
		String SQL = "SELECT * from BOOK WHERE BOOKCATEGORY = ? AND bookID < ?";
		ArrayList<Faq> list = new ArrayList<Faq>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, category);
			pstmt.setInt(2, getNext() - (pageNumber - 1) * bookInPage);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
