package book;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;

public class BookDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public BookDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "C##mini";
			String dbPassword = "1234";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
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
	
	// 전체 책 리스트 획득
	public ArrayList<Book> getList(int category) {
		String SQL = "SELECT * from BOOK WHERE BOOKCATEGORY = ?";
		ArrayList<Book> list = new ArrayList<Book>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, category);
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
}
