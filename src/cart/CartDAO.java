package cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;

public class CartDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public CartDAO() {
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
	
	public int getNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select cartID from CART order by cartID desc";
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
	
	public int addCart(int bookID, String userID, int bookAmount) {
		String sql = "insert into CART values (?, ?, ?, ?, TO_DATE(?, 'MM-DD-YYYY HH24:MI:SS'), 0)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, bookID);
			pstmt.setString(3, userID);
			pstmt.setInt(4, bookAmount);
			pstmt.setString(5, getDate());
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Cart> getCartList(String userID) {
		String sql = "SELECT * FROM CART WHERE userID = ?";
		ArrayList<Cart> list = new ArrayList<Cart>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Cart cart = new Cart();
				
				cart.setCartID(rs.getInt(1));
				cart.setBookID(rs.getInt(2));
				cart.setUserID(rs.getString(3));
				cart.setBookAmount(rs.getInt(4));
				cart.setCartDate(rs.getString(5));
				
				list.add(cart);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<CartStock> getStockList(String userID) {
		String sql = "select b.bookID, b.bookTitle, b.bookPrice, SUM(c.BOOKAMOUNT) as TotalAmount, SUM(b.bookPrice*c.bookAmount) as TotalPrice "
				+ "from cart c, book b "
				+ "where c.bookid = b.bookid and c.userID = ? and orderCompleted = 0 "
				+ "group by b.bookID, b.bookTitle, b.bookPrice";
		ArrayList<CartStock> list = new ArrayList<CartStock>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CartStock cartStock = new CartStock();
				
				cartStock.setBookID(rs.getInt(1));
				cartStock.setBookTitle(rs.getString(2));
				cartStock.setBookPrice(rs.getInt(3));
				cartStock.setBookAmount(rs.getInt(4));
				cartStock.setTotalPrice(rs.getInt(5));
				
				list.add(cartStock);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int order(int bookID, String userID) {
		//실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으로 수정한다
		String sql = "update CART set ORDERCOMPLETED = 1 where bookID = ? and userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bookID);
			pstmt.setString(2, userID);			
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
	
}
